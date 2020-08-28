//
//  SettingsViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 8/27/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func backBtnTapped(_ sender: Any) {
        navigateToLoveGame()
    }
    
    private func navigateToLoveGame(){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = .push
        transition.subtype = .fromLeft
        transition.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        let mainStoryboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        guard let loveGameVC = mainStoryboard.instantiateViewController(withIdentifier: "LoveGameViewController") as? LoveGameViewController else {
            return
        }
        present(loveGameVC, animated: false, completion: nil)
        
    }
}
