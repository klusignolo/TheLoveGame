//
//  FuzzyDiceViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class FuzzyDiceViewController: UIViewController {
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var rollButton: UIButton!
    var loveController: LoveController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        actionLabel.text = ""
        partLabel.text = ""
        rollButton.layer.cornerRadius = 8
        loveController = LoveController()
    }
    
    @IBAction func rollButtonTapped(_ sender: Any) {
        self.actionLabel.text = loveController?.getAction()
        self.partLabel.text = loveController?.getPart()
    }
}
