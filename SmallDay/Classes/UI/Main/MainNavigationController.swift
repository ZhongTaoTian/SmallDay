//
//  MainNavigationViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  基类导航控制器

import UIKit

class MainNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let right = UIButton.buttonWithType(.Custom) as! UIButton
        right.setTitle("广州", forState: .Normal)
        right.frame = CGRectMake(0, 0, 50, 30)
        right.setImage(UIImage(named: "home_down"), forState: .Normal)
        
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        
        
        super.pushViewController(viewController, animated: animated)
    }

}