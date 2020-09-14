//
//  Extensions.swift
//  The Love Game
//
//  Created by Kevin Lusignolo on 9/13/20.
//  Copyright © 2020 Kevin Lusignolo. All rights reserved.
//

import Foundation
import UIKit

extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}

extension UIResponder {
    func getOwningViewController() -> UIViewController? {
        var nextResponder = self
        while let next = nextResponder.next {
            nextResponder = next
            if let viewController = nextResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
