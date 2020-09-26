//
//  Sentence.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation

class Sentence {
    private var naughtyLevel: NaughtyLevel! {
        get {
            return NaughtyLevel.init(rawValue: DBUtility.getNaughtyLevelEnum().rawValue)
        }
    }
    
    let defaultSentenceFormat: [PartOfSpeech] = [
        PartOfSpeech(wordType: .Interjection, chance: 0.1),
        PartOfSpeech(wordType: .Beginning, chance: 1.0),
        PartOfSpeech(wordType: .Adverb, chance: 0.2),
        PartOfSpeech(wordType: .Action, chance: 1.0),
        PartOfSpeech(wordType: .Pronoun, chance: 1.0),
        PartOfSpeech(wordType: .Adjective, chance: 0.25),
        PartOfSpeech(wordType: .Part, chance: 1.0),
        PartOfSpeech(wordType: .Punctuation, chance: 1.0)
    ]
    
    var sentenceFormat: [PartOfSpeech]
    
    init() {
        self.sentenceFormat = defaultSentenceFormat
    }
    
    func updateFormat(newFormat: [PartOfSpeech]) {
        self.sentenceFormat = newFormat
    }
    
    
    func roll() -> String {
        let sexySentence: [TextEntity] = assembleInitialSentence()
        correctPronounPlurals(sexySentence)
        correctPronounGenders(sexySentence)
        fixCasing(sexySentence)
            
        return makeSentenceWithSpacing(sexySentence)
    }
    
    //MARK: - Sentence Assembly
    func assembleInitialSentence() -> [TextEntity] {
        var textEntityArray: [TextEntity] = []
        for partOfSpeech in self.sentenceFormat {
            var textEntity: TextEntity
            switch partOfSpeech.wordType {
            case .Interjection:
                textEntity = LoveUtility.getRandomWord(wordType: .Interjection, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Beginning:
            textEntity = LoveUtility.getRandomWord(wordType: .Beginning, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Adverb:
                textEntity = LoveUtility.getRandomWord(wordType: .Adverb, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Action:
            textEntity = LoveUtility.getRandomWord(wordType: .Action, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Pronoun:
            textEntity = LoveUtility.getRandomWord(wordType: .Pronoun, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Adjective:
            textEntity = LoveUtility.getRandomWord(wordType: .Adjective, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Part:
            textEntity = LoveUtility.getRandomWord(wordType: .Part, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            case .Punctuation:
            textEntity = LoveUtility.getRandomWord(wordType: .Punctuation, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: .Neutral, plural: false)
                break
            }
            if chanceRoll(partOfSpeech) {
                textEntityArray.append(textEntity)
            }
        }
        return textEntityArray
    }
    
    private func correctPronounPlurals(_ textEntityArray: [TextEntity]) {
        for textEntity in textEntityArray {
            var selectedPronoun: TextEntity?
            if let textEntityType = WordType.init(rawValue: textEntity.type), textEntityType == .Part {
                if var partIndex = textEntityArray.firstIndex(of: textEntity) {
                    while partIndex != 0 && selectedPronoun == nil {
                        partIndex -= 1
                        if textEntityArray[partIndex].type == WordType.Pronoun.rawValue {
                            selectedPronoun = textEntityArray[partIndex]
                        }
                    }
                }
            }
            if selectedPronoun != nil {
                if !comparePlurals(textEntity, selectedPronoun!) {
                    let newPronoun = LoveUtility.getRandomWord(wordType: .Pronoun, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: Gender(rawValue: textEntity.gender)!, plural: textEntity.plural)
                    selectedPronoun = newPronoun
                }
            }
        }
    }
    
    private func correctPronounGenders(_ textEntityArray: [TextEntity]) {
        for textEntity in textEntityArray {
            var selectedPronoun: TextEntity?
            if let textEntityType = WordType.init(rawValue: textEntity.type), textEntityType == .Part {
                if var partIndex = textEntityArray.firstIndex(of: textEntity) {
                    while partIndex != 0 && selectedPronoun == nil {
                        partIndex -= 1
                        if textEntityArray[partIndex].type == WordType.Pronoun.rawValue {
                            selectedPronoun = textEntityArray[partIndex]
                        }
                    }
                }
            }
            if selectedPronoun != nil {
                if !compareGenders(textEntity, selectedPronoun!) {
                    let newPronoun = LoveUtility.getRandomWord(wordType: .Pronoun, naughtyLvl: DBUtility.getNaughtyLevelEnum(), gender: Gender(rawValue: textEntity.gender)!, plural: textEntity.plural)
                    selectedPronoun = newPronoun
                }
            }
        }
    }
    
    private func fixCasing(_ textEntityArray: [TextEntity]) {
        if textEntityArray.count > 0 {
            for textEntity in textEntityArray {
                if textEntity.type != WordType.Punctuation.rawValue && textEntity.type != WordType.Beginning.rawValue && textEntity.type != WordType.Interjection.rawValue {
                    textEntity.text = textEntity.text?.lowercased()
                }
            }
            textEntityArray[0].text?.capitalizeFirstLetter()
        }
    }
    
    private func makeSentenceWithSpacing(_ textEntityArray: [TextEntity]) -> String {
        var sentenceString = ""
        for (index, textEntity) in textEntityArray.enumerated() {
            sentenceString += "\(textEntity.text ?? "")"
            if index + 1 < textEntityArray.count {
                if textEntityArray[index + 1].type != WordType.Punctuation.rawValue {
                    sentenceString += " "
                }
            }
        }
        return sentenceString
    }
    
    private func comparePlurals(_ entity1: TextEntity, _ entity2: TextEntity) -> Bool {
        return entity1.plural == entity2.plural
    }
    
    private func compareGenders(_ entity1: TextEntity, _ entity2: TextEntity) -> Bool {
        let firstGender = Gender.init(rawValue: entity1.gender)
        let secondGender = Gender.init(rawValue: entity2.gender)
        return (firstGender == .Neutral || secondGender == .Neutral) || (firstGender == secondGender)
    }
    
    func chanceRoll(_ partOfSpeech: PartOfSpeech) -> Bool {
        let intChance = Int((1.0 - partOfSpeech.chance) * 100)
        if intChance == 0 {
            
            return true
        } else {
            let randInt = Int.random(in: 1...intChance)
            if randInt == 1 {
                return true
            } else {
                return false
            }
        }
    }
}
