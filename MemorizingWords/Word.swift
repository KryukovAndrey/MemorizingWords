//
//  Word.swift
//  MemorizingWords
//
//  Created by Andrey on 09.12.2020.
//  Copyright © 2020 Andrey. All rights reserved.
//

import Foundation
import RealmSwift


class WordAndTranslation: Object {
    @objc dynamic var word = ""
    @objc dynamic var translation = ""
}

class Lesson: Object {
    @objc dynamic var lesson = ""
    var words = List<WordAndTranslation>()
}

class Topic: Object {
    @objc dynamic var topic = ""
    var lessons = List<Lesson>()
}




