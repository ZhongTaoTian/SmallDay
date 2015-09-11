//
//  BuyDetailViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/9/11.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验页的购买详情

import UIKit

class BuyDetailViewController: UIViewController {
    
    private lazy var webView: UIWebView = {
        let web = UIWebView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH))
        web.backgroundColor = theme.SDBackgroundColor
        web.scrollView.showsHorizontalScrollIndicator = false
        web.delegate = self
        return web
        }()
    
    var htmlStr: String? {
        didSet {
            var newStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: htmlStr!))
            self.webView.loadHTMLString(newStr as String, baseURL: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "购买须知"
        
        view.addSubview(webView)
    }
}

extension BuyDetailViewController: UIWebViewDelegate {

    func webViewDidFinishLoad(webView: UIWebView) {
        
    }
}