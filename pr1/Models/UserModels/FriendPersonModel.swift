//
//  FriendPersonModel.swift
//  pr1
//
//  Created by Никита Попов on 12.02.24.
//

import Foundation

struct FriendPersonModel{
    let id: Int
    let nickname, firstName, lastName: String
    let photo100: String
    let online: Int
    
    init(_ netwModel: Item){
        self.id = netwModel.id
        self.nickname = netwModel.nickname
        self.firstName = netwModel.firstName
        self.lastName = netwModel.lastName
        self.photo100 = netwModel.photo100
        self.online = netwModel.online
    }
}
