//
//  SettingsViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 8/27/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var partsBtn: UIButton!
    @IBOutlet weak var actionsBtn: UIButton!
    @IBOutlet weak var adjectivesBtn: UIButton!
    @IBOutlet weak var adverbsBtn: UIButton!
    @IBOutlet weak var pronounsBtn: UIButton!
    @IBOutlet weak var beginningsBtn: UIButton!
    @IBOutlet weak var interjectionsBtn: UIButton!
    @IBOutlet weak var punctuationBtn: UIButton!
    @IBOutlet weak var arrangeBtn: UIButton!
    @IBOutlet weak var restoreDefaultsBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        navigateToLoveGame()
    }
    @IBAction func partsTapped(_ sender: Any) {
    }
    @IBAction func actionsTapped(_ sender: Any) {
    }
    @IBAction func adjectivesTapped(_ sender: Any) {
    }
    @IBAction func adverbsTapped(_ sender: Any) {
    }
    @IBAction func pronounsTapped(_ sender: Any) {
    }
    @IBAction func beginningsTapped(_ sender: Any) {
    }
    @IBAction func interjectionsTapped(_ sender: Any) {
    }
    @IBAction func punctuationTapped(_ sender: Any) {
    }
    @IBAction func arrangeTapped(_ sender: Any) {
    }
    @IBAction func restoreDefaultsTapped(_ sender: Any) {
    }
    
    @objc func navigateToLoveGame(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let mainStoryboard = UIStoryboard(name: "LoveGame", bundle: Bundle.main)
        guard let loveGameVC = mainStoryboard.instantiateViewController(withIdentifier: "LoveGameViewController") as? LoveGameViewController else {
            return
        }
        present(loveGameVC, animated: false, completion: nil)
        
    }
    
    //MARK: - Setup UI
    
    private func setupUI() {
        createBackButton()
    }
    
    func createBackButton() {
        let view = UIView()
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitle("  Back", for: .normal)
        backButton.addTarget(self, action: #selector(self.navigateToLoveGame), for: .touchUpInside)
        backButton.tintColor = .systemPink
        backButton.titleLabel?.font = UIFont(name: "System", size: 18)
        backButton.sizeToFit()
        view.addSubview(backButton)
        view.frame = backButton.bounds
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
}
