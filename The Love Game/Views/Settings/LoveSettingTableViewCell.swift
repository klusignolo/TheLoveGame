//
//  LoveSettingTableViewCell.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/20/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class LoveSettingTableViewCell: UITableViewCell {

    @IBOutlet weak var leftLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    class func nibName() -> String {
        return "LoveSettingTableViewCell"
    }
    
    class func reuseIdentifier() -> String {
        return "LoveSettingTableViewCell"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
