//
//  User.swift
//  DatingAppMemo
//
//  Created by Yuki Shinohara on 2020/07/24.
//  Copyright © 2020 Yuki Shinohara. All rights reserved.
//

import Foundation
import RealmSwift

class User: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var name: String = ""
    @objc dynamic var matchDay: String = ""
    @objc dynamic var impression: String = ""
    @objc dynamic var goodTopic: String = ""
    @objc dynamic var badTopic: String = ""
    @objc dynamic var datingDate: String = ""
    @objc dynamic var datingPlace: String = ""
    @objc dynamic var todoOnDate: String = ""
    @objc dynamic var rank: Int = 0
    
    override static func primaryKey() -> String? {
      return "id"
    }
}
