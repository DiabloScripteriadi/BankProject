//
//  BetWebkitVC.swift
//  BNK
//
//  Created by chasemedkcorto on 03.04.26.
//


import UIKit
import WebKit
final class BetWebkitVC: UIViewController {
    private let webView = WKWebView()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(webView)
        guard let url = URL(string: "https://asvla.com") else { return }
        webView.load(URLRequest(url: url))
        
    }
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}