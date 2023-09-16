//
//  UnsplashPicture.swift
//  images
//
//  Created by Aliya on 12.09.2023.
//

import Foundation

struct UnsplashPicture: Codable {
//        let id, slug: String
//        let createdAt, updatedAt, promotedAt: Date
//        let width, height: Int
//        let color, blurHash: String
//        let description: String?
//        let altDescription: String
//        let breadcrumbs: [String?]
    let urls: Urls
//        let links: WelcomeLinks
//        let likes: Int
//        let likedByUser: Bool
//        let currentUserCollections: [String?]
//        let sponsorship: String?
//        let topicSubmissions: TopicSubmissions
        let user: User
//        let exif: Exif
//        let location: Location
//        let views, downloads: Int
//
//        enum CodingKeys: String, CodingKey {
//            case id, slug
//            case createdAt = "created_at"
//            case updatedAt = "updated_at"
//            case promotedAt = "promoted_at"
//            case width, height, color
//            case blurHash = "blur_hash"
//            case description
//            case altDescription = "alt_description"
//            case breadcrumbs, urls, links, likes
//            case likedByUser = "liked_by_user"
//            case currentUserCollections = "current_user_collections"
//            case sponsorship
//            case topicSubmissions = "topic_submissions"
//            case user, exif, location, views, downloads
//        }
    }

    // MARK: - Exif
struct Exif: Codable {
        let make, model, name, exposureTime: String
        let aperture, focalLength: String
        let iso: Int
    }

    // MARK: - WelcomeLinks
struct WelcomeLinks: Codable {
        let linksSelf, html, download, downloadLocation: String
    }

    // MARK: - Location
struct Location: Codable {
        let name, city, country: String?
        let position: Position
    }

    // MARK: - Position
struct Position: Codable {
        let latitude, longitude: Int
    }

    // MARK: - TopicSubmissions
struct TopicSubmissions: Codable {
    }

    // MARK: - Urls
struct Urls: Codable {
        let raw, full, regular, small: String?
        let thumb, smallS3: String?
        enum CodingKeys: String, CodingKey {
            case raw, full, regular, small, thumb
            case smallS3 = "small_s3"
        }
    }

    // MARK: - User
struct User: Codable {
//        let id: String
//        let updatedAt: Date

    let name: String

//        let username, name, firstName: String
//        let lastName, twitterUsername: String?
//        let portfolioURL: String
//        let bio, location: String
//        let links: UserLinks
//        let profileImage: ProfileImage
//        let instagramUsername: String
//        let totalCollections, totalLikes, totalPhotos: Int
//        let acceptedTos, forHire: Bool
//        let social: Social
    }

    // MARK: - UserLinks
struct UserLinks: Codable {
        let linksSelf, html, photos, likes: String
        let portfolio, following, followers: String
    }

    // MARK: - ProfileImage
struct ProfileImage: Codable {
        let small, medium, large: String
    }

    // MARK: - Social
struct Social: Codable {
        let instagramUsername: String
        let portfolioURL: String
        let twitterUsername, paypalEmail: String?
    }

