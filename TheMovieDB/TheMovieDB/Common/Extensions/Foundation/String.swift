//
//  String.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

extension String {
    
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
    
    func localized(withComment: String) -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: withComment)
    }
    
    func removingWhitespaces() -> String {
        return self.components(separatedBy: .whitespaces).joined()
    }

    func safeAddingPercentEncoding(withAllowedCharacters allowedCharacters: CharacterSet) -> String? {
        // using a copy to workaround magic: https://stackoverflow.com/q/44754996/1033581
        let allowedCharacters = CharacterSet(bitmapRepresentation: allowedCharacters.bitmapRepresentation)
        return addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
}
