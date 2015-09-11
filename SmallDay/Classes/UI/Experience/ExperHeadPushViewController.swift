//
//  ExperHeadPushViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/27.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验点击头部scrollView推出的控制器

import UIKit

class ExperHeadPushViewController: UIViewController, UIWebViewDelegate {

    private lazy var webView: UIWebView? = {
        let webView = UIWebView(frame: UIScreen.mainScreen().bounds)
        webView.delegate = self
        webView.backgroundColor = theme.SDBackgroundColor
        return webView
        }()

    var model:ExperienceHeadModel? {
        didSet {
            webView?.loadRequest(NSURLRequest(URL: NSURL(string: model!.mobileURL!)!))
            navigationItem.title = model!.title
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.SDBackgroundColor
        view.addSubview(webView!)
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_1", highlImageName: "share_2", targer: self, action: "sharedClick")
    }

    func sharedClick() {
    
    }
    
    func webViewDidStartLoad(webView: UIWebView) {

        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.scrollView.contentSize.height += NavigationH
    }

}
