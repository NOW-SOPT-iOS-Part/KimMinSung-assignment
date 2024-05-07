//
//  MakeAccountWebViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/16.
//

import UIKit
import WebKit


class MakeAccountWebViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        webView.isOpaque = false
        view = webView
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        let myURL = URL(string:"https://user.tving.com/pc/user/tving/regist.tving?returnUrl=https://www.tving.com/onboarding")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
