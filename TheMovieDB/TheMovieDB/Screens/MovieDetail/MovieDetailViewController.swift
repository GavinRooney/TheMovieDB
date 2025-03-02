//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Gavin on 09/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import TinyConstraints

class MovieDetailViewController: UIViewController, LoadingDisplayLogic, AlertPresenter  {
    
    var animationView: LoadingAnimationView?

    private var movieDetailView = MovieDetailView()
    private var interactor: MovieDetailInteractor?
    
    init(_ movie: Movie) {
        super.init(nibName: nil, bundle: nil)
        interactor = MovieDetailInteractor(movie: movie)
        interactor?.delegate = self
    }
    
    override convenience init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        edgesForExtendedLayout = []
        view.backgroundColor = Style.Colors.white
        addBackground()
        movieDetailView.configureView(movie: (interactor?.movie)! )
        interactor?.requestMovieDetail()
        replaceBackButton()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        movieDetailView.updateContentSize()
    }
}

extension MovieDetailViewController {
    private func setup() {
        view.backgroundColor = Style.Colors.white
        setupMovieDetailView()
        setupConstraints()
        
    }
    
    private func setupMovieDetailView() {

        view.addSubview(movieDetailView)
        movieDetailView.detailDelegate = self
    }
    
    private func setupConstraints() {
    
        movieDetailView.edgesToSuperview()
    
    }
}

extension MovieDetailViewController : MovieDetailInteractorDelegate {
    func showSpinner() {
        showLoadingAnimation()
    }
    
    func hideSpinner() {
        hideLoadingAnimation()
    }
    
    func showErrorAlert() {
        self.alert(message: "MOVIE_DETAIL_NOT_FOUND".localized)
    }
    
    func updateMovieDetail(_ movie: Movie) {
        movieDetailView.configureView(movie: (interactor?.movie)! )
    }
    
    
}

extension MovieDetailViewController : MovieDetailViewDelegate {
    func linkTouched(url: URL) {
        let webViewController = WebViewController(urlToLoad: url)
        present(webViewController, animated: true, completion: nil)
    }
    
    
}


