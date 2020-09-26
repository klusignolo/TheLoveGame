//
//  StringExtensions.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/19/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).uppercased() + self.lowercased().dropFirst()
        
    }
    
    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}
