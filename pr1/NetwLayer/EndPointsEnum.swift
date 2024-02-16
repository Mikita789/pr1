//
//  EndPointsEnum.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import Foundation


enum EndPointsEnum{
    case persons
    
    var endPoint: URL?{
        switch self{
            
        case .persons:
            var urlComponents = URLComponents()
            urlComponents.scheme = "https"
            urlComponents.host = "rickandmortyapi.com"
            urlComponents.path = "/api/character"
            
            return urlComponents.url
        }
    }
}

enum VKEndPoints: String{
    
    case getPhotos = "photos.get"
    case getGroups = "groups.get"
    case getContacts = "friends.get"
    case getProfileInfo = "account.getProfileInfo"
    
    func getURL(token: String, id: String)->URL?{
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.vk.ru"
        components.path = "/method/\(self.rawValue)"
        var param : [URLQueryItem] = []
        
        switch self{
            
        case .getPhotos:
            param = [URLQueryItem(name: "access_token", value: token),
                      URLQueryItem(name: "owner_id", value: id),
                      URLQueryItem(name: "album_id", value: "profile")
            ]
        case .getGroups:
            param = [ URLQueryItem(name: "access_token", value: token),
                      URLQueryItem(name: "user_id", value: id),
                      URLQueryItem(name: "extended", value: "1"),
                      URLQueryItem(name: "fields", value: "name,type,photo_100,description")
            ]
        case .getContacts:
            param = [ URLQueryItem(name: "access_token", value: token),
                      URLQueryItem(name: "user_id", value: id),
                      URLQueryItem(name: "order", value: "hints"),
                      URLQueryItem(name: "fields", value: "nickname,online,photo_100")
            ]
        case .getProfileInfo:
            param = [URLQueryItem(name: "access_token", value: token)]
        }
        
        param.append(URLQueryItem(name: "v", value: "5.199"))
        components.queryItems = param
        
        return components.url
    }
}
