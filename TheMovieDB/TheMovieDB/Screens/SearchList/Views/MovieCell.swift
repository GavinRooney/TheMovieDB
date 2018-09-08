//
//  MovieCellView.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

import TinyConstraints


class MovieCell: UITableViewCell {
    
    private let background = UIView()
    private let thumbnailView = UIImageView()
    private let foreground = UIView()
    private let titleLabel = HeaderLabel()
    private let genreLabel = SecondarySelectionLabel()
    
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
        contentView.addSubview(foreground)
        foreground.backgroundColor = Style.Colors.white 
    }
    
    private func setupTitleLabel() {
        foreground.addSubview(titleLabel)
        foreground.layer.cornerRadius = 4.0
    }
    
    private func setupGenreLabel() {
        foreground.addSubview(genreLabel)
    }
    
    
    private func setupConstraints() {
        
        let xPadding = 10.0 as CGFloat
        let yPadding = 15.0 as CGFloat
        
        background.top(to: contentView)
        background.left(to: contentView, offset: xPadding)
        background.bottom(to: contentView, offset: -xPadding)
        background.right(to: contentView, offset: -xPadding)
        
        thumbnailView.top(to: foreground, offset: 0.0)
        thumbnailView.bottom(to: background, offset: -xPadding)
        thumbnailView.left(to: background, offset: xPadding)
        thumbnailView.width(80)
        
        foreground.top(to: background, offset: yPadding)
        foreground.bottom(to: background, offset: -yPadding)
        foreground.leftToRight(of: thumbnailView, offset: xPadding)
        foreground.right(to: background, offset: -xPadding)
        
        titleLabel.left(to: foreground, offset: yPadding)
        titleLabel.right(to: foreground)
        titleLabel.centerY(to: foreground)
        
        genreLabel.left(to: foreground, offset: xPadding)
        genreLabel.right(to: foreground, offset: -xPadding)
        genreLabel.topToBottom(of: titleLabel, offset: 5.0)
        
    }
}

extension MovieCell: ConfigurableCell {
    func configure(_ item: Movie, at indexPath: IndexPath) {
        titleLabel.text = item.title
        genreLabel.text = item.overview
    }
}

