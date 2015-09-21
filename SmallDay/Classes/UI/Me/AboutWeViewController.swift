//
//  AboutWeViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/1.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  关于我们

import UIKit

class AboutWeViewController: UIViewController {

    init() {
        super.init(nibName: "AboutWeViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "AboutWeViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "关于我们"
    }
}
