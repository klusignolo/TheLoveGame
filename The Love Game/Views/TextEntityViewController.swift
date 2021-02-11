//
//  TextEntityViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 10/23/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class TextEntityViewController: UIViewController {
    var textEntity: TextEntity!
    @IBOutlet weak var naughtyLvlOneSwitch: UISwitch!
    @IBOutlet weak var naughtyLvlTwoSwitch: UISwitch!
    @IBOutlet weak var naughtyLvlThreeSwitch: UISwitch!
    @IBOutlet weak var naughtyLvlFourSwitch: UISwitch!
    @IBOutlet weak var pluralSwitch: UISwitch!
    @IBOutlet weak var maleSwitch: UISwitch!
    @IBOutlet weak var FemaleSwitch: UISwitch!
    
    @IBOutlet weak var textView: UITextView!
    private var naughtyArray = [Int]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setNaughtyLvl(_ level: NaughtyLevel) {
        naughtyLvlOneSwitch.isOn = false
        naughtyLvlTwoSwitch.isOn = false
        naughtyLvlThreeSwitch.isOn = false
        naughtyLvlFourSwitch.isOn = false
        switch level {
        case .Mild:
            naughtyLvlOneSwitch.isOn = true
        case .Spicy:
            naughtyLvlTwoSwitch.isOn = true
        case .Sexy:
            naughtyLvlThreeSwitch.isOn = true
        case .DontDoIt:
            naughtyLvlFourSwitch.isOn = true
        default:
            break
        }
    }
    
    private func setGender(_ gender: Gender) {
        maleSwitch.isOn = false
        FemaleSwitch.isOn = false
        if gender == .Male || gender == .Neutral {
            maleSwitch.isOn = true
        }
        if gender == .Female || gender == .Neutral {
            FemaleSwitch.isOn = true
        }
    }
    
    private func setPlural(_ plural: Bool) {
        pluralSwitch.isOn = plural
    }
    
    private func setupUI() {
        setNaughtyLvl(NaughtyLevel.init(rawValue: textEntity.naughtyLevel)!)
        setGender(Gender.init(rawValue: textEntity.gender)!)
        setPlural(textEntity.plural)
        setupTextView()
    }
    
    private func setupTextView() {
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.loveRed.cgColor
    }
    
    @IBAction func saveTapped(_ sender: Any) {
        var gender: Gender = .Neutral
        if maleSwitch.isOn {
            if !FemaleSwitch.isOn {
                gender = .Male
            }
        } else if FemaleSwitch.isOn {
            gender = .Female
        }
        textEntity.gender = gender.rawValue
        textEntity.plural = pluralSwitch.isOn
        if naughtyLvlOneSwitch.isOn {
            naughtyArray.append(1)
        }
        if naughtyLvlTwoSwitch.isOn {
            naughtyArray.append(2)
        }
        if naughtyLvlThreeSwitch.isOn {
            naughtyArray.append(3)
        }
        if naughtyLvlFourSwitch.isOn {
            naughtyArray.append(4)
        }
        DBUtility.updateTextEntity(textEntity)
    }
    
    private func save() {
        
    }
}
