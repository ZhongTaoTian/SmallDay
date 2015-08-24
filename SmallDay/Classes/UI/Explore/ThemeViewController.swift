//
//  ThemeViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/22.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  Theme点击出来的ViewController

import UIKit

class ThemeViewController: UIViewController, UIWebViewDelegate {
    
    var themeModel: ThemeModel? {
        didSet {
            if themeModel?.hasweb == 1 {
                self.webView?.loadRequest(NSURLRequest(URL: NSURL(string: themeModel!.themeurl!)!))
                
            }
        }
    }
    
    var modalBtn: UIButton! = UIButton()
    
    lazy var webView: UIWebView? = {
        let web = UIWebView(frame: UIScreen.mainScreen().bounds)
        web.backgroundColor = theme.SDBackgroundColor
        web.delegate = self
        return web
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(webView!)
        
        // 添加modalBtn
        addModalBtn()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "share_1", highlImageName: "share_2", targer: self, action: "shareClick")
    }
    
    func shareClick() {
        
    }
    
    func addModalBtn() {
        let modalWH: CGFloat = 64
        modalBtn.frame = CGRectMake(10, theme.appHeight - modalWH - 10 - 64, modalWH, modalWH)
        modalBtn.setImage(UIImage(named: "themelist"), forState: .Normal)
        modalBtn.setImage(UIImage(named: "themeweb"), forState: .Selected)
        modalBtn.addTarget(self, action: "modalClick:", forControlEvents: .TouchUpInside)
        view.addSubview(modalBtn)
    }
    
    func modalClick(sender: UIButton) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.webView!.scrollView.contentSize.height += 64
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        modalBtn.hidden = true
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        modalBtn.hidden = false
    }
}
