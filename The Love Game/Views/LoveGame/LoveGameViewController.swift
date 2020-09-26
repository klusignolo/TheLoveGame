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
        setupUI()
    }
    
    func setupUI() {
        presentSexySentenceView()
        loveController = LoveController()
        let userNaughtyLvl = DBUtility.getNaughtyLevel()
        self.naughtyLevelSlider.value = Float(userNaughtyLvl)
        setNaughtyLevel()
        setupSlider()
        setupSegmentedControl()
    }
    
    private func setupSlider() {
        let sliderImage = UIImage(systemName: "heart.fill")
        naughtyLevelSlider.setThumbImage(sliderImage, for: .normal)
    }
    
    private func setupSegmentedControl() {
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.lovePrimaryText], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.loveSecondaryText], for: .selected)
    }
    
    @IBAction func naughtyLevelSliderMove(_ sender: Any) {
        setNaughtyLevel()
    }
    
    @IBAction func settingsTapped(_ sender: Any) {
        navigateToSettings()
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
        if selectedValue < 0.2 {
            naughtyLevelLbl.text = "Naughty Level: Mild"
        } else if selectedValue < 0.5 {
            naughtyLevelLbl.text = "Naughty Level: Spicy"
        } else if selectedValue < 0.8 {
            naughtyLevelLbl.text = "Naughty Level: Sexy"
        } else {
            naughtyLevelLbl.text = "Naughty Level: Don't Do It"
        }
        DBUtility.setNaughtyLevel(value: Double(selectedValue))
    }
    
    private func navigateToSettings() {
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = .push
        transition.subtype = .fromRight
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let settingsStoryboard = UIStoryboard(name: "Settings", bundle: nil)
        let settingsNavigationVC = settingsStoryboard.instantiateViewController(withIdentifier: "SettingsNavigationController")
        settingsNavigationVC.modalPresentationStyle = .fullScreen
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

