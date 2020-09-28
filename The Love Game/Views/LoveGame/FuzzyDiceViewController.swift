//
//  FuzzyDiceViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import AVFoundation

class FuzzyDiceViewController: UIViewController {
    @IBOutlet weak var actionLabel: UILabel!
    @IBOutlet weak var partLabel: UILabel!
    @IBOutlet weak var rollButton: UIButton!
    var loveController: LoveController!
    let speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
    }
    
    private func setupUI() {
        actionLabel.text = "Roll"
        partLabel.text = "the Dice"
        rollButton.layer.cornerRadius = 8
        loveController = LoveController()
    }
    
    private func readDice() {
        let voiceId = DBUtility.getVoiceId()
        let voice = AVSpeechSynthesisVoice.speechVoices().filter { $0.identifier == voiceId }.first!
        let diceString = "\(actionLabel.text ?? "")\(partLabel.text ?? "")"
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: diceString)
        speechUtterance.rate = Float(DBUtility.getVoiceSpeed())
        speechUtterance.voice = voice
        speechSynthesizer.speak(speechUtterance)
    }
    
    @IBAction func rollButtonTapped(_ sender: Any) {
        self.actionLabel.text = loveController?.getAction()
        self.partLabel.text = loveController?.getPart()
        if DBUtility.getSoundEnabled() {
            readDice()
        }
    }
}
