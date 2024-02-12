//
//  PhotosModel.swift
//  pr1
//
//  Created by Никита Попов on 12.02.24.
//
import Foundation

// MARK: - Photos
struct Photos: Codable {
    let response: ResponsePH
}

// MARK: - Response
struct ResponsePH: Codable {
    let count: Int
    let items: [ItemPH]
    let nextFrom: String

    enum CodingKeys: String, CodingKey {
        case count, items
        case nextFrom = "next_from"
    }
}

// MARK: - Item
struct ItemPH: Codable {
    let albumID, date, id, ownerID: Int
    let sizes: [Size]
    let squareCrop, text, webViewToken: String
    let hasTags: Bool

    enum CodingKeys: String, CodingKey {
        case albumID = "album_id"
        case date, id
        case ownerID = "owner_id"
        case sizes
        case squareCrop = "square_crop"
        case text
        case webViewToken = "web_view_token"
        case hasTags = "has_tags"
    }
}

// MARK: - Size
struct Size: Codable {
    let height: Int
    let type: String
    let width: Int
    let url: String
}
