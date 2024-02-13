//
//  AutchModels.swift
//  pr1
//
//  Created by Никита Попов on 8.02.24.
//

import Foundation

// MARK: - Friends
struct Contacts: Codable {
    let response: Response
}

// MARK: - Response
struct Response: Codable {
    let count: Int
    let items: [Item]
}

// MARK: - Item
struct Item: Codable {
    let id: Int
    let nickname: String?
    let trackCode, firstName, lastName: String
    let canAccessClosed, isClosed: Bool
    let photo100: String
    let online: Int

    enum CodingKeys: String, CodingKey {
        case id, nickname
        case trackCode = "track_code"
        case firstName = "first_name"
        case lastName = "last_name"
        case canAccessClosed = "can_access_closed"
        case isClosed = "is_closed"
        case photo100 = "photo_100"
        case online
    }
}

