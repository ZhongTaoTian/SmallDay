
//
//  GuessLikeView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/8.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  猜你喜欢view

import UIKit

class GuessLikeView: UIView {

    class func guessLikeViewFromXib() -> GuessLikeView {
        let guessLike = NSBundle.mainBundle().loadNibNamed("GuessLikeView", owner: nil, options: nil).last as! GuessLikeView
        return guessLike
    }

}
