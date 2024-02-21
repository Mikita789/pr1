//
//  NetwProtocol.swift
//  pr1
//
//  Created by Никита Попов on 21.02.24.
//

import Foundation
import UIKit

protocol NetwProtol{
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> Result<T, Error>
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
}

protocol NetwProtocolContacts{
    func getContact(_ token: String, _ userID: String, result: @escaping (Result<Contacts, Error>)->())
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> Result<T, Error>
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())

}

protocol NetwProtocolGroups{
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> Result<T, Error>
    func getAllGroups(_ token: String, _ userID: String, result: @escaping (Result<Groups, Error>)->())
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
}

protocol NetwProtocolPhotos{
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> Result<T, Error>
    func getAllphotoUser(_ token: String, _ userID: String, result: @escaping (Result<Photos, Error>)->())
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
}

protocol NetwProtocolProfile{
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ())
    func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> Result<T, Error>
    func getCurrentProfileInfo(_ token: String, _ userID: String, result: @escaping (Result<ProfileInfo, Error>)->())
}



