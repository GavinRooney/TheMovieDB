//
//  ImageConfig.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

struct ImageConfig: Codable {
    
    let baseUrl: String?
    let secureBaseUrl: String?
    let backdropSizes: [String]?
    let logoSizes: [String]?
    let posterSizes: [String]?
    let profileSizes: [String]?
    let stillSizes: [String]?
    
    enum CodingKeys: String, CodingKey {
        case baseUrl = "base_url"
        case secureBaseUrl = "secure_base_url"
        case backdropSizes = "backdrop_sizes"
        case logoSizes = "logo_sizes"
        case posterSizes = "poster_sizes"
        case profileSizes = "profile_sizes"
        case stillSizes = "still_sizes"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.baseUrl = try container.decodeIfPresent(String.self, forKey: .baseUrl) ?? nil
        self.secureBaseUrl = try container.decodeIfPresent(String.self, forKey: .secureBaseUrl) ?? nil

        self.backdropSizes = try container.decodeIfPresent([String].self, forKey: .backdropSizes) ?? nil
        self.logoSizes = try container.decodeIfPresent([String].self, forKey: .logoSizes) ?? nil
        self.posterSizes = try container.decodeIfPresent([String].self, forKey: .posterSizes) ?? nil
        self.profileSizes = try container.decodeIfPresent([String].self, forKey: .profileSizes) ?? nil
        self.stillSizes = try container.decodeIfPresent([String].self, forKey: .stillSizes) ?? nil
    }
}
