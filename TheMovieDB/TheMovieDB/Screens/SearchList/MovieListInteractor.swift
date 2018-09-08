//
//  MovieListInteractor.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

protocol MovieListInteractorDelegate: class {
    func showSpinner()
    func hideSpinner()
    func showErrorAlert()
    func displayMovies(movies: [Movie])
}

class MovieListInteractor {
    
    weak var delegate: MovieListInteractorDelegate?
    
    func requestMovies(query: String?) {
        let worker = GetMoviesWorker()

        worker.request(query: query ?? "", page: 1, completion: { response in
            
            if let results = response.results {
                self.delegate?.displayMovies(movies: results)
            }
            
        }, failure: { error in
            
        })

    }
    
}
