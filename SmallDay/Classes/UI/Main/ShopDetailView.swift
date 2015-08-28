//
//  ShopDetailView.swift
//  SmallDay
//
//  Created by MacBook on 15/8/28.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  店发现,详情view

import UIKit

class ShopDetailView: UIView {
    
    var findLabel: UILabel!
    var detailLabel: UILabel!
    var middleLineView: UIView!
    var bottomLineView: UIView!
    var delegate: ShopDetailViewDelegate?
    let bottomLineScale: CGFloat = 0.6
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.whiteColor()
        
        findLabel = UILabel()
        setLabel(findLabel, text: "店 · 发现", action: "labelClick:", tag: 0)
        
        detailLabel = UILabel()
        setLabel(detailLabel, text: "店 · 详情", action: "labelClick:", tag: 1)
        
        middleLineView = UIView()
        middleLineView.backgroundColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 0.1)
        self.addSubview(middleLineView)
        
        bottomLineView = UIView()
        bottomLineView.backgroundColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 1)
        self.addSubview(bottomLineView)
    }
    
    private func setLabel(label: UILabel, text: String, action: Selector, tag: Int) {
        label.text = text
        label.textAlignment = NSTextAlignment.Center
        label.font = UIFont.systemFontOfSize(20)
        label.textColor = UIColor.blackColor()
        label.userInteractionEnabled = true
        label.tag = tag
        let tap = UITapGestureRecognizer(target: self, action: action)
        label.addGestureRecognizer(tap)
        self.addSubview(label)
    }
    
    
    func labelClick(tap: UITapGestureRecognizer) {
        let index = tap.view!.tag
        
        if delegate != nil {
            if delegate!.respondsToSelector("shopDetailView:didSelectedLable:") {
                delegate!.shopDetailView!(self, didSelectedLable: index)
            }
        }
        let labelW = self.width * 0.5
        let bottomLineW = labelW * bottomLineScale
        let bottomLineH: CGFloat = 1.5
        let bottomLineX: CGFloat = CGFloat(index) * labelW + (labelW - bottomLineW) * 0.5
        let bottomLineY: CGFloat = self.height - bottomLineH
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.bottomLineView.frame = CGRectMake(bottomLineX, bottomLineY, bottomLineW, bottomLineH)
        })
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelW = self.width * 0.5
        let labelH = self.height
        findLabel.frame = CGRectMake(0, 0, labelW, labelH)
        detailLabel.frame = CGRectMake(labelW, 0, labelW, labelH)
        
        let lineH = labelH * 0.5
        middleLineView.frame = CGRectMake(labelW - 0.5, (labelH - lineH) * 0.5, 1,  lineH)
        let bottomLineW = labelW * bottomLineScale
        bottomLineView.frame = CGRectMake((labelW - bottomLineW) * 0.5, labelH - 1.5, bottomLineW, 1.5)
    }
    
}

@objc protocol ShopDetailViewDelegate: NSObjectProtocol {

    optional func shopDetailView(shopDetailView: ShopDetailView, didSelectedLable index: Int)
}





