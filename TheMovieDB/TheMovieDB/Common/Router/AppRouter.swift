//
//  AppRouter.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

final class AppRouter {
    
    private static let appDelegate = UIApplication.shared.delegate
    
    private static func removeAllSubviews() {
        
        if let window = appDelegate?.window, let currentVc = window?.rootViewController {
            for view in currentVc.view.subviews {
                view.removeFromSuperview()
            }
            currentVc.dismiss(animated: true, completion: nil)
        }
    }
    
    static func loadSplash() {
        
        AppRouter.removeAllSubviews()
        let splash = SplashViewController()
        AppRouter.appDelegate?.window??.rootViewController = splash
        
    }
    
    static func setMovieListAsRoot() {
        AppRouter.removeAllSubviews()
        
        let vc = MovieListViewController()
        let navVC = UINavigationController(rootViewController: vc)
        AppRouter.appDelegate?.window??.rootViewController = navVC
    }
    
}
