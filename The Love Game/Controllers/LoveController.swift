//
//  LoveController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 8/26/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation

class LoveController {
    
    var naughtyLevel: NaughtyLevel! {
        get {
            return NaughtyLevel.init(rawValue: DBUtility.getNaughtyLevelEnum().rawValue)
        }
    }
    
    func getSentence() -> String {
        return "Fucknuts"
    }
    
    func getFuzzyDice() -> String {
        guard let part = WordPicker.getRandomWord(wordType: .Part, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        guard let action = WordPicker.getRandomWord(wordType: .Action, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        return "\(action) \(part)"
    }
    
    func getPart() -> String {
        guard let part = WordPicker.getRandomWord(wordType: .Part, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        return part
    }
    
    func getAction() -> String {
        guard let action = WordPicker.getRandomWord(wordType: .Action, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        return action
    }
}
