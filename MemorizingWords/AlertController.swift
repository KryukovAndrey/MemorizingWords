//
//  AlertController.swift
//  MemorizingWords
//
//  Created by Andrey on 11.01.2021.
//  Copyright © 2021 Andrey. All rights reserved.
//

import UIKit

class AlertController: UIAlertController {
    
    // делаю вот это   topic: Topic?
    var doneButton = "Save"
    
    func action(with topic: Topic?, completion: @escaping (String) -> Void) {
        
        if topic != nil { doneButton = "Update" }
                
        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
            guard let newValue = self.textFields?.first?.text else { return }
            guard !newValue.isEmpty else { return }
            completion(newValue)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
        
        addAction(saveAction)
        addAction(cancelAction)
        addTextField { textField in
            textField.placeholder = "Добавьте новую тему"
            textField.text = topic?.topic
        }
    }
    
    
    
    
    
    
    
//    
//    func action(with taskList: Topic?, completion: @escaping (String) -> Void) {
//        
//        if taskList != nil { doneButton = "Update" }
//                
//        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
//            guard let newValue = self.textFields?.first?.text else { return }
//            guard !newValue.isEmpty else { return }
//            completion(newValue)
//        }
//        
//        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
//        
//        addAction(saveAction)
//        addAction(cancelAction)
//        addTextField { textField in
//            textField.placeholder = "List Name"
//            textField.text = taskList?.name
//        }
//    }
    
//    func action(with task: Topic?, completion: @escaping (String, String) -> Void) {
//
//        if task != nil { doneButton = "Update" }
//
//        let saveAction = UIAlertAction(title: doneButton, style: .default) { _ in
//            guard let newTask = self.textFields?.first?.text else { return }
//            guard !newTask.isEmpty else { return }
//
//            if let note = self.textFields?.last?.text, !note.isEmpty {
//                completion(newTask, note)
//            } else {
//                completion(newTask, "")
//            }
//        }
//
//        let cancelAction = UIAlertAction(title: "Cancel", style: .destructive)
//
//        addAction(saveAction)
//        addAction(cancelAction)
//
//        addTextField { textField in
//            textField.placeholder = "New task"
//            textField.text = task?.name
//        }
//
//        addTextField { textField in
//            textField.placeholder = "Note"
//            textField.text = task?.note
//        }
//    }
}

