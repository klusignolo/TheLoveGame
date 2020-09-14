//
//  DBUtility.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 8/26/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

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

enum Gender: Int32 {
    case Male = 0
    case Female = 1
    case Neutral = 2
}

enum NaughtyLevel: Int32 {
    case Anything = 0
    case Mild = 1
    case Spicy = 2
    case Sexy = 3
    case DontDoIt = 4
}

func getTextEntityList(wordType: WordType) -> [TextEntity] {
    let words: [TextEntity] = getAllTextEntities()
    let entities = words.filter{word in
        return word.type == wordType.rawValue
    }
    return entities
}

public func getAllTextEntities() -> [TextEntity] {
    var entities: [TextEntity] = []
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        try? entities = context.fetch(TextEntity.fetchRequest())
    }
    return entities
}

func addTextEntity(text: String, wordType: WordType, gender: Gender, isPlural: Bool, naughtyLevel: NaughtyLevel) {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        let newTextEntity = TextEntity(context: context)
        newTextEntity.text = text
        newTextEntity.type = wordType.rawValue
        newTextEntity.gender = gender.rawValue
        newTextEntity.plural = isPlural
        newTextEntity.naughtyLevel = naughtyLevel.rawValue
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

func removeTextEntity(textEntity: TextEntity) {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        context.delete(textEntity)
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
}

func deleteAllTextEntities(){
    var words: [TextEntity] = []
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        try? words = context.fetch(TextEntity.fetchRequest())
        for textEntity in words {
            context.delete(textEntity)
        }
    }
    (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
}

public func seedData() {
    if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
        if try! context.fetch(TextEntity.fetchRequest()).count > 0 {
            return
        }
    }
    guard let path = Bundle.main.path(forResource: "Words", ofType: "json") else { return }
    let url = URL(fileURLWithPath: path)
    do {
        let data = try Data(contentsOf: url)
        let json = try JSON(data: data)
        for wordObject in json["Parts"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Part, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Actions"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Action, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Adjectives"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Adjective, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Adverbs"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Adverb, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Beginnings"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Beginning, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Pronouns"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Pronoun, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Punctuation"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Punctuation, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        for wordObject in json["Interjections"] {
            let jsonWord = try? JSON(data: wordObject.1.rawData())
            let text = jsonWord?["text"].stringValue
            let naughtyInt = jsonWord?["naughtyLevel"].int32Value
            let naughtyLevel = NaughtyLevel.init(rawValue: naughtyInt!)
            let genderInt = jsonWord?["gender"].int32Value
            let gender = Gender.init(rawValue: genderInt!)
            let plural = jsonWord?["plural"].boolValue
            
            addTextEntity(text: text!, wordType: .Interjection, gender: gender!, isPlural: plural!, naughtyLevel: naughtyLevel!)
        }
        
    } catch {
    print(error)
    }
}

public class WordPicker {
    
    static func getRandomWord(wordType: WordType, naughtyLvl: NaughtyLevel, gender: Gender, plural: Bool) -> TextEntity {
        var wordCount = 0
        var randomIndex = 0
        var textEntities: [TextEntity] = getTextEntityList(wordType: wordType)
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

class DBUtility {
    
    class func getNaughtyLevel() -> Double {
        return UserDefaults.standard.double(forKey: "naughtyLevel")
    }
    
    class func getNaughtyLevelEnum() -> NaughtyLevel {
        let value = getNaughtyLevel()
        var naughtyInt = 1
        if value < 0.2 {
            naughtyInt = 1
        } else if value < 0.5 {
            naughtyInt = 2
        } else if value < 0.8 {
            naughtyInt = 3
        } else {
            naughtyInt = 4
        }
        return NaughtyLevel.init(rawValue: Int32(naughtyInt))!
    }
    
    class func setNaughtyLevel(value: Double) {
        UserDefaults.standard.set(value, forKey: "naughtyLevel")
    }
}
