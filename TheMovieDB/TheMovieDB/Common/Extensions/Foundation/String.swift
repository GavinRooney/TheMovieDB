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

    
}
