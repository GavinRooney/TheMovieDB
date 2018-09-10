//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController, LoadingDisplayLogic, AlertPresenter {
    
    var animationView: LoadingAnimationView?

    private var movieListView = MovieListView()
    private var movieListInteractor: MovieListInteractor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardOnTouch()
        self.movieListInteractor = MovieListInteractor()
        movieListInteractor?.delegate = self
        setup()
        movieListInteractor?.initaliseMovieList()
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
        setupMovieListsView()
        setupConstraints()
    }
    
    private func setupMovieListsView() {
        movieListView.delegate = self
        view.addSubview(movieListView)
    }
    
    private func setupConstraints() {
        movieListView.edges(to: view)
    }
    
    private func addClearHistoryButton () {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "x-white"), style: .plain, target: self, action: #selector(clearHistoryTapped))
    }
    
    @objc private func clearHistoryTapped () {
        
    }
}

extension MovieListViewController: MovieListViewDelegate {
    func search(query: String?) {
        movieListInteractor?.requestMovies(query: query)
    }
    
    func movieSelected(_ movie: Movie?) {
        if let movie = movie {
            let vc = MovieDetailViewController(movie)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension MovieListViewController : MovieListInteractorDelegate {
    func displayLastQuery(_ query: String) {
        movieListView.updateSearchField(query: query)
    }
    
    func showSpinner() {
        showLoadingAnimation()
    }
    
    func hideSpinner() {
        hideLoadingAnimation()
    }
    
    func showErrorAlert() {
        self.alert(message: "MOVIES_NOT_FOUND".localized)
    }
    
    func displayMovies(movies: [Movie]?) {
        movieListView.updateList(movies: movies)
    }

}
