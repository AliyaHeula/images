//
//  ImageToShow.swift
//  images
//
//  Created by Aliya on 13.09.2023.
//

import Foundation
import SwiftUI

enum NetworkErrors: Error {
    case statusCodeNot200
    case JSONDecodingError
    case URLIssue
    case overallError
    case cacheIssue
    case imageDownloadingIssue
    case limitExceed
    case onTheTopOfCache
    case accessDenied
}

final class ImageToShow {
    private(set) var authorName = ""

    private lazy var image = UIImage()
    private let sessionConfiguration: URLSessionConfiguration
    private let session: URLSession

    private let cache = URLCache.shared
    private var previousPicturesRequestArray = Array<URLRequest>()
    private var previousPictureIndex = -1

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

    let tmp = Bundle.main.infoDictionary
    private let urlRequest: URLRequest

    init() {
        sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.timeoutIntervalForRequest = 0

        session = URLSession(configuration: sessionConfiguration)

        let fullURL = baseURL.appending(queryItems: queryItems)
        urlRequest = URLRequest(url: fullURL)
    }

    func getPreviousPicture() async throws -> UIImage {
        previousPictureIndex -= 1
        if previousPictureIndex == -1 {
            previousPictureIndex = 0
            throw NetworkErrors.onTheTopOfCache
        }
        let uiImage = try await checkRequestWithURL(pictureRequest:previousPicturesRequestArray[previousPictureIndex])
        return uiImage

    }

    func getPicture() async throws -> UIImage {
        print(urlRequest)
        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.statusCodeNot200
        }
        guard response.statusCode == 200 else {
            print(response)
            if response.statusCode == 403 {
                throw NetworkErrors.limitExceed
            } else if response.statusCode == 401 {
                throw NetworkErrors.accessDenied
            }
            throw NetworkErrors.statusCodeNot200
        }
        guard let unsplashPicture = try? JSONDecoder().decode([UnsplashPicture].self, from: data) else {
            throw NetworkErrors.JSONDecodingError
        }
        guard let smallURLString = unsplashPicture.first?.urls.small, let smallURL = URL(string: smallURLString) else {
            print("unavailable string")
            throw NetworkErrors.URLIssue
        }
        
        if let name = unsplashPicture.first?.user.name {
            authorName = name
        } else {
            authorName = ""
        }

        print(smallURL)
        let pictureRequest = URLRequest(url: smallURL)
        return try await checkRequestWithURL(pictureRequest: pictureRequest)
    }

    func checkRequestWithURL(pictureRequest: URLRequest) async throws -> UIImage {
        if cache.cachedResponse(for: pictureRequest) == nil {
            return try await downloadPicture(pictureRequest: pictureRequest)
        } else {
            return try await getCachedPicture(pictureRequest: pictureRequest)
        }
    }

    func downloadPicture(pictureRequest: URLRequest) async throws -> UIImage {
        let (data, response) = try await session.data(for: pictureRequest)
        guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            throw NetworkErrors.overallError
        }
        guard let uiImage = UIImage(data: data) else {
            throw NetworkErrors.imageDownloadingIssue
        }
        let cachedImage = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cachedImage, for: pictureRequest)
        
        if previousPictureIndex == previousPicturesRequestArray.count - 1 {
            previousPicturesRequestArray.append(pictureRequest)
        } else {
            previousPicturesRequestArray = previousPicturesRequestArray[0...previousPictureIndex] + [pictureRequest]
        }
        previousPictureIndex += 1
        return uiImage
    }

    func getCachedPicture(pictureRequest: URLRequest) async throws -> UIImage {
        guard let data = cache.cachedResponse(for: pictureRequest)?.data, let uiImage = UIImage(data: data) else {
            throw NetworkErrors.cacheIssue
        }
        print("taken from Cache")
        return uiImage
    }

    func testAlerts() async throws -> UIImage {
        throw NetworkErrors.statusCodeNot200
    }
}
