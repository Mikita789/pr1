//
//  DataManager.swift
//  pr1
//
//  Created by Никита Попов on 20.02.24.
//

import Foundation
import CoreData
import UIKit


struct DataManager{
    static var shared = DataManager()
    private init(){}
    
    func saveDataFriends(name : String, isOnline: Int = 1){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let ent = NSEntityDescription.entity(forEntityName: "FriendDataModel", in: context) else { return }
        
        let newEntity = FriendDataModel(entity: ent, insertInto: context)
        newEntity.fullName = name
        newEntity.isOnline = Int16(isOnline)
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func saveDataGroups(title : String, descr: String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        guard let ent = NSEntityDescription.entity(forEntityName: "GroupDataModel", in: context) else { return }
        
        let newEntity = GroupDataModel(entity: ent, insertInto: context)
        newEntity.title = title
        newEntity.descr = descr
        do{
            try context.save()
        }catch{
            print(error.localizedDescription)
        }
    }
    
    func fetchDataFriends() -> [FriendDataModel]?{
        var res:[FriendDataModel] = []
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let req: NSFetchRequest<FriendDataModel> = FriendDataModel.fetchRequest()
        
        do{
            res = try context.fetch(req)
            return res
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    func fetchDataGroups() -> [GroupDataModel]?{
        var res:[GroupDataModel] = []
        let appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appdelegate.persistentContainer.viewContext
        let req: NSFetchRequest<GroupDataModel> = GroupDataModel.fetchRequest()
        
        do{
            res = try context.fetch(req)
            return res
        }catch{
            print(error.localizedDescription)
            return nil
        }
    }
    
    func deleteItemFriend(){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let req:NSFetchRequest<FriendDataModel> = FriendDataModel.fetchRequest()
        
        do{
            let items = try context.fetch(req)
            for item in items{
                context.delete(item)
            }
            try context.save()
        }catch{
            fatalError("не удалось получить данный")
        }
    }
    
    func deleteItemGroup(){
        let appDel = UIApplication.shared.delegate as! AppDelegate
        let context = appDel.persistentContainer.viewContext
        let req:NSFetchRequest<GroupDataModel> = GroupDataModel.fetchRequest()
        
        do{
            let items = try context.fetch(req)
            for item in items{
                context.delete(item)
            }
            try context.save()
        }catch{
            fatalError("не удалось получить данный")
        }
    }
    
    
}
