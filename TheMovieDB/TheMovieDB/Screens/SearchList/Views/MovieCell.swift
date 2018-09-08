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
    
    private let background = UIImageView()
    private let foreground = UIView()
    private let mainLabel = HeaderLabel()
    private let secondaryLabel = SecondarySelectionLabel()
    
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
        setupForeground()
        setupMainLabel()
        setupSecondaryLabel()
        setupConstraints()
    }
    
    private func setupBackground() {
        contentView.addSubview(background)
        background.layer.cornerRadius = 4.0
        background.backgroundColor = Style.Colors.blue
    }
    
    private func setupForeground() {
        contentView.addSubview(foreground)
        foreground.backgroundColor = Style.Colors.white 
    }
    
    private func setupMainLabel() {
        foreground.addSubview(mainLabel)
        foreground.layer.cornerRadius = 4.0
    }
    
    private func setupSecondaryLabel() {
        foreground.addSubview(secondaryLabel)
    }
    
    
    private func setupConstraints() {
        background.top(to: contentView)
        background.left(to: contentView, offset: 10.0)
        background.bottom(to: contentView, offset: -10.0)
        background.right(to: contentView, offset: -10.0)
        
        foreground.top(to: contentView, offset: 15.0)
        foreground.bottom(to: contentView, offset: -25.0)
        foreground.left(to: contentView, offset: 80.0)
        foreground.right(to: contentView, offset: -15.0)
        
        mainLabel.left(to: foreground, offset: 15.0)
        mainLabel.right(to: foreground)
        mainLabel.centerY(to: foreground)
        
        secondaryLabel.left(to: foreground, offset: 15.0)
        secondaryLabel.right(to: foreground)
        secondaryLabel.topToBottom(of: mainLabel, offset: 5.0)
        
    }
}

extension MovieCell: ConfigurableCell {
    func configure(_ item: Movie, at indexPath: IndexPath) {

    }
}

