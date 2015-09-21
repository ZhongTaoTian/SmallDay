//
//  ExploreBottomView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/11.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验详情ViewController动态加载的地步提醒View

import UIKit

class ExploreBottomView: UIView {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    @IBOutlet weak var arrowImageView: UIImageView!
    @IBOutlet weak var remindBtn: UIButton!
    @IBOutlet weak var bottomLineView: UIView!
    
    class func exploreBottomViewFromXib(title: String, subTitle: String, target: AnyObject, action: Selector, showBtn: Bool, showArrow: Bool) -> ExploreBottomView {
        
        let expView = NSBundle.mainBundle().loadNibNamed("ExploreBottomView", owner: nil, options: nil).last as! ExploreBottomView
        expView.titleLabel.text = title
        expView.subTitleLabel.text = subTitle
        
        let tap = UITapGestureRecognizer(target: target, action: action)
        expView.addGestureRecognizer(tap)
        expView.remindBtn.hidden = !showBtn
        expView.arrowImageView.hidden = !showArrow
        expView.backgroundColor = UIColor.clearColor()
        expView.remindBtn.enabled = false
        expView.userInteractionEnabled = true
        return expView
    }
}

