//
//  LoveSliderTableViewCell.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/27/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

protocol SettingSliderChangedDelegate: class {
    func handleSliderChange(_ sliderValue: Float)
}

class LoveSliderTableViewCell: UITableViewCell {
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var slider: UISlider!
    
    weak var delegate: SettingSliderChangedDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func sliderValueChanged(_ sender: Any) {
        delegate?.handleSliderChange(slider.value)
    }
    
    class func nibName() -> String {
        return "LoveSliderTableViewCell"
    }
    
    class func reuseIdentifier() -> String {
        return "LoveSliderTableViewCell"
    }
}
