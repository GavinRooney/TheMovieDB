//
//  MovieDetailView.swift
//  TheMovieDB
//
//  Created by Gavin on 09/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import TinyConstraints

protocol MovieDetailViewDelegate {
    func linkTouched(url: URL)
}

class MovieDetailView: UIScrollView {

    private let backView = UIView()
    private let bannerView = UIImageView()
    private let overviewLabel = SecondarySelectionLabel()
    private let contentView = UIView()
    private let titleLabel = HeaderLabel()
    private let taglineLabel = SecondarySelectionLabel()
    private let genreLabel = SecondarySelectionLabel()
    private let releaseYearLabel = HeaderLabel()
    private let popularityLabel = HeaderLabel()
    private let runtimeLabel = SecondarySelectionLabel()
    private let revenueLabel = SecondarySelectionLabel()
    private let languageLabel = SecondarySelectionLabel()
    private let homepageTextView = LinkText()
    
    var detailDelegate : MovieDetailViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
 
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        setupBackground()
        setupBannerView()
        setupTitleLabel()
        setupTagLabel()
        setupYearLabel()
        setupPopularityLabel()
        setupGenreLabel()
        setupRevenueLabel()
        setupRuntimeLabel()
        setupLanguageLabel()
        createHomePageText()
        setupOverviewLabel()
        setupConstraints()
        
    }

    func setHomePageLink(_ link: String, onText linkText: String) {
        homepageTextView.setLink(link, onText: linkText)
    }
    
    private func setupBackground() {
        addSubview(backView)
        backView.layer.cornerRadius = 4.0
        backView.translatesAutoresizingMaskIntoConstraints = false
        showsVerticalScrollIndicator = false
        showsHorizontalScrollIndicator = false
        backView.clipsToBounds = true
        
        delegate = self
        backView.backgroundColor = Style.Colors.blue
    }
    
    private func setupBannerView() {
        backView.addSubview(bannerView)
        bannerView.layer.cornerRadius = 4.0
        bannerView.backgroundColor = Style.Colors.green
    }
    
    private func setupTitleLabel() {
        backView.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
        titleLabel.textColor = Style.Colors.white
    }
    
    private func setupTagLabel() {
        backView.addSubview(taglineLabel)
        taglineLabel.numberOfLines = 0
        taglineLabel.textColor = Style.Colors.white
    }
    
    private func setupYearLabel() {
        backView.addSubview(releaseYearLabel)
        releaseYearLabel.textColor = Style.Colors.white
        releaseYearLabel.textAlignment = .right
    }
    
    private func setupPopularityLabel() {
        backView.addSubview(popularityLabel)
        popularityLabel.textColor = Style.Colors.white
        popularityLabel.textAlignment = .right
    }
    
    private func setupGenreLabel() {
        backView.addSubview(genreLabel)
        genreLabel.textColor = Style.Colors.white
        genreLabel.numberOfLines = 0
    }
    
    private func setupRuntimeLabel() {
        backView.addSubview(runtimeLabel)
        runtimeLabel.textColor = Style.Colors.white
    }
    
    private func setupRevenueLabel() {
        backView.addSubview(revenueLabel)
        revenueLabel.textColor = Style.Colors.white
    }
    
    private func setupOverviewLabel() {
        backView.addSubview(contentView)
        contentView.backgroundColor = Style.Colors.white
        contentView.addSubview(overviewLabel)
        overviewLabel.textColor = .black
        overviewLabel.backgroundColor = Style.Colors.white
        contentView.layer.cornerRadius = 4.0
        overviewLabel.numberOfLines = 0
        
    }
    
    private func setupLanguageLabel() {
        backView.addSubview(languageLabel)
        languageLabel.textColor = Style.Colors.white
    }
    
    private func createHomePageText() {
        homepageTextView.font = Style.Fonts.linkText
        homepageTextView.textColor = Style.Colors.white
        homepageTextView.linkTextAttributes[NSAttributedStringKey.foregroundColor.rawValue] = Style.Colors.white
        
        homepageTextView.linkTextDelegate = self
        backView.addSubview(homepageTextView)
        homepageTextView.backgroundColor = .clear
    }
    
    private func setupConstraints() {
        
        let xPadding = 10.0 as CGFloat
        let yPadding = 15.0 as CGFloat
        
        backView.top(to: self, offset: yPadding)
        backView.left(to: self, offset: xPadding)
        backView.width(to: self, offset: -xPadding*2)
        
        bannerView.top(to: self, offset: yPadding)
        bannerView.left(to: self, offset: xPadding)
        bannerView.width(to: self , offset: -xPadding*2)
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
        
        popularityLabel.left(to: bannerView, offset: xPadding)
        popularityLabel.right(to: bannerView, offset: -xPadding)
        popularityLabel.topToBottom(of: releaseYearLabel, offset: 5.0)
        
        genreLabel.left(to: bannerView, offset: xPadding)
        genreLabel.right(to: bannerView, offset: -xPadding)
        genreLabel.topToBottom(of: popularityLabel, offset: 5.0)
        
        runtimeLabel.left(to: bannerView, offset: xPadding)
        runtimeLabel.right(to: bannerView, offset: -xPadding)
        runtimeLabel.topToBottom(of: genreLabel, offset: 5.0)
        
        revenueLabel.left(to: bannerView, offset: xPadding)
        revenueLabel.right(to: bannerView, offset: -xPadding)
        revenueLabel.topToBottom(of: runtimeLabel, offset: 5.0)
        
        languageLabel.left(to: bannerView, offset: xPadding)
        languageLabel.right(to: bannerView, offset: -xPadding)
        languageLabel.topToBottom(of: revenueLabel, offset: 5.0)
        
        homepageTextView.left(to: bannerView, offset: xPadding)
        homepageTextView.right(to: bannerView, offset: -xPadding)
        homepageTextView.topToBottom(of: languageLabel, offset: 5.0)
        homepageTextView.height(25)
        
        contentView.left(to: bannerView, offset: xPadding)
        contentView.right(to: bannerView, offset: -xPadding)
        contentView.topToBottom(of: homepageTextView, offset: 5.0)
        
        overviewLabel.left(to: contentView, offset: xPadding)
        overviewLabel.right(to: contentView, offset: -xPadding)
        overviewLabel.top(to: contentView, offset: 5.0)
        
        contentView.bottom(to: overviewLabel, offset: 5.0)
        
        backView.bottom(to: contentView, offset: yPadding)
        
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
        
        if movie.genreIds != nil {
            genreLabel.text = GenreManager.shared.constructGenreSentence(genreIDs: movie.genreIds)
        } else if (movie.genres != nil) {
            genreLabel.text = GenreManager.shared.constructGenreSentence(genres: movie.genres!)
            
        }
        if let popularity = movie.popularity {
            popularityLabel.text = String(popularity) + "%"
        } else {
            popularityLabel.text = ""
        }
        if let runtime = movie.runtime {
            runtimeLabel.text = "RUNTIME".localized + String(runtime) + "MINS".localized
        }
        if let revenue = movie.revenue {
            revenueLabel.text = "REVENUE".localized + String(revenue)
        }
        if let language = movie.originalLanguage {
            languageLabel.text = "LANGUAGE".localized + language
        }
        
        if let homepage = movie.homepage {
            homepageTextView.text = "CHECK_THEIR_WEBSITE".localized
            
            homepageTextView.setLink(homepage, onText: "CHECK_THEIR_WEBSITE".localized)
        }
        
        if let overview = movie.overview, overview.count > 0 {
            overviewLabel.text = overview + overview + overview
            contentView.isHidden = false
        } else {
            contentView.isHidden = true
        }
        
        
    }
    
    func updateContentSize() {
        contentSize = CGSize(width: frame.size.width, height: contentView.frame.maxY + 100)
    }
}


extension MovieDetailView: UIScrollViewDelegate {
    
}

extension MovieDetailView: LinkTextDelegate {
    
    func linkTouched(url: URL) {
        detailDelegate?.linkTouched(url: url)
    }
}
