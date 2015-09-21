//
//  EventWebView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/17.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  美天详情webView

import UIKit

class EventWebView: UIWebView {

    init(rect: CGRect, webViewDelegate: UIWebViewDelegate?, webViewScrollViewDelegate: UIScrollViewDelegate?) {
        super.init(frame: rect)
        
        let topImageShopViewHeight: CGFloat = DetailViewController_TopImageView_Height - 20 + EventViewController_ShopView_Height
        scrollView.contentInset = UIEdgeInsets(top: topImageShopViewHeight, left: 0, bottom: 0, right: 0)
        scrollView.setContentOffset(CGPoint(x: 0, y: -topImageShopViewHeight), animated: false)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.delegate = webViewScrollViewDelegate
        delegate = webViewDelegate
        backgroundColor = theme.SDWebViewBacagroundColor
        paginationBreakingMode = UIWebPaginationBreakingMode.Column
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
