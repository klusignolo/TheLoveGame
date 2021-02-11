//
//  SettingsTableViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/19/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import Foundation
import AVFoundation

class SettingsTableViewController: UITableViewController {
    
    private let wordsSetupIndexPath = IndexPath(row: 0, section: 0)
    private let sentenceSetupIndexPath = IndexPath(row: 1, section: 0)
    private let enableSoundIndexPath = IndexPath(row: 0, section: 1)
    private let chooseVoiceIndexPath = IndexPath(row: 1, section: 1)
    private let voiceSpeedIndexPath = IndexPath(row: 2, section: 1)
    private let wordSection = 0
    private let soundSection = 1
    var isSoundEnabled: Bool = DBUtility.getSoundEnabled()
    var currentVoiceId = DBUtility.getVoiceId()
    private let changeVoiceSegueIdentifier = "ChangeVoiceSegue"
    private let setupWordsSegueIdentifier = "PartsOfSpeechSegue"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        tableView.register(UINib(nibName: LoveSettingTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoveSettingTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: LoveSwitchTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoveSwitchTableViewCell.reuseIdentifier())
        tableView.register(UINib(nibName: LoveSliderTableViewCell.nibName(), bundle: nil), forCellReuseIdentifier: LoveSliderTableViewCell.reuseIdentifier())
    }
    
    private func setupUI() {
        createBackButton()
    }
    
    func createBackButton() {
        let view = UIView()
        let backButton = UIButton(type: .system)
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.setTitle(" Love Game", for: .normal)
        backButton.addTarget(self, action: #selector(self.navigateToLoveGame), for: .touchUpInside)
        backButton.tintColor = .darkLoveRed
        backButton.titleLabel?.font = UIFont(name: "Futura", size: 18)
        backButton.sizeToFit()
        view.addSubview(backButton)
        view.frame = backButton.bounds
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    private func getWordsSetupCell() -> UITableViewCell {
        let loveCell = tableView.dequeueReusableCell(withIdentifier: LoveSettingTableViewCell.reuseIdentifier()) as! LoveSettingTableViewCell
        loveCell.leftLabel.text = "Set Up Words (coming soon)"
        loveCell.accessoryType = .none
        return loveCell
    }
    
    private func getSentenceSetupCell() -> UITableViewCell {
        let loveCell = tableView.dequeueReusableCell(withIdentifier: LoveSettingTableViewCell.reuseIdentifier()) as! LoveSettingTableViewCell
        loveCell.leftLabel.text = "Set Up Sentence (coming soon)"
        loveCell.accessoryType = .none
        return loveCell
    }
    
    private func getEnableSoundSetupCell() -> UITableViewCell {
        let loveCell = tableView.dequeueReusableCell(withIdentifier: LoveSwitchTableViewCell.reuseIdentifier()) as! LoveSwitchTableViewCell
        loveCell.leftLabel.text = "Enable Sound"
        loveCell.rightSwitch.isOn = isSoundEnabled
        loveCell.delegate = self
        return loveCell
    }
    
    private func getVoiceSetupCell() -> UITableViewCell {
        let loveCell = tableView.dequeueReusableCell(withIdentifier: LoveSettingTableViewCell.reuseIdentifier()) as! LoveSettingTableViewCell
        print(currentVoiceId)
        let voice = AVSpeechSynthesisVoice.speechVoices().filter { $0.identifier == currentVoiceId }.first!
        let voiceName = voice.name == "" ? "" : "\(voice.name) - "
        let voiceLang = voice.language
        let voiceText = "\(voiceName)Language: \(voiceLang)"
        loveCell.leftLabel.text = "Change Voice (\(voiceText))"
        return loveCell
    }
    
    private func getVoiceSpeedSetupCell() -> UITableViewCell {
        let loveCell = tableView.dequeueReusableCell(withIdentifier: LoveSliderTableViewCell.reuseIdentifier()) as! LoveSliderTableViewCell
        loveCell.leftLabel.text = "Voice Speed"
        loveCell.slider.value = Float(DBUtility.getVoiceSpeed())
        loveCell.delegate = self
        return loveCell
    }
    
    //MARK: Actions & Navigation
    
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case changeVoiceSegueIdentifier:
            if let changeVoiceVC = segue.destination as? ChangeVoiceTableViewController {
                changeVoiceVC.delegate = self
            }
            break
        default:
            break
        }
    }
    
    // MARK: - Table Delegate Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case wordSection:
            return 2
        case soundSection:
            if isSoundEnabled {
                return 3
            } else {
                return 1
            }
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath {
        case wordsSetupIndexPath:
            return getWordsSetupCell()
        case sentenceSetupIndexPath:
            return getSentenceSetupCell()
        case enableSoundIndexPath:
            return getEnableSoundSetupCell()
        case chooseVoiceIndexPath:
            return getVoiceSetupCell()
        case voiceSpeedIndexPath:
            return getVoiceSpeedSetupCell()
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case wordSection:
            return "Word Settings"
        case soundSection:
            return "Sound Settings"
        default:
            return ""
        }
    }
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        if let headerView = view as? UITableViewHeaderFooterView {
            headerView.contentView.backgroundColor = .loveSecondaryText
            headerView.textLabel?.textColor = .darkLovePink
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath {
        case wordsSetupIndexPath:
            // TODO: This shit
            // performSegue(withIdentifier: setupWordsSegueIdentifier, sender: nil)
            break
        case sentenceSetupIndexPath:
            break
        case chooseVoiceIndexPath:
            performSegue(withIdentifier: changeVoiceSegueIdentifier, sender: nil)
            break
        default:
            break
        }
    }
}

//MARK: Switch Delegate

extension SettingsTableViewController: SettingSwitchFlippedDelegate {
    func handleSwitchFlip(_ switchState: Bool) {
        DBUtility.setSoundEnabled(value: switchState)
        isSoundEnabled = switchState
        UIView.transition(with: tableView, duration: 0.35, options: .transitionCrossDissolve, animations: { self.tableView.reloadData() }, completion: nil)
    }
}

//MARK: Voice Change Delegate

extension SettingsTableViewController: VoiceChangedDelegate {
    func handleVoiceChange(_ voiceId: String) {
        DBUtility.setVoiceId(value: voiceId)
        currentVoiceId = voiceId
        tableView.reloadData()
    }
}


//MARK: Volume Slider Delegate
extension SettingsTableViewController: SettingSliderChangedDelegate {
    func handleSliderChange(_ sliderValue: Float) {
        DBUtility.setVoiceSpeed(value: Double(sliderValue))
    }
}
