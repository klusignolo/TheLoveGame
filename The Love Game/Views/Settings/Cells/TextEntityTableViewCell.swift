//
//  TextEntityTableViewCell.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/27/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import UIKit

class TextEntityTableViewCell: UITableViewCell {

    @IBOutlet weak var wordLabel: UILabel!
    @IBOutlet weak var naughtyLevelLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    class func nibName() -> String {
        return "TextEntityTableViewCell"
    }
    
    class func reuseIdentifier() -> String {
        return "TextEntityTableViewCell"
    }
}
