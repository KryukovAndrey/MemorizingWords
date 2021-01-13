//
//  DetailLessonViewController.swift
//  MemorizingWords
//
//  Created by Andrey on 29.12.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import RealmSwift

class DetailLessonViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var newTopicLabel: UILabel!
    @IBOutlet weak var newLessonLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var topics: Results<Topic>!
    var topicPV = Int()
    var lessonPV = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        topics = StorageManager.shared.realm.objects(Topic.self)
        newTopicLabel.text = topics[topicPV].topic
        newLessonLabel.text = topics[topicPV].lessons[lessonPV].lesson
        
        DispatchQueue.main.async(execute: {
                    self.tableView.reloadData()
                    })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics[topicPV].lessons[lessonPV].words.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text =  topics[topicPV].lessons[lessonPV].words[indexPath.row].word
        cell.detailTextLabel?.text = topics[topicPV].lessons[lessonPV].words[indexPath.row].translation
        
        print(indexPath.row)

        return cell
    }
}
