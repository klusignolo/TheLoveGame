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
    
    var loveController: LoveController!
    
    @IBOutlet weak var naughtyLevelSlider: UISlider!
    @IBOutlet weak var naughtyLevelLbl: UILabel!
    @IBOutlet weak var sexySentenceView: UIView!
    @IBOutlet weak var fuzzyDiceView: UIView!
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        seedData()
        setupUI()
    }
    
    func setupUI() {
        presentSexySentenceView()
        loveController = LoveController()
        let userNaughtyLvl = DBUtility.getNaughtyLevel()
        self.naughtyLevelSlider.value = Float(userNaughtyLvl)
        setNaughtyLevel()
    }
    
    @IBAction func naughtyLevelSliderMove(_ sender: Any) {
        setNaughtyLevel()
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        //navigateToSettings()
    }
    
    @IBAction func segmentIndexChanged(_ sender: Any) {
        switch segmentedControl.selectedSegmentIndex {
        case 0:
            presentSexySentenceView()
        case 1: presentFuzzyDiceView()
        default:
            break
        }
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
        DBUtility.setNaughtyLevel(value: Double(selectedValue))
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
    
    func presentFuzzyDiceView() {
        self.fuzzyDiceView.isHidden = false
        self.sexySentenceView.isHidden = true
    }
    
    func presentSexySentenceView() {
        self.fuzzyDiceView.isHidden = true
        self.sexySentenceView.isHidden = false
    }
}

