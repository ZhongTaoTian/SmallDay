//
//  ExploreViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探索

import UIKit

class ExploreViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化导航条内容
        setNav()
    }

    func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleClocr: UIColor.blackColor(), targer: self, action: "nearClick")
        
        let titleView = DoubleTextView(leftText: "美天", rigthText: "美辑");
        titleView.frame = CGRectMake(0, 0, 140, 44)
        navigationItem.titleView = titleView
    }
    
    /// 附近action
    func nearClick() {
        let nearVC = NearViewController()
        navigationController?.pushViewController(nearVC, animated: true)
    }
}