//import Foundation
//
//// MARK: - WelcomeElement
//struct UnsplashPicture: Codable {
//    let id, slug: String
//    let createdAt, updatedAt, promotedAt: Date
//    let width, height: Int
//    let color, blurHash: String
//    let description: JSONNull?
//    let altDescription: String
//    let breadcrumbs: [JSONAny]
//    let urls: Urls
//    let links: WelcomeLinks
//    let likes: Int
//    let likedByUser: Bool
//    let currentUserCollections: [JSONAny]
//    let sponsorship: JSONNull?
//    let topicSubmissions: TopicSubmissions
//    let user: User
//    let exif: Exif
//    let location: Location
//    let views, downloads: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id, slug
//        case createdAt = "created_at"
//        case updatedAt = "updated_at"
//        case promotedAt = "promoted_at"
//        case width, height, color
//        case blurHash = "blur_hash"
//        case description
//        case altDescription = "alt_description"
//        case breadcrumbs, urls, links, likes
//        case likedByUser = "liked_by_user"
//        case currentUserCollections = "current_user_collections"
//        case sponsorship
//        case topicSubmissions = "topic_submissions"
//        case user, exif, location, views, downloads
//    }
//}
//
//// MARK: - Exif
//struct Exif: Codable {
//    let make, model, name, exposureTime: String
//    let aperture, focalLength: String
//    let iso: Int
//
//    enum CodingKeys: String, CodingKey {
//        case make, model, name
//        case exposureTime = "exposure_time"
//        case aperture
//        case focalLength = "focal_length"
//        case iso
//    }
//}
//
//// MARK: - WelcomeLinks
//struct WelcomeLinks: Codable {
//    let linksSelf, html, download, downloadLocation: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case html, download
//        case downloadLocation = "download_location"
//    }
//}
//
//// MARK: - Location
//struct Location: Codable {
//    let name, city, country: JSONNull?
//    let position: Position
//}
//
//// MARK: - Position
//struct Position: Codable {
//    let latitude, longitude: Int
//}
//
//// MARK: - TopicSubmissions
//struct TopicSubmissions: Codable {
//}
//
//// MARK: - Urls
//struct Urls: Codable {
//    let raw, full, regular, small: String
//    let thumb, smallS3: String
//
//    enum CodingKeys: String, CodingKey {
//        case raw, full, regular, small, thumb
//        case smallS3 = "small_s3"
//    }
//}
//
//// MARK: - User
//struct User: Codable {
//    let id: String
//    let updatedAt: Date
//    let username, name, firstName: String
//    let lastName, twitterUsername: JSONNull?
//    let portfolioURL: String
//    let bio, location: String
//    let links: UserLinks
//    let profileImage: ProfileImage
//    let instagramUsername: String
//    let totalCollections, totalLikes, totalPhotos: Int
//    let acceptedTos, forHire: Bool
//    let social: Social
//
//    enum CodingKeys: String, CodingKey {
//        case id
//        case updatedAt = "updated_at"
//        case username, name
//        case firstName = "first_name"
//        case lastName = "last_name"
//        case twitterUsername = "twitter_username"
//        case portfolioURL = "portfolio_url"
//        case bio, location, links
//        case profileImage = "profile_image"
//        case instagramUsername = "instagram_username"
//        case totalCollections = "total_collections"
//        case totalLikes = "total_likes"
//        case totalPhotos = "total_photos"
//        case acceptedTos = "accepted_tos"
//        case forHire = "for_hire"
//        case social
//    }
//}
//
//// MARK: - UserLinks
//struct UserLinks: Codable {
//    let linksSelf, html, photos, likes: String
//    let portfolio, following, followers: String
//
//    enum CodingKeys: String, CodingKey {
//        case linksSelf = "self"
//        case html, photos, likes, portfolio, following, followers
//    }
//}
//
//// MARK: - ProfileImage
//struct ProfileImage: Codable {
//    let small, medium, large: String
//}
//
//// MARK: - Social
//struct Social: Codable {
//    let instagramUsername: String
//    let portfolioURL: String
//    let twitterUsername, paypalEmail: JSONNull?
//
//    enum CodingKeys: String, CodingKey {
//        case instagramUsername = "instagram_username"
//        case portfolioURL = "portfolio_url"
//        case twitterUsername = "twitter_username"
//        case paypalEmail = "paypal_email"
//    }
//}
//
//typealias Welcome = [UnsplashPicture]
//
//// MARK: - Encode/decode helpers
//
//class JSONNull: Codable, Hashable {
//
//    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
//        return true
//    }
//
//    public var hashValue: Int {
//        return 0
//    }
//
//    public init() {}
//
//    public required init(from decoder: Decoder) throws {
//        let container = try decoder.singleValueContainer()
//        if !container.decodeNil() {
//            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        var container = encoder.singleValueContainer()
//        try container.encodeNil()
//    }
//}
//
//class JSONCodingKey: CodingKey {
//    let key: String
//
//    required init?(intValue: Int) {
//        return nil
//    }
//
//    required init?(stringValue: String) {
//        key = stringValue
//    }
//
//    var intValue: Int? {
//        return nil
//    }
//
//    var stringValue: String {
//        return key
//    }
//}
//
//class JSONAny: Codable {
//
//    let value: Any
//
//    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
//        let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
//        return DecodingError.typeMismatch(JSONAny.self, context)
//    }
//
//    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
//        let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
//        return EncodingError.invalidValue(value, context)
//    }
//
//    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if container.decodeNil() {
//            return JSONNull()
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
//        if let value = try? container.decode(Bool.self) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self) {
//            return value
//        }
//        if let value = try? container.decode(Double.self) {
//            return value
//        }
//        if let value = try? container.decode(String.self) {
//            return value
//        }
//        if let value = try? container.decodeNil() {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer() {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
//        if let value = try? container.decode(Bool.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Int64.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(Double.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decode(String.self, forKey: key) {
//            return value
//        }
//        if let value = try? container.decodeNil(forKey: key) {
//            if value {
//                return JSONNull()
//            }
//        }
//        if var container = try? container.nestedUnkeyedContainer(forKey: key) {
//            return try decodeArray(from: &container)
//        }
//        if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
//            return try decodeDictionary(from: &container)
//        }
//        throw decodingError(forCodingPath: container.codingPath)
//    }
//
//    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
//        var arr: [Any] = []
//        while !container.isAtEnd {
//            let value = try decode(from: &container)
//            arr.append(value)
//        }
//        return arr
//    }
//
//    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
//        var dict = [String: Any]()
//        for key in container.allKeys {
//            let value = try decode(from: &container, forKey: key)
//            dict[key.stringValue] = value
//        }
//        return dict
//    }
//
//    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
//        for value in array {
//            if let value = value as? Bool {
//                try container.encode(value)
//            } else if let value = value as? Int64 {
//                try container.encode(value)
//            } else if let value = value as? Double {
//                try container.encode(value)
//            } else if let value = value as? String {
//                try container.encode(value)
//            } else if value is JSONNull {
//                try container.encodeNil()
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer()
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
//        for (key, value) in dictionary {
//            let key = JSONCodingKey(stringValue: key)!
//            if let value = value as? Bool {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Int64 {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? Double {
//                try container.encode(value, forKey: key)
//            } else if let value = value as? String {
//                try container.encode(value, forKey: key)
//            } else if value is JSONNull {
//                try container.encodeNil(forKey: key)
//            } else if let value = value as? [Any] {
//                var container = container.nestedUnkeyedContainer(forKey: key)
//                try encode(to: &container, array: value)
//            } else if let value = value as? [String: Any] {
//                var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
//                try encode(to: &container, dictionary: value)
//            } else {
//                throw encodingError(forValue: value, codingPath: container.codingPath)
//            }
//        }
//    }
//
//    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
//        if let value = value as? Bool {
//            try container.encode(value)
//        } else if let value = value as? Int64 {
//            try container.encode(value)
//        } else if let value = value as? Double {
//            try container.encode(value)
//        } else if let value = value as? String {
//            try container.encode(value)
//        } else if value is JSONNull {
//            try container.encodeNil()
//        } else {
//            throw encodingError(forValue: value, codingPath: container.codingPath)
//        }
//    }
//
//    public required init(from decoder: Decoder) throws {
//        if var arrayContainer = try? decoder.unkeyedContainer() {
//            self.value = try JSONAny.decodeArray(from: &arrayContainer)
//        } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
//            self.value = try JSONAny.decodeDictionary(from: &container)
//        } else {
//            let container = try decoder.singleValueContainer()
//            self.value = try JSONAny.decode(from: container)
//        }
//    }
//
//    public func encode(to encoder: Encoder) throws {
//        if let arr = self.value as? [Any] {
//            var container = encoder.unkeyedContainer()
//            try JSONAny.encode(to: &container, array: arr)
//        } else if let dict = self.value as? [String: Any] {
//            var container = encoder.container(keyedBy: JSONCodingKey.self)
//            try JSONAny.encode(to: &container, dictionary: dict)
//        } else {
//            var container = encoder.singleValueContainer()
//            try JSONAny.encode(to: &container, value: self.value)
//        }
//    }
//}
