//
//  ProfileInfoModel.swift
//  pr1
//
//  Created by Никита Попов on 15.02.24.
//

import Foundation


struct ProfileInfo: Codable {
    let response: ResponseProfile
}

// MARK: - ResponseProfile
struct ResponseProfile: Codable {
    let id: Int
    let homeTown, status: String?
    let photo200: String
    let isServiceAccount: Bool
    let bdate, verificationStatus: String?
    let firstName, lastName: String
    let bdateVisibility: Int
    let phone: String?
    let relation, sex: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case homeTown = "home_town"
        case status
        case photo200 = "photo_200"
        case isServiceAccount = "is_service_account"
        case bdate
        case verificationStatus = "verification_status"
        case firstName = "first_name"
        case lastName = "last_name"
        case bdateVisibility = "bdate_visibility"
        case phone, relation, sex
    }
}
