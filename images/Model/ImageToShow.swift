//
//  ImageToShow.swift
//  images
//
//  Created by Aliya on 13.09.2023.
//

import Foundation
import SwiftUI



struct ImageToShow {
    //MARK: - Properties and initialization

    private(set) var authorName = ""
    private(set) var uiImage: UIImage?
    private(set) var alertText = ""
    var isPreviousImageInactive: Bool {
        return previousPictureIndex <= 0
    }
    
    private let sessionConfiguration: URLSessionConfiguration
    private let session: URLSession
    private let cache = URLCache.shared
    private let urlRequest: URLRequest
    private var baseURL: URL = {
        URL("https://api.unsplash.com/photos/random/")
    }()
    private var queryItems: Array<URLQueryItem> = {
        var clientIdValue = ""
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist"),
           let config = NSDictionary(contentsOfFile: path),
           let apiKey = config["API_KEY"] as? String {
            clientIdValue = apiKey
        }
        return [URLQueryItem(name: "client_id", value: clientIdValue),
                URLQueryItem(name: "count", value: "1")]
    }()

    private var previousPicturesRequestArray = Array<(URLRequest, String)>()
    private var previousPictureIndex = -1

    init() {
        sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.waitsForConnectivity = true
        sessionConfiguration.timeoutIntervalForResource = 300
        
        session = URLSession(configuration: sessionConfiguration)

        let fullURL = baseURL.appending(queryItems: queryItems)
        urlRequest = URLRequest(url: fullURL)
    }

    //MARK: - Methods

    mutating func getPreviousPicture() async throws {
        previousPictureIndex = previousPictureIndex == -1 ? 0 : previousPictureIndex - 1
        uiImage = try await checkRequestWithURL(pictureRequest:previousPicturesRequestArray[previousPictureIndex].0)
        authorName = previousPicturesRequestArray[previousPictureIndex].1
    }

    mutating func getNextPicture() async throws {
        let (data, response): (Data?, URLResponse?) = try await withCheckedThrowingContinuation { continuation in
            session.dataTask(with: urlRequest) {data, response, error in
                if let error = error {
                    continuation.resume(throwing: error)
                } else {
                    continuation.resume(returning: (data, response))
                }
            }.resume()
        }

        guard let response = response as? HTTPURLResponse,
              let data = data else {
            throw NetworkErrors.statusCodeNot200
        }
        guard response.statusCode == 200 else {
            print(response)
            switch response.statusCode {
            case 403:
                alertText = "Requests limit exceeded. Please try again in the next hour"
                throw NetworkErrors.limitExceed
            case 401:
                alertText = "Access is denied"
                throw NetworkErrors.accessDenied
            default:
                alertText = "Error \(response.statusCode) has appeared"
                throw NetworkErrors.statusCodeNot200
            }
        }
        guard let unsplashPicture = try? JSONDecoder().decode([UnsplashPicture].self, from: data) else {
            throw NetworkErrors.JSONDecodingError
        }
        guard let smallURLString = unsplashPicture.first?.urls.small,
              let smallURL = URL(string: smallURLString) else {
            throw NetworkErrors.URLIssue
        }

        authorName = unsplashPicture.first?.user.name ?? ""

        let pictureRequest = URLRequest(url: smallURL)
        uiImage = try await checkRequestWithURL(pictureRequest: pictureRequest)

    }

    mutating private func checkRequestWithURL(pictureRequest: URLRequest) async throws -> UIImage {
        if cache.cachedResponse(for: pictureRequest) == nil {
            return try await downloadPicture(pictureRequest: pictureRequest)
        } else {
            return try await getCachedPicture(pictureRequest: pictureRequest)
        }
    }

    mutating private func downloadPicture(pictureRequest: URLRequest) async throws -> UIImage {
        let (data, response) = try await session.data(for: pictureRequest)
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200 else {
            throw NetworkErrors.overallError
        }
        guard let uiImage = UIImage(data: data) else {
            throw NetworkErrors.imageDownloadingIssue
        }
        let cachedImage = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cachedImage, for: pictureRequest)
        let newElement = (pictureRequest, authorName)
        if previousPictureIndex == previousPicturesRequestArray.count - 1 {
            previousPicturesRequestArray.append(newElement)
        } else {
            previousPicturesRequestArray = previousPicturesRequestArray[0...previousPictureIndex] + [newElement]
        }
        previousPictureIndex += 1
        return uiImage
    }

    private func getCachedPicture(pictureRequest: URLRequest) async throws -> UIImage {
        guard let data = cache.cachedResponse(for: pictureRequest)?.data,
              let uiImage = UIImage(data: data) else {
            throw NetworkErrors.cacheIssue
        }
        print("taken from Cache")
        return uiImage
    }
}
