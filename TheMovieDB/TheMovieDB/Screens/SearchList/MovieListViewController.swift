//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private var movieListView: MovieListView!
    private var movieListInteractor: MovieListInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTouch()
        self.movieListInteractor = MovieListInteractor()
        movieListInteractor?.delegate = self
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

extension MovieListViewController {
    private func setup() {
        view.backgroundColor = Style.Colors.white
        setupMyListsView()
        setupConstraints()
        
    }
    
    private func setupMyListsView() {
        movieListView = MovieListView()
        movieListView.delegate = self
        view.addSubview(movieListView)
    }
    
    private func setupConstraints() {
        movieListView.edges(to: view)
    }
}

extension MovieListViewController: MovieListViewDelegate {
    func search(query: String?) {
        movieListInteractor?.requestMovies(query: query)
    }
    
    func movieSelected(movie: Movie) {
        
    }

}

extension MovieListViewController : MovieListInteractorDelegate {
    func showSpinner() {
        
    }
    
    func hideSpinner() {
        
    }
    
    func showErrorAlert() {
        
    }
    
    func displayMovies(movies: [Movie]?) {
        movieListView?.updateList(movies: movies)
    }

}
