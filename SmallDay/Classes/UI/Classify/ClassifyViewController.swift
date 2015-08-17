//
//  ClassifyViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  分类

import UIKit

class ClassifyViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 初始化导航条上的内容
        setNav()
    }

    func setNav() {
        navigationItem.title = "分类"
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "search_1", highlImageName: "search_2", targer: self, action: "searchClick")
    }
    
    func searchClick() {
        print("放大镜被点击")
    }
}
