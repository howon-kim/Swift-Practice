//
//  SafariViewController.swift
//  coronamap
//
//  Created by Howon Kim on 2/2/20.
//  Copyright © 2020 Howon Kim. All rights reserved.
//

import UIKit
import WebKit

class SafariViewController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()

    }
    fileprivate func setupWebView() {
        webView.uiDelegate = self
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
        webView.translatesAutoresizingMaskIntoConstraints = false
        DispatchQueue.main.async {
            guard let url = URL(string: "http://www.cdc.go.kr/linkCheck.es?mid=a21111050200") else { return }
            self.webView.load(URLRequest(url: url))
        }
        view.addSubview(webView)
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 0).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: 0).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 0).isActive = true
    }
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        return nil
    }
    
}
