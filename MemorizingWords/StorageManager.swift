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
    
    func save(topic: Topic) {
        write {
            realm.add(topic)
        }
    }
    
    func edit(topic: Topic, newValue: String) {
        write {
            topic.topic = newValue
        }
    }
    
    func delete(topic: Topic) {
        write {
            realm.delete(topic.lessons)
            realm.delete(topic)
        }
    }
    
    private func write(_ completion: () -> Void) {
        do {
            try realm.write {
                completion()
            }
        } catch let error {
            print(error)
        }
    }
}

