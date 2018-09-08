//
//  APIResponses.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

// Generic error response

struct ErrorResponse: Codable {
    let errorMessage: String?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.errorMessage = try container.decodeIfPresent(String.self, forKey: .errorMessage) ?? ""
    }
}

struct SearchMoviesListResponse: Codable {
    
    let page: Int?
    let totalResults: Int?
    let totalPages: Int?
    let results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case totalResults = "total_results"
        case totalPages = "total_pages"

        case results
        case page
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? nil
        self.totalResults = try container.decodeIfPresent(Int.self, forKey: .totalResults) ?? nil
        self.totalPages = try container.decodeIfPresent(Int.self, forKey: .totalPages) ?? nil
        self.results = try container.decodeIfPresent([Movie]?.self, forKey: .results) ?? nil
        
    }
}

struct MovieGenresResponse: Codable {
    
    let genres: [Genre]?
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.genres = try container.decodeIfPresent([Genre]?.self, forKey: .genres) ?? nil
        
    }
}

