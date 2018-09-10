//
//  LoadingAnimationView.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import Lottie
import TinyConstraints


class LoadingAnimationView: UIView {
    
    static func show(_ viewController: UIViewController) -> LoadingAnimationView {
        if let vc = viewController as? LoadingDisplayLogic, let animationView = vc.animationView {
            if animationView.superview == nil {
                viewController.view.addSubview(animationView)
            } else {
                viewController.view.bringSubview(toFront: animationView)
            }
            if !(animationView.loadingView?.isAnimationPlaying)! {
                animationView.loadingView?.play()
            }
            animationView.edges(to: viewController.view)
            return animationView
        }
        let loadingAnimationView = LoadingAnimationView()
        viewController.view.addSubview(loadingAnimationView)
        loadingAnimationView.edges(to: viewController.view)
        return loadingAnimationView
    }
    
    static func hide(_ loadingAnimationView: LoadingAnimationView?) {
        loadingAnimationView?.loadingView?.stop()
        loadingAnimationView?.removeFromSuperview()
    }
    
    private var loadingView: LOTAnimationView?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    private func setup() {
        
        self.backgroundColor = Style.Colors.white.withAlphaComponent(0.6)
        
        loadingView = LOTAnimationView(name: "loadingAnimation")
        loadingView?.contentMode = .scaleAspectFill
        self.addSubview(loadingView!)
        loadingView?.center(in: self)
        loadingView?.loopAnimation = true
        loadingView?.play()
    }
}
