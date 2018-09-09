//
//  MovieDetailInteractor.swift
//  TheMovieDB
//
//  Created by Gavin on 09/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

protocol MovieDetailInteractorDelegate: class {
    func showSpinner()
    func hideSpinner()
    func showErrorAlert()
    func updateMovieDetail(_ movie : Movie)
}

class MovieDetailInteractor {
    
    weak var delegate: MovieDetailInteractorDelegate?
    var movie :Movie
    
    init(movie :Movie) {
        self.movie = movie
    }

    func requestMovieDetail() {
        
        if let movieID = movie.id {
            let worker = GetMoviesWorker()
            worker.requestDetail(movieID: String(movieID), completion: { movie in
                
                    self.movie = movie
                    self.delegate?.updateMovieDetail(movie)
                
            }, failure: { error in
                
            })
    
        }
    
    }

}
