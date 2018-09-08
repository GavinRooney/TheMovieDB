//
//  Labels.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

class BaseLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {}
}

class HeaderLabel: BaseLabel {
    override func setup() {
        font = Style.Fonts.headerText
        textColor = Style.Colors.darkGrey
        addTextSpacing(spacing: 2.0)
    }
}

class CellLabel: BaseLabel {
    override func setup() {
        font = Style.Fonts.inputText
        textColor = Style.Colors.lightGrey
        addTextSpacing(spacing: 2.0)
    }
}

class SecondarySelectionLabel: BaseLabel {
    override func setup() {
        font = Style.Fonts.sCTAText
        textColor = Style.Colors.lightGrey
        addTextSpacing(spacing: 2.0)
    }
}

class LargeFadedTitleLabel: BaseLabel {
    override func setup() {
        font = Style.Fonts.largeHeaderText
        textColor = Style.Colors.bgGrey
        addTextSpacing(spacing: 2.0)
        alpha = 0.1
        adjustsFontSizeToFitWidth = true
        minimumScaleFactor = 0.8
    }
}
