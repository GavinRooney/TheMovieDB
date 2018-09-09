//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Gavin on 09/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import TinyConstraints

class MovieDetailView: UIView {

    private let scrollView = UIScrollView()
    private let bannerView = UIImageView()
   // private let foreground = UIView()
    private let titleLabel = HeaderLabel()
    private let taglineLabel = SecondarySelectionLabel()
   // private let genreLabel = SecondarySelectionLabel()
    private let releaseYearLabel = HeaderLabel()
   // private let popularityLabel = HeaderLabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
 
    private func setup() {
    
        setupBackground()
        setupBannerView()
        setupTitleLabel()
        setupTagLabel()
        setupYearLabel()
        setupConstraints()
        
    }

    
    private func setupBackground() {
        addSubview(scrollView)
        scrollView.layer.cornerRadius = 4.0
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.backgroundColor = Style.Colors.blue
    }
    
    private func setupBannerView() {
        scrollView.addSubview(bannerView)
        bannerView.layer.cornerRadius = 4.0
        bannerView.backgroundColor = Style.Colors.green
    }
    
    private func setupTitleLabel() {
        scrollView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = Style.Colors.white
    }
    
    private func setupTagLabel() {
        scrollView.addSubview(taglineLabel)
        taglineLabel.numberOfLines = 0
        taglineLabel.textColor = Style.Colors.white
    }
    
    private func setupYearLabel() {
        scrollView.addSubview(releaseYearLabel)
        releaseYearLabel.textColor = Style.Colors.white
        releaseYearLabel.textAlignment = .right
    }
    
    
    private func setupConstraints() {
        
        let xPadding = 10.0 as CGFloat
        let yPadding = 15.0 as CGFloat
        
        scrollView.top(to: self, offset: yPadding)
        scrollView.left(to: self, offset: xPadding)
        scrollView.bottom(to: self, offset: 0)
        scrollView.right(to: self, offset: -xPadding)
        
        bannerView.top(to: self, offset: yPadding)
        bannerView.left(to: self, offset: xPadding)
        bannerView.right(to: self, offset: -xPadding)
        bannerView.height(200)
        
        titleLabel.topToBottom(of: bannerView, offset: yPadding)
        titleLabel.left(to: bannerView, offset: xPadding)
        titleLabel.right(to: bannerView, offset: -xPadding)
        
        taglineLabel.topToBottom(of: titleLabel, offset: 0)
        taglineLabel.left(to: bannerView, offset: xPadding)
        taglineLabel.right(to: bannerView, offset: -xPadding)
        
        releaseYearLabel.topToBottom(of: taglineLabel, offset: 0)
        releaseYearLabel.left(to: bannerView, offset: xPadding)
        releaseYearLabel.right(to: bannerView, offset: -xPadding)
        
        
    
    }
    
}

extension MovieDetailView {
    
    func configureView (movie : Movie) {
        titleLabel.text = movie.title
        releaseYearLabel.text = Date.getYear(dateText: movie.releaseDate)
        taglineLabel.text = movie.tagline
        
        let url = MovieDBConfigManager.shared.downloadBannerImageUrl(fileName: movie.backdropPath)
        let placeholderImage = UIImage(named: "bannerPlaceholder")!
        if let url = url {
            bannerView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        } else {
            bannerView.image = placeholderImage
        }
        
        scrollView.contentSize = CGSize(width: frame.width, height: titleLabel.frame.maxY)
    }
}


extension MovieDetailView: UIScrollViewDelegate {
    
}
