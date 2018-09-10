//
//  WebViewController.swift
//  TheMovieDB
//
//  Created by Gavin on 10/09/2018.
//  Copyright © 2018 Safehouse. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: ModalViewController {
    
    private var webView = WKWebView()
    private var urlToLoad: URL?
    private var htmlToLoad: String?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(urlToLoad: URL) {
        super.init(nibName: nil, bundle: nil)
        self.urlToLoad = urlToLoad
        setupWebview()
        setupConstraints()
    }
    
    init(htmlToLoad: String) {
        super.init(nibName: nil, bundle: nil)
        self.htmlToLoad = htmlToLoad
    }
    
    override func loadView() {
        super.loadView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
        tabBarController?.tabBar.isHidden = true
    }
    
    func setupWebview() {
        webView.navigationDelegate = self
        view.addSubview(webView)
        if let url = urlToLoad {
            webView.load(URLRequest(url: url))
        }
    }
    
    func setupConstraints() {
        webView.topToBottom(of: super.closeButton)
        webView.left(to: view)
        webView.right(to: view)
        webView.bottom(to: view, offset: -5.0)
    }
}

extension WebViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        if error._code == NSURLErrorNotConnectedToInternet {
            
        }
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
    
    }
}
