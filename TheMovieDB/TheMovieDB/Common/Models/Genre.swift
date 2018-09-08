//
//  Genre.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

struct Genre: Codable {
    
    let name: String?
    let id: Int?
   
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? nil
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? nil
    }
}
