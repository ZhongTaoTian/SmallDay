//
//  theme.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  全局公用属性

import UIKit

struct theme {
    ///  APP屏幕的宽度
    static let appWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
    ///  APP屏幕的高度
    static let appHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
    ///  APP导航条barButtonItem文字大小
    static let SDNavTitleFont: UIFont = UIFont.systemFontOfSize(18)
    /// ViewController的背景颜色
    static let SDBackgroundColor: UIColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
}
