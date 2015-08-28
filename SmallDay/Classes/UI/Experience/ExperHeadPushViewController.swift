//
//  ExperHeadPushViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/27.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验点击头部scrollView推出的控制器

import UIKit

class ExperHeadPushViewController: UIViewController, UIWebViewDelegate {
    lazy var loadImageView: UIImageView? = {
        let loadImageView = UIImageView(frame: CGRectMake((AppWidth - 44.0) * 0.5, 200, 44, 51))
        loadImageView.animationImages = self.loadAnimImages!
        loadImageView.animationRepeatCount = 100
        loadImageView.animationDuration = 1.0
        return loadImageView
        }()
    
    lazy var loadAnimImages: [UIImage]? = {
        var images = [UIImage]()
        for i in 0...24 {
            let image = UIImage(named: String(format: "zanimabg%02d", i))
            images.append(image!)
        }
        
        return images
        }()
    
    lazy var webView: UIWebView? = {
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
        view.addSubview(loadImageView!)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_1", highlImageName: "share_2", targer: self, action: "sharedClick")
    }

    func sharedClick() {
    
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        loadImageView!.startAnimating()
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        loadImageView!.stopAnimating()
        webView.scrollView.contentSize.height += NavigationH
    }

}
