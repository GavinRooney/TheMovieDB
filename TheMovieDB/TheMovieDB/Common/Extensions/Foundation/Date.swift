//
//  Date.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

extension Date {
    
    static func getYear(dateText: String?) -> String? {
        if let dateText = dateText {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "YYYY-MM-dd"
            let date = dateFormatter.date(from: dateText)
            
            if let date = date {
                let calendar = Calendar.current
                let year = calendar.component(.year, from: date)
                return String(year)
            }
            
            
        }
        return nil
    }
}
