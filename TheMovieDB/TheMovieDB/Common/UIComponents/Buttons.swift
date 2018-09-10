//
//  Buttons.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit


class BaseButton: UIButton {
    
    var text: String? {
        get {
            return self.title(for: .normal)
        }
        set(text) {
            self.setTitle(text, for: .normal)
        }
    }
    
    var textColor: UIColor? {
        get {
            return self.titleColor(for: .normal)
        }
        set(color) {
            self.setTitleColor(color, for: .normal)
        }
    }
    
    var textFont: UIFont? {
        get {
            return self.titleLabel?.font
        }
        set(font) {
            self.titleLabel?.font = font
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setup() {
    }
}

class CloseButton: BaseButton {
    override func setup() {
        setImage(UIImage(named: "close"), for: .normal)
        width(29)
        height(29)
    }
}
