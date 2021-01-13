//
//  ChoiceLessonViewController.swift
//  MemorizingWords
//
//  Created by Andrey on 15.12.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import UIKit
import RealmSwift

class ChoiceLessonViewController: UIViewController {
    
    @IBOutlet weak var topicPickerView: UIPickerView!
    @IBOutlet weak var lessonPickerView: UIPickerView!
    @IBOutlet weak var startToShowWords: UIButton!
    
    var topics: Results<Topic>!
    var topicPV: Int = 0
    var lessonPV: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        topics = StorageManager.shared.realm.objects(Topic.self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.topicPickerView.reloadAllComponents()
    }
    
    @IBAction func showTgeWords(_ sender: Any) {
    }
    @IBAction func startToShowWords(_ sender: Any) {
    }
    @IBAction func newTopicAction(_ sender: UIButton) {
        showAlert()
    }
    @IBAction func editTopicAction(_ sender: UIButton) {
        showAlert(with: topics[topicPV]) {
            self.topicPickerView.reloadAllComponents()
        }
    }
    @IBAction func deleteTopicAction(_ sender: UIButton) {
        StorageManager.shared.delete(topic: topics[topicPV])
//        DispatchQueue.main.async {
//            self.topicPickerView.reloadAllComponents  ()
//        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        switch segue.identifier {
        case "segue":
            guard let destination = segue.destination as? WordViewController else { return }
            destination.topicPV = topicPV
            destination.lessonPV = lessonPV
            print ("destination.topicPV = \(topicPV)")
            print ("destination.lessonPV = \(lessonPV)")
        case "segueDetailLesson":
            guard let destinationDetailLessonVC = segue.destination as? DetailLessonViewController else { return }
            destinationDetailLessonVC.topicPV = topicPV
            destinationDetailLessonVC.lessonPV = lessonPV
            print ("destinationDetailLessonVC.topicPV = \(topicPV)")
            print ("destinationDetailLessonVC.lessonPV = \(lessonPV)")
        default:
            print("Не сработало")
        }
    }
    
    
    
}

extension ChoiceLessonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == topicPickerView {
            topicPV = row
            print(topicPV)
            print(topics[topicPV].topic)
            self.lessonPickerView.reloadAllComponents();
        } else if pickerView == lessonPickerView{
            lessonPV = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == topicPickerView {
            return topics.count
        }
        if pickerView == lessonPickerView{
            return topics[topicPV].lessons.count
        } else {
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        if pickerView == topicPickerView {
            return topics[row].topic
        }
        if pickerView == lessonPickerView {
            return topics[topicPV].lessons[row].lesson
        } else {
            return "Ошибка"
        }
    }
}

extension ChoiceLessonViewController {
    
    private func showAlert(with topic: Topic? = nil, completion: (() -> Void)? = nil) {
        
        let title = topic != nil ? "Измените тему" : "Добавьте тему"
        
        let alert = AlertController(title: title, message: "Please insert new value", preferredStyle: .alert)
        
        alert.action(with: topic) { newValue in
            if let topic = topic, let completion = completion {
                StorageManager.shared.edit(topic: topic, newValue: newValue)
                completion()
            } else {
                let newTopic = Topic()
                newTopic.topic = newValue
                
                StorageManager.shared.save(topic: newTopic)
                self.topicPickerView.reloadAllComponents()
            }
        }
        
        present(alert, animated: true)
    }
}

