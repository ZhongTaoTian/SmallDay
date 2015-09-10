//
//  ExploreBottomView.swift
//  SmallDay
//
//  Created by MacBook on 15/9/11.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

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
    /*
    let exploreBottomView = ExploreBottomView.exploreBottomViewFromXib()
    exploreBottomView.titleLabel.text = "电话"
    exploreBottomView.subTitleLabel.text = model!.telephone
    let tap = UITapGestureRecognizer(target: self, action: "telephoneBottomClick:")
    exploreBottomView.addGestureRecognizer(tap)
    bottomViews.append(exploreBottomView)
    */

}

