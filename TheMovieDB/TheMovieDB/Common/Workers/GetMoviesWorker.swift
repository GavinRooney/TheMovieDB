//
//  GetMoviesWorker.swift
//  TheMovieDB
//
//  Created by Gavin on 07/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

class GetMoviesWorker {
    
    func request(query: String, page: Int, completion: @escaping (SearchMoviesListResponse) -> Void,
                        failure: @escaping (Error?) -> Void) {
        
        let request = SearchMoviesRequest(query: query, page: page)
        
        ApiClient.sendRequest(request,
                              responseType: SearchMoviesListResponse.self,
                              completion: { response in
                                if let response = response {
                                    completion(response)
                                }
        },
                              failure: { error in
                                failure(error)
        })
    }

}

