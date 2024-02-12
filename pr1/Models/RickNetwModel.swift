//
//  RickNetwModel.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import Foundation


struct RickNetwModel: Codable {
    let id: Int
    let name, status, species, type: String
    let gender: String
    let image: String
}

// MARK: - Location
struct Location: Codable {
    let name: String
}
