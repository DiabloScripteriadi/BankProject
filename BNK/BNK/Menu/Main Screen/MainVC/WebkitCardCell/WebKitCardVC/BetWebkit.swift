//
//  AirTimeWebkit.swift
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
        self.title = "BettingPage"
    }
     override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }
}
#warning("ყველა ინვესტ ბეთ და აირთაიმზე როდესაც მომმხარებელი შევა ინფრომაცია შეინახოს ოღონდ ვებვიუში გასაკეთებელი!!!!!")
