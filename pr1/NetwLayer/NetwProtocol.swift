//
//  NetwProtocol.swift
//  pr1
//
//  Created by Никита Попов on 21.02.24.
//

import Foundation
import UIKit

protocol NetwProtol{
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> T?
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
}

protocol NetwProtocolContacts{
    func getContact(_ token: String, _ userID: String, result: @escaping (Contacts, Error?)->())
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> T?
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())

}

protocol NetwProtocolGroups{
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> T?
    func getAllGroups(_ token: String, _ userID: String, result: @escaping (Groups, Error?)->())
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
}

protocol NetwProtocolPhotos{
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> T?
    func getAllphotoUser(_ token: String, _ userID: String, result: @escaping (Photos, Error?)->())
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
}

protocol NetwProtocolProfile{
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> T?
    func getCurrentProfileInfo(_ token: String, _ userID: String, result: @escaping (ProfileInfo, Error?)->())
}



