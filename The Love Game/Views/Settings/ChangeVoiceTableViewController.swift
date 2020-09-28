//
//  ChangeVoiceTableViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/25/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

protocol VoiceChangedDelegate: class {
    func handleVoiceChange(_ voiceId: String)
}

class ChangeVoiceTableViewController: UITableViewController {
    var voices: [AVSpeechSynthesisVoice] = AVSpeechSynthesisVoice.speechVoices().sorted(by: { $0.name < $1.name })
    weak var delegate: VoiceChangedDelegate?
    let currentVoiceId = DBUtility.getVoiceId()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: LoveSettingTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoveSettingTableViewCell.reuseIdentifier())
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return voices.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let voice = voices[indexPath.row]
        let voiceCell = tableView.dequeueReusableCell(withIdentifier: LoveSettingTableViewCell.reuseIdentifier()) as! LoveSettingTableViewCell
        let voiceName = voice.name == "" ? "None" : voice.name
        let voiceLang = voice.language
        let voiceText = "\(voiceName) - \(voiceLang)"
        voiceCell.leftLabel.text = voiceText
        if voice.identifier == currentVoiceId {
            voiceCell.accessoryType = .checkmark
            voiceCell.tintColor = .highlightPink
        } else {
            voiceCell.accessoryType = .none
        }
        return voiceCell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let voice = voices[indexPath.row]
        delegate?.handleVoiceChange(voice.identifier)
        self.navigationController?.popViewController(animated: true)
    }
}
