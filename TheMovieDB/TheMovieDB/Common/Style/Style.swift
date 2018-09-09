//
//  Style.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

final class Style {}

extension Style {
    public enum Colors {
        static let green = UIColor(hexString: "#2ab7ab")
        static let blue = UIColor(hexString: "#148fda")
        static let darkGrey = UIColor(hexString: "#47505f")
        static let lightGrey = UIColor(hexString: "#8e8e93")
        static let white = UIColor.white
        static let alphaWhite = UIColor.white.withAlphaComponent(0.6)
        static let bgGrey = UIColor(red: 142, green: 142, blue: 147)
    }
}

extension Style {
    public enum Fonts {
        
        private enum Names {
            static let nevis = "nevis"
            static let muliRegular = "Muli-Regular"
            static let muliBold = "Muli-Bold"
        }
        
        private enum Sizes {
            static let small: CGFloat = 10.0
            static let medium: CGFloat = 14.0
            static let xMedium: CGFloat = 16.0
            static let large: CGFloat = 18.0
            static let xLarge: CGFloat = 24.0
            static let stupidLarge: CGFloat = 100.0
        }
        
        static let headerText = UIFont(name: Names.muliBold, size: Sizes.large)
        static let largeHeaderText = UIFont(name: Names.muliBold, size: Sizes.stupidLarge)
        static let sCTAText = UIFont(name: Names.nevis, size: Sizes.medium)
        static let ctaText = UIFont(name: Names.nevis, size: Sizes.xMedium)
        static let inputText = UIFont(name: Names.muliRegular, size: Sizes.xMedium)
        static let cellText = UIFont(name: Names.nevis, size: Sizes.large)

    }
}



extension UIColor {
    convenience init(hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
}

private extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
}

