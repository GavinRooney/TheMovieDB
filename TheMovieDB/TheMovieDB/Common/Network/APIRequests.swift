//
//  APIRequests.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation
import Alamofire


class ApiRequest {
    
    let method: HTTPMethod
    let url: String
    let parameters: [String: Any]?
    var paramaterArray: [Any]?
    
    init(method: HTTPMethod, url: String, parameters: [String: Any]?) {
        self.method = method
        self.url = url
        self.parameters = parameters
    }
}


class SearchMoviesRequest: ApiRequest {
    
    private struct Parameters: Encodable {
        
        var query: String
        var page: Int
        
    }
    
    init(query: String, page: Int = 1) {
        
        super.init(method: .get, url: "search/movie?query=\(query)&page=\(page)", parameters: nil)
    }
}

class MovieGenreRequest: ApiRequest {
    
    init() {
        
        super.init(method: .get, url: "genre/movie/list", parameters: nil)
    }
}

class MovieDBConfigRequest: ApiRequest {
    
    init() {
        
        super.init(method: .get, url: "configuration", parameters: nil)
    }
}
