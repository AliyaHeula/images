//
//  ResponseCode.swift
//  images
//
//  Created by Aliya on 27.09.2023.
//

enum ResponseCode: Int {
    case statusCode401 = 401
    case statusCode403 = 403

    static func alertTextFromStatusCode(_ statusCode: Int) -> String {
        switch statusCode {
        case 403:
            return "Requests limit exceeded. Please try again in the next hour"
        case 401:
            return "Access is denied"
        default:
            return "Error \(statusCode) has appeared"
        }
    }
}
