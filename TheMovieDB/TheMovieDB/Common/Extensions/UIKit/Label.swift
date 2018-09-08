//
//  Label.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation


import UIKit

extension UILabel {
    func addTextSpacing(spacing: CGFloat) {
        if let text = self.text {
            let attributedString = NSMutableAttributedString(string: text)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: spacing, range: NSRange(location: 0, length: self.text!.count))
            self.attributedText = attributedString
            
        }
    }
}

