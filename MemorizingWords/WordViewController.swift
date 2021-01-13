//
//  WordViewController.swift
//  MemorizingWords
//
//  Created by Andrey on 03.12.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import RealmSwift

class WordViewController: UIViewController {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var translationLabel: UILabel!
    
    var topicPV = Int()
    var lessonPV = Int()
    var numberOfWords = 0
    var myTime = Timer()
    
    var topics: Results<Topic>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        topics = StorageManager.shared.realm.objects(Topic.self)
        title = topics[topicPV].lessons[lessonPV].lesson
//        print ("topicPV = \(topicPV)")
//        print ("lessonPV = \(lessonPV)")
        showWord()
        timer()
    }

    func showWord(){
        wordLabel.text = topics[topicPV].lessons[lessonPV].words[numberOfWords].word
        translationLabel.text = topics[topicPV].lessons[lessonPV].words[numberOfWords].translation
    }
    
    func timer() {
        myTime = Timer.scheduledTimer(timeInterval: 2,
                                      target: self,
                                      selector: #selector(changeNumberOfWords),
                                      userInfo: nil,
                                      repeats: true)
    }
    
    @objc func changeNumberOfWords(){
        numberOfWords += 1
        if numberOfWords == topics[topicPV].lessons[lessonPV].words.count {
            numberOfWords = 0
        }
        showWord()
    }
}

