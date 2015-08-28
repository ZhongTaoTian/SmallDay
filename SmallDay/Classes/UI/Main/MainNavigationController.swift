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
        
        self.interactivePopGestureRecognizer.delegate = nil;
    }

    override func pushViewController(viewController: UIViewController, animated: Bool) {
        
        if self.childViewControllers.count > 0 {
            let vc = self.childViewControllers[0] as! UIViewController

            //设置返回按钮属性
            var backBtn = UIButton.buttonWithType(UIButtonType.Custom) as! UIButton
            if self.childViewControllers.count == 1 {
                backBtn.setTitle(vc.tabBarItem.title!, forState: .Normal)
            } else {
                backBtn.setTitle("返回", forState: .Normal)
            }
            backBtn.titleLabel?.font = UIFont.systemFontOfSize(17)
            backBtn.setTitleColor(UIColor.blackColor(), forState: .Normal)
            backBtn.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
            backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
            backBtn.setImage(UIImage(named: "back_2"), forState: .Highlighted)
            backBtn.addTarget(self, action: "backBtnClick", forControlEvents: .TouchUpInside)
            backBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
            backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -25, 0, 0)
            backBtn.titleEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
            backBtn.frame = CGRectMake(0, 0, 44, 40)

            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
            viewController.hidesBottomBarWhenPushed = true
        }
        
        super.pushViewController(viewController, animated: animated)
    }
    
    func backBtnClick() {
        self.popViewControllerAnimated(true)
    }

}