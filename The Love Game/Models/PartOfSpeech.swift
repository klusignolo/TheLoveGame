//
//  PartOfSpeech.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation

enum WordType: Int32 {
    case Part = 0
    case Action = 1
    case Adjective = 2
    case Adverb = 3
    case Beginning = 4
    case Pronoun = 5
    case Punctuation = 6
    case Interjection = 7
}

class PartOfSpeech {
    var wordType: WordType
    var chance: Double
    
    init(wordType: WordType, chance: Double) {
        self.wordType = wordType
        self.chance = chance
    }
}
