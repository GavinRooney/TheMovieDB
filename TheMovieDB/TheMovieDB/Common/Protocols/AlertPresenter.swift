//
//  AlertPresenter.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

public protocol AlertPresenter {}

public extension AlertPresenter where Self: UIViewController {
    
    func alert(title: String = "Error", message: String) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
}

