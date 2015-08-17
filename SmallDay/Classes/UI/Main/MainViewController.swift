//
//  MainViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  基类控制器

import UIKit

class MainViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let right = textImageButton.buttonWithType(.Custom) as! textImageButton
        right.setTitle("北京", forState: .Normal)
        right.frame = CGRectMake(100, 100, 100, 35)
        right.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        right.setImage(UIImage(named: "home_down"), forState: .Normal)
        right.addTarget(self, action: "pushcityView", forControlEvents: .TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: right)
        
    }
    
    func pushcityView () {
        let cityVC = CityViewController()
        let nav = MainNavigationController(rootViewController: cityVC)
        presentViewController(nav, animated: true, completion: nil)
    }
}

// MARK: 自定义button,文字在左边 图片在右边
class textImageButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        titleLabel?.font = theme.SDNavTitleFont
        titleLabel?.contentMode = UIViewContentMode.Center
        imageView?.contentMode = UIViewContentMode.Left

    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.sizeToFit()
        titleLabel?.frame = CGRectMake(-5, 0, titleLabel!.width, height)
        imageView?.frame = CGRectMake(titleLabel!.width + 3 - 5, 0, width - titleLabel!.width - 3, height)
    }
}