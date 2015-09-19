//
//  SearchButton.swift
//  SmallDay
//
//  Created by MacBook on 15/9/17.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  搜索控制器搜索按钮

import UIKit

class SearchButton: UIButton {
    
    init(frame: CGRect, target: AnyObject, action: Selector) {
        super.init(frame: frame)
        
        setTitle("搜索", forState: .Normal)
        setTitle("取消", forState: .Selected)
        titleLabel!.font = UIFont.systemFontOfSize(18)
        setTitleColor(UIColor.blackColor(), forState: .Normal)
        setTitleColor(UIColor.blackColor(), forState: .Selected)
        alpha = 0
        titleLabel!.textAlignment = .Center
        addTarget(target, action: action, forControlEvents: .TouchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
