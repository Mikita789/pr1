//
//  NetworkManager.swift
//  pr1
//
//  Created by Никита Попов on 2.02.24.
//

import Foundation
import UIKit

class NetworkManager{
    func getArrPersID(_ count:Int)->String{
        var persArrId: [Int] = []
        for _ in 0..<count{
            let randId = Int.random(in: 0...800)
            if !persArrId.contains(randId){
                persArrId.append(randId)
            }
        }
        return "/\(Array(persArrId))".replacingOccurrences(of: "\\s", with: "", options: .regularExpression)
    }
    func loadImage(_ url: String?, compl: @escaping (UIImage) -> ()){
        guard let url = URL(string: url ?? "") else { return }
        let _ = URLSession.shared.dataTask(with: url) { data, resp, err in
            if err != nil{
                print("DEBUG: - Error load Image")
            }else{
                guard let data = data else { return }
                guard let image = UIImage(data: data) else { return }
                compl(image)
            }
        }.resume()
    }
    
    func getDataRickAndMorty(arrPers: String, compl:@escaping ([RickNetwModel]?) -> ()){
        var urlStr = EndPointsEnum.persons.endPoint?.absoluteString ?? ""
        urlStr += "\(arrPers)"
        guard let url = URL(string: urlStr) else { return }
        let _ = URLSession.shared.dataTask(with: url) { data, resp, err in
            if err != nil{
                print("DEBUG: - Error URLSession")
            }else{
                guard let data = data else { return }
                guard let res = self.parseJS(data) else { return }
                compl(res)
            }
        }.resume()
    }
    private func parseJS(_ data: Data) -> [RickNetwModel]?{
        let decoder = JSONDecoder()
        guard let res =  try? decoder.decode([RickNetwModel].self, from: data) else {
            print("DEBUG: - ERROR PARSE")
            return nil
        }
        return res
    }
    
    private func parseVKRes<T : Decodable>(_ data: Data, to type: T.Type) -> T?{
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(T.self, from: data) else { 
            print("DEBUG: - ERROR parse type: \(type)")
            return nil
        }
        return result
    }
    
    // MARK: - fetch contacts
    func getContact(_ token: String, _ userID: String, result: @escaping (Contacts)->()){
        guard let url = VKEndPoints.getContacts.getURL(token: token, id: userID) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if err == nil{
                guard let data = data else { return }
                guard let res = self.parseVKRes(data, to: Contacts.self) else { return }
                result(res)
            }
        }.resume()
    }
    
    // MARK: - fetch groups
    func getAllGroups(_ token: String, _ userID: String, result: @escaping (Groups)->()){
        guard let url = VKEndPoints.getGroups.getURL(token: token, id: userID) else { return }
        
        URLSession.shared.dataTask(with: url) { data, resp, err in
            if err == nil{
                guard let data = data else {return}
                guard let res = self.parseVKRes(data, to: Groups.self) else { return }
                result(res)
            }
        }.resume()
        
    }
    
    // MARK: - fetch photos
    func getAllphotoUser(_ token: String, _ userID: String, result: @escaping (Photos)->()){
        guard let url = VKEndPoints.getPhotos.getURL(token: token, id: userID) else { return }
        print(url)
        URLSession.shared.dataTask(with: url) { data, resp, err in
            guard err == nil else { return }
            guard let data = data else { return }
            guard let res = self.parseVKRes(data, to: Photos.self) else { return }
            result(res)
        }.resume()
    }

}





