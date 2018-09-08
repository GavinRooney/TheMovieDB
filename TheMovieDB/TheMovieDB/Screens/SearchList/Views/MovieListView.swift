//
//  MovieListView.swift
//  TheMovieDB
//
//  Created by Gavin on 08/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import TinyConstraints

protocol MovieListViewDelegate {
    func movieSelected(movie: Movie)
    func search(query: String?)
}

class MovieListView: UIView {
    
    private let searchField = UITextField()
    private let tableView = UITableView()
    private var dataSource: MovieListDataSource?
    private let searchImageView = UIImageView()
    
    private let titleLabel = HeaderLabel()
    public var delegate: MovieListViewDelegate?

    private var bgImageView = UIImageView()
    private var bgTitleLabel = LargeFadedTitleLabel()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
}

extension MovieListView {
    
    private func setup() {
        setupSearch()
        setupbgImageView()
        setupBGTitleLabel()
        setupTitleLabel()
        setupTableView()
        setupConstraints()
        
        titleLabel.alpha = 0
        tableView.alpha = 0
        bgTitleLabel.alpha = 0
        
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.titleLabel.alpha = 1
            self.tableView.alpha = 1
            self.bgTitleLabel.alpha = 1
            
        }, completion: { finished in
            
        })
    }
    
    private func setupSearch() {
        searchField.attributedPlaceholder = NSAttributedString(string: "SEARCH".localized, attributes: [
            .foregroundColor: Style.Colors.lightGrey,
            .font: Style.Fonts.ctaText!])
        searchField.delegate = self
        searchField.font = Style.Fonts.cellText
        searchField.textColor = Style.Colors.lightGrey
        searchField.tintColor = Style.Colors.lightGrey
        addSubview(searchField)
        searchField.returnKeyType = .search
        addSubview(searchImageView)
        searchImageView.image = UIImage(named: "search-icon")
        
    }
    
    private func setupbgImageView () {
        bgImageView.image =  UIImage(named: "bg-detail")
        bgImageView.alpha = 0.3
        addSubview(bgImageView)
    }
    
    private func setupTitleLabel() {
        addSubview(titleLabel)
        titleLabel.text = "MOVIES".localized
    }
    
    private func setupBGTitleLabel() {
        addSubview(bgTitleLabel)
        bgTitleLabel.text = "MOVIES".localized
    }
    
    private func setupTableView() {
        tableView.register(MovieCell.self, forCellReuseIdentifier: String(describing: MovieCell.self))
        tableView.backgroundColor = UIColor.clear
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.tableFooterView = UIView()
        tableView.contentInset = UIEdgeInsetsMake(85, 0, 0, 0)
        addSubview(tableView)
    }
    
    private func setupConstraints() {
        
        bgImageView.edgesToSuperview()
        
        titleLabel.centerX(to: self)
        titleLabel.top(to: self, offset: 30.0)
        
        tableView.topToBottom(of: searchField, offset: 0.0)
        tableView.bottom(to: self, offset: 0)
        tableView.trailing(to: self)
        tableView.leading(to: self)
        
        bgTitleLabel.topToBottom(of: searchField, offset: 0.0)
        bgTitleLabel.trailing(to: self)
        bgTitleLabel.leading(to: self)
        
        searchImageView.left(to: self, offset: 20)
        searchImageView.centerY(to: searchField)
        searchImageView.width(20.0)
        searchImageView.height(20.0)
        
        searchField.top(to: titleLabel, offset: 10.0)
        searchField.leftToRight(of: searchImageView, offset: 10.0)
        searchField.right(to: self, offset: -20.0)
        searchField.height(50.0)
        
    }
    
}

extension MovieListView {
    func updateList(movies: [Movie]) {
        dataSource = MovieListDataSource(tableView: tableView, array: movies, showSectionIndex: false)
        tableView.reloadData()
    }
}

extension MovieListView: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
}

extension MovieListView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        delegate?.search(query: textField.text)
        textField.resignFirstResponder()
        return true
    }
}



