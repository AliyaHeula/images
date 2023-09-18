//
//  NetworkErrors.swift
//  images
//
//  Created by Aliya on 16.09.2023.
//

import Foundation

enum NetworkErrors: Error {
    case statusCodeNot200
    case JSONDecodingError
    case URLIssue
    case overallError
    case cacheIssue
    case imageDownloadingIssue
    case limitExceed
    case accessDenied
}
