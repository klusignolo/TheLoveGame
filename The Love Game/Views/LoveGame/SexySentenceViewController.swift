//
//  SexySentenceViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import AVFoundation

class SexySentenceViewController: UIViewController {

    @IBOutlet weak var rollButton: UIButton!
    @IBOutlet weak var speakSentenceButton: UIButton!
    @IBOutlet weak var sentenceLabel: UILabel!
    var loveController: LoveController!
    let speechSynthesizer: AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        sentenceLabel.text = ""
        rollButton.layer.cornerRadius = 8
        loveController = LoveController()
        speakSentenceButton.isHidden = true
    }
    
    private func readSentence() {
        let voiceId = DBUtility.getVoiceId()
        let voice = AVSpeechSynthesisVoice.speechVoices().filter { $0.identifier == voiceId }.first!
        let speechUtterance: AVSpeechUtterance = AVSpeechUtterance(string: self.sentenceLabel.text ?? "")
        speechUtterance.rate = Float(DBUtility.getVoiceSpeed())
        speechUtterance.voice = voice
        speechSynthesizer.speak(speechUtterance)
    }
    
    @IBAction func rollButtonTapped(_ sender: Any) {
        let sexySentence = loveController?.getSentence()
        self.sentenceLabel.text = sexySentence
        self.speakSentenceButton.isHidden = false
        if DBUtility.getSoundEnabled() {
            readSentence()
        }
    }
    
    @IBAction func speakSentenceTapped(_ sender: Any) {
        readSentence()
    }
}
