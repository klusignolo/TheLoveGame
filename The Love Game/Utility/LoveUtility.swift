//
//  LoveUtility.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/19/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation

class LoveUtility {
    
    private var naughtyLevel: NaughtyLevel! {
        get {
            return NaughtyLevel.init(rawValue: DBUtility.getNaughtyLevelEnum().rawValue)
        }
    }
    
    class func getSentence() -> String {
        let sentence = Sentence()
        return sentence.roll()
    }
    
    func getFuzzyDice() -> String {
        guard let part = LoveUtility.getRandomWord(wordType: .Part, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        guard let action = LoveUtility.getRandomWord(wordType: .Action, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        return "\(action) \(part)"
    }
    
    func getPart() -> String {
        guard let part = LoveUtility.getRandomWord(wordType: .Part, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        return part
    }
    
    func getAction() -> String {
        guard let action = LoveUtility.getRandomWord(wordType: .Action, naughtyLvl: naughtyLevel, gender: .Neutral, plural: false).text else { return "" }
        return action
    }
    
    static func getRandomWord(wordType: WordType, naughtyLvl: NaughtyLevel, gender: Gender, plural: Bool) -> TextEntity {
        var wordCount = 0
        var randomIndex = 0
        var textEntities: [TextEntity] = DBUtility.getTextEntityList(wordType: wordType)
        var returnedTextEntity = TextEntity()
        var usePlural = plural
        if wordType != .Part || wordType != .Pronoun {
            usePlural = false
        }
        
        switch naughtyLvl {
        case .Anything:
            break
        case .Mild:
            textEntities = textEntities.filter{textEntity in return textEntity.naughtyLevel == NaughtyLevel.Mild.rawValue}
            break
        case .Spicy:
            textEntities = textEntities.filter{textEntity in return textEntity.naughtyLevel == NaughtyLevel.Spicy.rawValue}
            break
        case .Sexy:
            textEntities = textEntities.filter{textEntity in return textEntity.naughtyLevel == NaughtyLevel.Sexy.rawValue}
            break
        case .DontDoIt:
            textEntities = textEntities.filter{textEntity in return textEntity.naughtyLevel == NaughtyLevel.DontDoIt.rawValue}
            break
        }
        
        switch gender {
        case .Neutral:
            break
        case .Male:
            textEntities = textEntities.filter{textEntity in return textEntity.gender == Gender.Male.rawValue}
            break
        case .Female:
            textEntities = textEntities.filter{textEntity in return textEntity.gender == Gender.Female.rawValue}
            break
        }
        
        if usePlural {
            textEntities = textEntities.filter{textEntity in return textEntity.plural}
        }
        if textEntities.count == 0 {
            return returnedTextEntity
        }
        wordCount = textEntities.count
        randomIndex = Int.random(in: 0...wordCount - 1)
        returnedTextEntity = textEntities[randomIndex]
        
        return returnedTextEntity
    }
}
