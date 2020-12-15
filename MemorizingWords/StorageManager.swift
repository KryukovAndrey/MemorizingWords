//
//  StorageManager.swift
//  MemorizingWords
//
//  Created by Andrey on 13.12.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import RealmSwift

class StorageManager {
    
    static let shared = StorageManager()
    let realm = try! Realm()
    
    private init() {}
    
    func save(topic: [Topic]) {
        try! realm.write {
            realm.add(topic)
        }
    }
}
