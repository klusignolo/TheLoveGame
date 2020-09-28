//
//  LoveSwitchTableViewCell.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/25/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit
import Foundation

protocol SettingSwitchFlippedDelegate: class {
    func handleSwitchFlip(_ switchState: Bool)
}

class LoveSwitchTableViewCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var rightSwitch: UISwitch!
    weak var delegate: SettingSwitchFlippedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func switchDidFlip(_ sender: Any) {
        delegate?.handleSwitchFlip(rightSwitch.isOn)
    }
    
    class func nibName() -> String {
        return "LoveSwitchTableViewCell"
    }
    
    class func reuseIdentifier() -> String {
        return "LoveSwitchTableViewCell"
    }
}
