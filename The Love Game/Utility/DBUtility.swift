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
import AVFoundation

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

class DBUtility {
    
    class func getNaughtyLevel() -> Double {
        return UserDefaults.standard.double(forKey: "NaughtyLevel")
    }
    
    class func setNaughtyLevel(value: Double) {
        UserDefaults.standard.set(value, forKey: "NaughtyLevel")
    }
    
    class func getVoiceSpeed() -> Double {
        return UserDefaults.standard.double(forKey: "VoiceSpeed")
    }
    
    class func setVoiceSpeed(value: Double) {
        UserDefaults.standard.set(value, forKey: "VoiceSpeed")
    }
    
    class func getSoundEnabled() -> Bool {
        return UserDefaults.standard.bool(forKey: "SoundActive")
    }
    
    class func setSoundEnabled(value: Bool) {
        UserDefaults.standard.set(value, forKey: "SoundActive")
    }
    
    class func getVoiceId() -> String {
        var voiceId = UserDefaults.standard.string(forKey: "VoiceId")!
        if voiceId == "" {
            if let voice = AVSpeechSynthesisVoice(language: "en-US") {
                voiceId = voice.identifier
                setVoiceId(value: voice.identifier)
            }
        }
        return voiceId
    }
    
    class func setVoiceId(value: String) {
        UserDefaults.standard.set(value, forKey: "VoiceId")
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
    
    class func getTextEntityList(wordType: WordType) -> [TextEntity] {
        let words: [TextEntity] = getAllTextEntities()
        let entities = words.filter{word in
            return word.type == wordType.rawValue
        }
        return entities
    }
    
    class func getAllTextEntities() -> [TextEntity] {
        var entities: [TextEntity] = []
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            try? entities = context.fetch(TextEntity.fetchRequest())
        }
        return entities
    }
    
    class func addTextEntity(text: String, wordType: WordType, gender: Gender, isPlural: Bool, naughtyLevel: NaughtyLevel) {
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
    
    class func removeTextEntity(textEntity: TextEntity) {
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            context.delete(textEntity)
            (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
        }
    }
    
    class func deleteAllTextEntities(){
        var words: [TextEntity] = []
        if let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext {
            try? words = context.fetch(TextEntity.fetchRequest())
            for textEntity in words {
                context.delete(textEntity)
            }
        }
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }
    
    class func seedData() {
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
    
    class func registerDefaultUserDefaults() {
        UserDefaults.standard.register(defaults: [
            "SoundActive": false,
            "NaughtyLevel": 0.5,
            "VoiceId": "",
            "VoiceSpeed": 0.5
        ])
    }
}
