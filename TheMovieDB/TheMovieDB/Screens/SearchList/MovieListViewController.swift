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
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
    func movieSelected(movie: Movie) {
        
    }

}
