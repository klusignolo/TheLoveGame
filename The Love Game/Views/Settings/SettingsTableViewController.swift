//
//  SettingsTableViewController.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/19/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "LoveCell")
        setupUI()
    }
    
    enum SettingsCells: Int {
        case Words = 0
        case Sentence = 1
        case Voice = 2
        
    }
    
    enum SettingsSections: Int {
        case Words = 0
        case Voice = 1
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LoveCell", for: indexPath)
        if let loveCell = cell as? LoveSettingTableViewCell {
            switch SettingsSections.init(rawValue: indexPath.section) {
            case .Words:
                switch SettingsCells.init(rawValue: indexPath.row) {
                case .Words:
                    loveCell.leftLabel.text = "Setup Words"
                    break
                case .Sentence:
                    loveCell.leftLabel.text = "Setup Sentence"
                    break
                default:
                    break
                }
                break
            case .Voice:
                switch SettingsCells.init(rawValue: indexPath.row + 2) {
                case .Voice:
                    loveCell.leftLabel.text = "Change Voice"
                default:
                    break
                }
                break
            default:
                break
            }
            return cell
        } else {
            return UITableViewCell()
        }
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch SettingsSections.init(rawValue: indexPath.section) {
        case .Words:
            switch SettingsCells.init(rawValue: indexPath.row) {
            case .Words:
                break
            case .Sentence:
                break
            default:
                break
            }
            break
        case .Voice:
            switch SettingsCells.init(rawValue: indexPath.row + 2) {
            case .Voice:
                break
            default:
                break
            }
            break
        default:
            break
        }
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
    
}
