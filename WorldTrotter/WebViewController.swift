//
//  WebViewController.swift
//  WorldTrotter
//
//  Created by Alex Louzao on 2/8/17.
//  Copyright © 2017 ALcsc2310. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController{

    var webView: WKWebView!
    override func loadView(){
        webView = WKWebView()
        //webView.navigationDelegate = self
        view = webView
        
        //super.viewDidLoad()
        print("WebViewController loaded its view.")
        //webView = WKWebView()
        //view = webView
        
        let url = URL(string: "https://www.bignerdranch.com")!
        webView.load(URLRequest(url: url))
        //webView.allowsBackForwardNavigationGestures = true
    }
    
   /* override func viewDidLoad() {
        super.viewDidLoad()
        print("WebViewController loaded its view.")
        webView = WKWebView()
        view = webView
        
        let url = URL(string: "https://www.bignerdranch.com")!
        webView.load(URLRequest(url: url))
        webView.allowsBackForwardNavigationGestures = true
        
    }*/
      
}


    
    

