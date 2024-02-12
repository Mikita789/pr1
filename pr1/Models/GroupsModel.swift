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
    let description, name, screenName: String
    let isClosed: Int
    let type: String
    let photo50: String

    enum CodingKeys: String, CodingKey {
        case id, description, name
        case screenName = "screen_name"
        case isClosed = "is_closed"
        case type
        case photo50 = "photo_50"
    }
}
