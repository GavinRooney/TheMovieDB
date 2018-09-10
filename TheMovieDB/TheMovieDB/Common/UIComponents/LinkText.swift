//
//  LinkText.swift
//  TheMovieDB
//
//  Created by Gavin on 09/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

protocol LinkTextDelegate {
    func linkTouched(url: URL)
}


class LinkText: UITextView, UITextViewDelegate {
    
    private var links: [String: String] = [:]
    var linkTextDelegate: LinkTextDelegate?
    
    override init(frame: CGRect, textContainer: NSTextContainer?) {
        super.init(frame: frame, textContainer: textContainer)
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func setup() {
        self.delegate = self
        self.isEditable = false
        self.textContainerInset = .zero
        self.textAlignment = .center
        self.font = Style.Fonts.linkText
        self.textColor = Style.Colors.white
        // set links text color
        self.linkTextAttributes[NSAttributedStringKey.foregroundColor.rawValue] = Style.Colors.green
    }
    
    func setLink(_ link: String?, onText linkText: String) {
        self.links[linkText] = link
        self.updateAttributedText()
    }
    
    private func updateAttributedText() {
        guard let text = self.text else {
            return
        }
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = self.textAlignment
        paragraphStyle.lineSpacing = 2.0
        let attributedString = NSMutableAttributedString(string: text, attributes: [
            .foregroundColor: self.textColor!,
            .font: self.font!,
            .paragraphStyle: paragraphStyle,
            ])
        
        for (linkText, link) in self.links {
            let linkRange = attributedString.mutableString.range(of: linkText)
            attributedString.addAttribute(.link, value: link, range: linkRange)
        }
        
        self.attributedText = attributedString
    }
    
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange) -> Bool {
        self.linkTextDelegate?.linkTouched(url: URL)
        return false
    }
}
