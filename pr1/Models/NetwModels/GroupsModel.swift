//
//  GroupsModel.swift
//  pr1
//
//  Created by Никита Попов on 12.02.24.
//

import Foundation

// MARK: - Groups
struct Groups: Codable {
    let response: ResponseGR
}

// MARK: - Response
struct ResponseGR: Codable {
    let count: Int
    let items: [ItemGR]
}

// MARK: - Item
struct ItemGR: Codable {
    let id: Int
    let description: String?
    let name, screenName: String
    let isClosed: Int
    let type: String
    let photo100: String

    enum CodingKeys: String, CodingKey {
        case id, description, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo100 = "photo_100"
    }
}
