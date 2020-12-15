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
        topics = StorageManager.shared.realm.objects(Topic.self)
    }
    
    @IBAction func startToShowWords(_ sender: Any) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "segue" else { return }
        guard let destination = segue.destination as? WordViewController else { return }
        destination.topicPV = topicPV
        destination.lessonPV = lessonPV
    }
    
}

extension ChoiceLessonViewController: UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int){
        if pickerView == topicPickerView {
            topicPV = row
            self.lessonPickerView.reloadAllComponents();
        } else if pickerView == lessonPickerView{
            lessonPV = row
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        if pickerView == topicPickerView {
            return 2 //topics.count
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
