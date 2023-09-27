//
//  ImageToShow.swift
//  images
//
//  Created by Aliya on 13.09.2023.
//

import Foundation
import SwiftUI

struct ImageToShow {
    private(set) var authorName = ""
    private(set) var uiImage: UIImage?
    private(set) var alertText = ""

    private let networkService = NetworkService()
    private let imagesCache = ImagesCache()

    private var previousPicturesRequestArray = Array<(URLRequest, String)>()
    private var previousPictureIndex = -1
    var isPreviousImageInactive: Bool {
        return previousPictureIndex <= 0
    }

    mutating func getPreviousPicture() async throws {
        do {
            previousPictureIndex = previousPictureIndex == -1 ? 0 : previousPictureIndex - 1
            uiImage = try await checkRequestWithURL(pictureRequest:previousPicturesRequestArray[previousPictureIndex].0)
            authorName = previousPicturesRequestArray[previousPictureIndex].1
        } catch {
            alertText = "Something went wrong"
            throw error
        }
    }

    mutating func getNextPicture() async throws {
        do {
            let data = try await networkService.networkRequest()

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
        } catch NetworkErrors.statusCodeIsNot200(let status) {
            alertText = ResponseCode.alertTextFromStatusCode(status)
            throw NetworkErrors.statusCodeIsNot200(status)
        } catch {
            alertText = "Something went wrong"
            throw error
        }
    }

    private mutating func checkRequestWithURL(pictureRequest: URLRequest) async throws -> UIImage {
        if imagesCache.hasInCache(request: pictureRequest) {
            return try await getCachedPicture(pictureRequest: pictureRequest)
        } else {
            return try await downloadPicture(pictureRequest: pictureRequest)
        }
    }

    private mutating func downloadPicture(pictureRequest: URLRequest) async throws -> UIImage {
        let (data, response) = try await networkService.networkRequest(urlRequstt: pictureRequest)
        guard let uiImage = UIImage(data: data) else {
            throw NetworkErrors.imageFormatIssue
        }
        imagesCache.addToCache(request: pictureRequest, response: response, data: data)
        updatePreviousPictureArray(pictureRequest: pictureRequest)
        return uiImage
    }

    private mutating func updatePreviousPictureArray(pictureRequest: URLRequest) {
        let newElement = (pictureRequest, authorName)
        if previousPictureIndex == previousPicturesRequestArray.count - 1 {
            previousPicturesRequestArray.append(newElement)
        } else {
            previousPicturesRequestArray = previousPicturesRequestArray[0...previousPictureIndex] + [newElement]
        }
        previousPictureIndex += 1
    }

    private func getCachedPicture(pictureRequest: URLRequest) async throws -> UIImage {
        let data = try imagesCache.getFromCache(request: pictureRequest)
        guard let uiImage = UIImage(data: data) else {
            throw NetworkErrors.cacheIssue
        }
        print("taken from Cache")
        return uiImage
    }
}
