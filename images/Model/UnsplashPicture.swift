//
//  UnsplashPicture.swift
//  images
//
//  Created by Aliya on 12.09.2023.
//

import Foundation

struct UnsplashPicture: Codable {
    let urls: Urls
    let user: User
}

struct User: Codable {
    let name: String
}

struct Urls: Codable {
    let raw, full, regular, small: String?
}
