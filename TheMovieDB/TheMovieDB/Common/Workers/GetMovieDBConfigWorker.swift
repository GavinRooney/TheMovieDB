//
//  GetMovieDBConfigWorker.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

class GetMovieDBConfigWorker {
    
    func request(completion: @escaping (MovieDBConfigResponse) -> Void,
                 failure: @escaping (Error?) -> Void) {
        
        let request = MovieDBConfigRequest()
        
        ApiClient.sendRequest(request,
                              responseType: MovieDBConfigResponse.self,
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
