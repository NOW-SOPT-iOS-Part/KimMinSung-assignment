//
//  FindPasswordWebViewController.swift
//  34th-SOPT-Seminar-Assignment
//
//  Created by 김민성 on 2024/04/16.
//

import UIKit
import WebKit


class FindPasswordWebViewController: UIViewController, WKUIDelegate {
    
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
        
        let myURL = URL(string:"https://user.tving.com/pc/user/findPassword.tving")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
}
