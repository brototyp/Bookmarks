//
//  DetailViewController.swift
//  bookmarks
//
//  Created by Cornelius Horstmann on 02.01.18.
//  Copyright © 2018 brototyp. All rights reserved.
//

import UIKit
import WebKit
import bytes

// TODO: Add content, for the initial iPad Screen
class DetailViewController: UIViewController {

    let webView = WKWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        webView.constrainEdges(to: view)
        webView.allowsBackForwardNavigationGestures = true
        webView.navigationDelegate = self
    }

    var detailItem: Bookmark? {
        didSet {
            guard let detailItem = detailItem else { return }
            title = detailItem.title
            let request = URLRequest(url: detailItem.url)
            webView.load(request)
        }
    }
}

extension DetailViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }
}
