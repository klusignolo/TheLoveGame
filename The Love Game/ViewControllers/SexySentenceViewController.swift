//
//  SexySentenceViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class SexySentenceViewController: UIViewController {

    @IBOutlet weak var sentenceTextView: UITextView!
    @IBOutlet weak var rollButton: UIButton!
    var loveController: LoveController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        sentenceTextView.text = ""
        sentenceTextView.centerVertically()
        rollButton.layer.cornerRadius = 8
        loveController = LoveController()
    }
    
    @IBAction func rollButtonTapped(_ sender: Any) {
        self.sentenceTextView.text = loveController?.getSentence()
    }
}
