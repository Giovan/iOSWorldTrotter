//
//  BrowserViewController.swift
//  WorldTrotter
//
//  Created by Giovanni Delgado on 8/25/17.
//  Copyright © 2017 elesoft. All rights reserved.
//
import UIKit
import WebKit

class BrowserViewController: UIViewController, WKUIDelegate {
    
    var webView: WKWebView!
    
    override func loadView() {
        let webConfiguration = WKWebViewConfiguration()
        webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.uiDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("BrowserViewController loaded its view.")
        
        let myURL = URL(string: "https://www.bignerdranch.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }
    
}
