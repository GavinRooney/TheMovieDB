//
//  SplashViewController.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import Lottie

class SplashViewController: UIViewController {
    
    var splashAnimationLoop: LOTAnimationView?
    var splashAnimationTransitionIn: LOTAnimationView?
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        createSplashAnimation()
    }
}

extension SplashViewController {
    private func createSplashAnimation() {
        splashAnimationLoop = LOTAnimationView(name: "loop")
        splashAnimationLoop?.contentMode = .scaleAspectFill
        splashAnimationLoop?.frame = view.bounds
        view.addSubview(splashAnimationLoop!)
        splashAnimationLoop?.loopAnimation = true
        
        splashAnimationLoop?.play { (success : Bool) in
            self.view.addSubview(self.splashAnimationTransitionIn!)
            self.splashAnimationTransitionIn?.play { (success : Bool) in
                self.route()
            }
        }
        
        splashAnimationTransitionIn = LOTAnimationView(name: "transition-In")
        splashAnimationTransitionIn?.contentMode = .scaleAspectFill
        splashAnimationTransitionIn?.frame = view.bounds
        splashAnimationTransitionIn?.loopAnimation = false
        
        _ = Timer.scheduledTimer(timeInterval: 3, target: self, selector: #selector(runTimedCode), userInfo: nil, repeats: false)
    }
    
    @objc func runTimedCode () {
        endSplash()
    }
    
    func endSplash() {
        splashAnimationLoop?.loopAnimation = false
    }
    
    
    func route() {
        AppRouter.setMovieListAsRoot()
    }
}
