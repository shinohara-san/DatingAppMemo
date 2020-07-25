//
//  DataSource.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import RealmSwift

class DataSource {
    var allPeople = [User]()
    
    func getData(reload tableView: UITableView){
        let realm = try! Realm()
        let data = realm.objects(User.self)
        allPeople = Array(data)
        DispatchQueue.main.async {
            tableView.reloadData()
        }
    }
    
    func saveData(of newMatch: User){
        let realm = try! Realm()
        try! realm.write {
            realm.add(newMatch)
        }
    }
    
    func count() -> Int{
        return allPeople.count
    }
    
    func data(at index: Int)-> User?{
        if allPeople.count > index {
            return allPeople[index]
        }
        return nil
    }
    
    func delete(user: User){
        let realm = try! Realm()
        guard let data = realm.objects(User.self).filter("id == '\(user.id)'").first else {return}
        try! realm.write({
            realm.delete(data)
        })
    }
    
    func updateData(of user: User){
        let realm = try! Realm()
        
        guard let data = realm.objects(User.self).filter("id == '\(user.id)'").first else {return}
        
        try! realm.write {
            data.name = user.name
            data.matchDay = user.matchDay
            data.impression = user.impression
            data.goodTopic = user.goodTopic
            data.badTopic = user.badTopic
            data.todoOnDate = user.todoOnDate
        }
    }
    
    func printPath(){
        let realm = try! Realm()
        let folderPath = realm.configuration.fileURL!.deletingLastPathComponent().path
        print(folderPath)
    }
}
