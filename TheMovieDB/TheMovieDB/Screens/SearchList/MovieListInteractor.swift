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
    func displayMovies(movies: [Movie]?)
}

class MovieListInteractor {
    
    weak var delegate: MovieListInteractorDelegate?
    
    func initaliseMovieList() {
        StorageManager.getStoredMovieList { movies in
            DispatchQueue.main.async {
                self.delegate?.displayMovies(movies:movies)
            }
        }
    }
    
    
    func requestMovies(query: String?) {
        let worker = GetMoviesWorker()

        worker.request(query: query ?? "", page: 1, completion: { response in
            
            if let results = response.results {
                // Business logic here that requires the list ordered by popularity
                self.delegate?.displayMovies(movies: self.sortByPopularity(results: results))
                StorageManager.storeMovieQuery(query ?? "")
                StorageManager.storeMovieList(movieList: results)
            } else {
                self.delegate?.displayMovies(movies:nil)
            }
            
        }, failure: { error in
            
        })

    }
    
    func sortByPopularity (results : [Movie] ) -> [Movie] {
        
        let sortedArray = results.sorted(by: {
            if let pop1 = $0.popularity, let pop2 = $1.popularity {
                return  pop1 > pop2
            } else {
                return false
            }
            
            
        })
        return sortedArray
    }
    
}
