//
//  ExpositorsManualViewController.swift
//  Conapeme 2019
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 2/20/19.
//  Copyright © 2019 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import UIKit
import WebKit

class ExpositorsManualViewController:UIViewController {
    
    var webView:WKWebView = {
        let wb = WKWebView(frame: .zero)
        wb.translatesAutoresizingMaskIntoConstraints = false
        return wb
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSubviews()
        layoutSubviews()
        setupNavitagionItems()
        //
        //        let url: URL! = URL(string: "http://developer.apple.com/iphone/library/documentation/UIKit/Reference/UIWebView_Class/UIWebView_Class.pdf")
        //        webView.load(URLRequest(url: url))
        navigationItem.title = "Manual del Expositor"
        
        if let pdf = Bundle.main.url(forResource: "2", withExtension: "pdf", subdirectory: nil, localization: nil)  {
            let req = NSURLRequest(url: pdf)
            webView.load(req as URLRequest)
        }
        
    }
    
    func setupNavitagionItems(){
        let menuButton = UIBarButtonItem(title: "Ok", style: .plain, target: self, action: #selector(dismisVC))
        navigationItem.setLeftBarButton(menuButton, animated: true)
    }
    
    @objc func dismisVC(){
        dismiss(animated: true, completion: nil)
    }
    
    func setupSubviews(){
        view.addSubview(webView)
    }
    
    func layoutSubviews(){
        webView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        webView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        webView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
    }
    
    
}
