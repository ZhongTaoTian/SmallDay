//
//  RecommendViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/9/12.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  应用推荐

import UIKit

class RecommendViewController: UIViewController {

    private lazy var webView: UIWebView! = {
        let webView = UIWebView(frame: MainBounds)
        let url = NSURL(string: "http://www.jianshu.com/users/5fe7513c7a57/latest_articles")!
        webView.loadRequest(NSURLRequest(URL: url))
        webView.delegate = self
        return webView
        }()
    
    private let loadAnimatIV: LoadAnimatImageView! = LoadAnimatImageView.sharedManager
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "应用推荐"
        view.backgroundColor = theme.SDWebViewBacagroundColor
        view.addSubview(webView)
    }

}

extension RecommendViewController: UIWebViewDelegate {
    
    func webViewDidStartLoad(webView: UIWebView) {
        loadAnimatIV.startLoadAnimatImageViewInView(view, center: view.center)
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadAnimatIV.stopLoadAnimatImageView()
    }
    
}