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

    let test: String?
    let page: Int?
    let total_results: Int?
    let total_Pages: Int?
    //let results: [Any]?
    
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.test = try container.decodeIfPresent(String.self, forKey: .test) ?? ""
        self.page = try container.decodeIfPresent(Int.self, forKey: .page) ?? nil
        self.total_results = try container.decodeIfPresent(Int.self, forKey: .total_results) ?? nil
        self.total_Pages = try container.decodeIfPresent(Int.self, forKey: .total_Pages) ?? nil
        //self.results = try container.decodeIfPresent([Any]?.self, forKey: .results) ?? nil
        
    }
}
