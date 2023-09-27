//
//  NetworkErrors.swift
//  images
//
//  Created by Aliya on 16.09.2023.
//

enum NetworkErrors: Error {
    case notHTTPResponse
    case statusCodeIsNot200(Int)
    case JSONDecodingError
    case URLIssue
    case cacheIssue
    case imageFormatIssue
}
