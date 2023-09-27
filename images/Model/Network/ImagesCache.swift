//
//  ImagesCache.swift
//  images
//
//  Created by Aliya on 27.09.2023.
//

import Foundation

struct ImagesCache {
    private let cache = URLCache.shared

    func hasInCache(request: URLRequest) -> Bool {
        if cache.cachedResponse(for: request) == nil {
            return false
        }
        return true
    }

    func addToCache(request: URLRequest, response: URLResponse, data: Data) {
        let cachedImage = CachedURLResponse(response: response, data: data)
        cache.storeCachedResponse(cachedImage, for: request)
    }

    func getFromCache(request: URLRequest) throws -> Data {
        guard let data = cache.cachedResponse(for: request)?.data else {
            throw NetworkErrors.cacheIssue
        }
        return data
    }
}
