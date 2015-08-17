//
//  MeViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  我的

import UIKit

class MeViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化导航条上的内容
        setNav()
    }

    func setNav() {
        navigationItem.title = "我的"
        navigationItem.leftBarButtonItem = nil
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "settinghhhh", highlImageName: "settingh", targer: self, action: "settingClick")
    }
    
    func settingClick() {
    
    }
    
}
