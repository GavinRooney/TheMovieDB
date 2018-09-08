//
//  GetGenresWorker.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import Foundation

class GetGenresWorker {
    
    func request(completion: @escaping (MovieGenresResponse) -> Void,
                 failure: @escaping (Error?) -> Void) {
        
        let request = MovieGenreRequest()
        
        ApiClient.sendRequest(request,
                              responseType: MovieGenresResponse.self,
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

