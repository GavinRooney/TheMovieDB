//
//  ModalViewController.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

class ModalViewController: UIViewController {
    
    public var closeButton = CloseButton()
    
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func setup() {
        view.backgroundColor = .white
        setupCloseButton()
        setupConstraints()
    }
}

extension ModalViewController {
    
    private func setupCloseButton() {
        closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
        view.addSubview(closeButton)
    }
    
    private func setupConstraints() {
        closeButton.top(to: self.view, offset: 20)
        closeButton.right(to: self.view, offset: -20.0)
    }
    
    @objc private func close() {
        dismiss(animated: true, completion: nil)
    }
}
