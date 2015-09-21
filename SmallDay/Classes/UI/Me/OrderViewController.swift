//
//  OrderViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/10.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  我的订单

import UIKit

class OrderViewController: UIViewController {
    
    init() {
        super.init(nibName: "OrderViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "OrderViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "我的订单"
        view.backgroundColor = theme.SDBackgroundColor
        
    }
    
}
