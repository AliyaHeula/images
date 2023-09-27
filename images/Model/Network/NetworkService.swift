//
//  NetworkService.swift
//  images
//
//  Created by Aliya on 13.09.2023.
//

import Foundation

struct NetworkService {
    private let sessionConfiguration: URLSessionConfiguration
    private let session: URLSession

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

    init() {
        sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.waitsForConnectivity = true
        sessionConfiguration.timeoutIntervalForResource = 300

        session = URLSession(configuration: sessionConfiguration)

        let fullURL = baseURL.appending(queryItems: queryItems)
        urlRequest = URLRequest(url: fullURL)
    }

    func networkRequest() async throws -> Data {
        let (data, response) = try await session.data(for: urlRequest)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.notHTTPResponse
        }
        guard response.statusCode == 200 else {
            throw NetworkErrors.statusCodeIsNot200(response.statusCode)
        }
        return data
    }

    func networkRequest(urlRequstt: URLRequest) async throws -> (Data, HTTPURLResponse) {
        let (data, response) = try await session.data(for: urlRequstt)
        guard let response = response as? HTTPURLResponse else {
            throw NetworkErrors.notHTTPResponse
        }
        guard response.statusCode == 200 else {
            throw NetworkErrors.statusCodeIsNot200(response.statusCode)
        }
        return (data, response)
    }
}
