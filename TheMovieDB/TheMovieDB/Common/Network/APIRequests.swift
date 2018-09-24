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
    
    init(query: String, page: Int = 1) {
        
        let escapedString = query.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed)!
        super.init(method: .get, url: "search/movie?query=\(escapedString)&page=\(page)", parameters: nil)
    }
}

class MovieDetailRequest: ApiRequest {
    
    
    init(movieID: String) {
        
        super.init(method: .get, url: "movie/\(movieID)", parameters: nil)
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
