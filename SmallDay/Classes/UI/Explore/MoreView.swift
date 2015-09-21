//
//  MoreView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/8.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  猜你喜欢View

import UIKit

class MoreView: UIView {

    @IBOutlet weak private var imageImageView: UIImageView!
    @IBOutlet weak private var adressLabel: UILabel!
    @IBOutlet weak private var titleLabel: UILabel!
    
    var model: GuessLikeModel? {
        didSet {
            titleLabel.text = model?.title
            adressLabel.text = model?.address
            if let imgStr = model?.imgs?.last {
                imageImageView.wxn_setImageWithURL(NSURL(string: imgStr)!, placeholderImage: UIImage(named: "quesheng")!)
            }
        }
    }
    
    class func moreViewWithGuessLikeModel(model: GuessLikeModel) -> MoreView{
        let moreView = NSBundle.mainBundle().loadNibNamed("MoreView", owner: nil, options: nil).last as! MoreView
        moreView.model = model
        return moreView
    }
}
