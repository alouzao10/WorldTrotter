//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Alex Louzao on 2/8/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{

    var webView: WKWebView!
    override func loadView(){
        webView = WKWebView()
        webView.navigationDelegate = self
        view = webView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("WebViewController loaded its view.")
        webView = WKWebView()
        view = webView
        
        let url = URL(string: "https://www.bignerdranch.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }
    
    //var webView: WKWebView!
   /* override func loadView() {
        webView = WKWebView()
        view = webView
        
        let url = URL(string: "www.bignerdranch.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }*/
    
  
}


    
    

