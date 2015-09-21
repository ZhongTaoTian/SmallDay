//
//  MainTabBarController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  自定义TabBarController

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpAllChildViewController()

        self.setValue(MainTabBar(), forKey: "tabBar")
    }

    /// 初始化所有子控制器
    private func setUpAllChildViewController() {
        // 探店
        tabBaraAddChildViewController(vc: ExploreViewController(), title: "探店", imageName: "recommendation_1", selectedImageName: "recommendation_2")
        // 体验
        tabBaraAddChildViewController(vc: ExperienceViewController(), title: "体验", imageName: "broadwood_1", selectedImageName: "broadwood_2")
        // 分类
        tabBaraAddChildViewController(vc: ClassifyViewController(), title: "分类", imageName: "classification_1", selectedImageName: "classification_2")
        // 我的
        tabBaraAddChildViewController(vc: MeViewController(), title: "我的", imageName: "my_1", selectedImageName: "my_2")
        
    }
    
    private func tabBaraAddChildViewController(vc vc: UIViewController, title: String, imageName: String, selectedImageName: String) {
        vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: UIImage(named: selectedImageName))
        vc.view.backgroundColor = theme.SDBackgroundColor
        let nav = MainNavigationController(rootViewController: vc)
        addChildViewController(nav)
    }
}

class MainTabBar: UITabBar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translucent = false
        self.backgroundImage = UIImage(named: "tabbar")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

    }
}
