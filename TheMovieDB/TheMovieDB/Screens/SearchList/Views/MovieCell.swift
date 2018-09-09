//
//  MovieCellView.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import TinyConstraints
import AlamofireImage

class MovieCell: UITableViewCell {
    
    private let background = UIView()
    private let thumbnailView = UIImageView()
    private let foreground = UIView()
    private let titleLabel = HeaderLabel()
    private let genreLabel = SecondarySelectionLabel()
    private let releaseYearLabel = HeaderLabel()
    private let popularityLabel = HeaderLabel()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}

extension MovieCell {
    private func setup() {
        selectionStyle = .none
        backgroundColor = UIColor.clear
        setupBackground()
        setupThumbnailView()
        setupForeground()
        setupTitleLabel()
        setupGenreLabel()
        setupReleaseyearLabel()
        setupPopularityLabel()
        setupConstraints()
    }
    
    private func setupBackground() {
        contentView.addSubview(background)
        background.layer.cornerRadius = 4.0
        background.backgroundColor = Style.Colors.blue
    }
    
    private func setupThumbnailView() {
        background.addSubview(thumbnailView)
        thumbnailView.layer.cornerRadius = 4.0
        thumbnailView.backgroundColor = Style.Colors.green
    }
    
    private func setupForeground() {
        background.addSubview(foreground)
        foreground.backgroundColor = Style.Colors.white
        foreground.layer.cornerRadius = 4.0
    }
    
    private func setupTitleLabel() {
        foreground.addSubview(titleLabel)
        titleLabel.numberOfLines = 0
    }
    
    private func setupReleaseyearLabel() {
        background.addSubview(releaseYearLabel)
        releaseYearLabel.textColor = Style.Colors.white
    }
    
    private func setupPopularityLabel() {
        background.addSubview(popularityLabel)
        popularityLabel.textColor = Style.Colors.white
    }
    
    private func setupGenreLabel() {
        foreground.addSubview(genreLabel)
        genreLabel.numberOfLines = 0
    }
    
    
    private func setupConstraints() {
        
        let xPadding = 10.0 as CGFloat
        let yPadding = 15.0 as CGFloat
        
        background.top(to: contentView)
        background.left(to: contentView, offset: xPadding)
        background.bottom(to: contentView, offset: -yPadding)
        background.right(to: contentView, offset: -xPadding)
        
        thumbnailView.top(to: foreground, offset: 0.0)
        thumbnailView.left(to: background, offset: xPadding)
        thumbnailView.width(70)
        thumbnailView.height(90)
        
        foreground.top(to: background, offset: yPadding)
        foreground.leftToRight(of: thumbnailView, offset: xPadding)
        foreground.right(to: background, offset: -xPadding)
        foreground.bottom(to: genreLabel, offset: yPadding)
        
        titleLabel.left(to: foreground, offset: xPadding)
        titleLabel.right(to: foreground)
        titleLabel.top(to: foreground, offset: yPadding)
        
        genreLabel.left(to: foreground, offset: xPadding)
        genreLabel.right(to: foreground, offset: -xPadding)
        genreLabel.topToBottom(of: titleLabel, offset: 5.0)
    
        releaseYearLabel.left(to: foreground, offset: xPadding)
        releaseYearLabel.rightToLeft(of: popularityLabel, offset: -xPadding)
        releaseYearLabel.topToBottom(of: foreground, offset: 5.0)
        releaseYearLabel.bottom(to: background, offset: -yPadding)
        
        popularityLabel.leftToRight(of: releaseYearLabel, offset: xPadding)
        popularityLabel.right(to: foreground, offset: -xPadding)
        popularityLabel.topToBottom(of: foreground, offset: 5.0)
        popularityLabel.bottom(to: background, offset: -yPadding)
        
    }
}

extension MovieCell: ConfigurableCell {
    func configure(_ item: Movie, at indexPath: IndexPath) {
        titleLabel.text = item.title
        genreLabel.text = GenreManager.shared.constructGenreSentence(genreIDs: item.genreIds)
        releaseYearLabel.text = Date.getYear(dateText: item.releaseDate)
        if let popularity = item.popularity {
            popularityLabel.text = String(popularity) + "%"
        } else {
            popularityLabel.text = ""
        }
        
        // important to cancel any previous image requests so that slow downloads do not affect the posters while scrolling
        thumbnailView.af_cancelImageRequest()
        
        let url = MovieDBConfigManager.shared.downloadThumbnailImageUrl(fileName: item.posterPath)
        let placeholderImage = UIImage(named: "placeholder")!
        if let url = url {
            thumbnailView.af_setImage(withURL: url, placeholderImage: placeholderImage)
        } else {
            thumbnailView.image = placeholderImage
        }
        
        
    }
}

