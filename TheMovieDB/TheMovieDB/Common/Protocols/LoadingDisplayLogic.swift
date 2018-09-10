//
//  LoadingDisplayLogic.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit

protocol LoadingDisplayLogic: class {
    var animationView: LoadingAnimationView? { get set }
    func showLoadingAnimation()
    func hideLoadingAnimation()
}

extension LoadingDisplayLogic {
    
    func showLoadingAnimation() {
        if self is UIViewController {
            self.animationView = LoadingAnimationView.show(self as! UIViewController)
        } else {
            fatalError("Class adopting LoadingDisplayLogic protocol must be a subclass of UIViewController")
        }
    }
    
    func hideLoadingAnimation() {
        LoadingAnimationView.hide(self.animationView)
    }
}
