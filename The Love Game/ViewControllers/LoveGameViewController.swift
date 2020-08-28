//
//  ViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 8/25/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//
import Foundation
import UIKit

class LoveGameViewController: UIViewController {
    
    var loveController = LoveController()
    
    @IBOutlet weak var textBox: UITextView!
    @IBOutlet weak var sexySentenceBtn: UIButton!
    @IBOutlet weak var fuzzyDiceBtn: UIButton!
    @IBOutlet weak var naughtyLevelSlider: UISlider!
    @IBOutlet weak var naughtyLevelLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        seedData()
        
        let userNaughtyLvl = UserDefaults.standard.double(forKey: "naughtyLevel")
        naughtyLevelSlider.value = Float(userNaughtyLvl)
        setNaughtyLevel()
    }

    @IBAction func sexySentenceBtnTapped(_ sender: Any) {
    }
    @IBAction func fuzzyDiceBtnTapped(_ sender: Any) {
        textBox.text = loveController.getFuzzyDice()
    }
    @IBAction func naughtyLevelSliderMove(_ sender: Any) {
        setNaughtyLevel()
    }
    @IBAction func settingsTapped(_ sender: Any) {
        navigateToSettings()
    }
    
    private func setNaughtyLevel() {
        let selectedValue = naughtyLevelSlider.value
        var naughtyInt = 1
        if selectedValue < 0.2 {
            naughtyLevelLbl.text = "Naughty Level: Mild"
        } else if selectedValue < 0.5 {
            naughtyLevelLbl.text = "Naughty Level: Spicy"
            naughtyInt = 2
        } else if selectedValue < 0.8 {
            naughtyLevelLbl.text = "Naughty Level: Sexy"
            naughtyInt = 3
        } else {
            naughtyLevelLbl.text = "Naughty Level: Don't Do It"
            naughtyInt = 4
        }
        loveController.naughtyLevel = NaughtyLevel.init(rawValue: Int32(naughtyInt))!
        UserDefaults.standard.set(selectedValue, forKey: "naughtyLevel")
    }
    
    private func navigateToSettings() {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let settingsNavigationVC = mainStoryboard.instantiateViewController(withIdentifier: "SettingsNavigationController") as? SettingsNavigationController else {
            return
        }
        present(settingsNavigationVC, animated: false, completion: nil)
    }
}

