//
//  CustomCalloutView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/19.
//  Copyright © 2015年 维尼的小熊. All rights reserved.
//  自定义气泡

import UIKit

class CustomCalloutView: UIView {
    private var kArrorHeight: CGFloat = 10
    private let adressLabel = UILabel()
    private let navBtn = UIButton()
    
    var adressTitle: String? {
        didSet {
            adressLabel.text = adressTitle
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = UIColor.clearColor()
        adressLabel.textAlignment = .Center
        adressLabel.font = UIFont.systemFontOfSize(20)
        adressLabel.text = "asdasdasdasdasadsasdakljkfjsfjsjlkfjsdfjslfdjlsf"
        addSubview(adressLabel)
        addSubview(navBtn)
        
        navBtn.setBackgroundImage(UIImage(named: "daohang"), forState: .Normal)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        navBtn.frame = CGRectMake(self.width - 50 - 10, (self.height - 25) * 0.5, 50, 25)
        adressLabel.frame = CGRectMake(10, 0, self.width - 80, self.height)
    }
    
    override func drawRect(rect: CGRect) {
        drawInContext(UIGraphicsGetCurrentContext()!)
    }
    
    private func drawInContext(context: CGContextRef) {
        CGContextSetLineWidth(context, 2.0)
        CGContextSetFillColorWithColor(context, UIColor.whiteColor().CGColor)
        
        getDrawPath(context)
        CGContextFillPath(context)
    }
    
    private func getDrawPath(context: CGContextRef) {
        let rrect = self.bounds
        let radius: CGFloat = 6.0
        let minX = CGRectGetMinX(rrect)
        let midX = CGRectGetMidX(rrect)
        let maxX = CGRectGetMaxX(rrect)
        let minY = CGRectGetMinY(rrect)
        let maxY = CGRectGetMaxY(rrect) - kArrorHeight
        
        CGContextMoveToPoint(context, midX + kArrorHeight, maxY)
        CGContextMoveToPoint(context, midX, maxY + kArrorHeight)
        CGContextMoveToPoint(context, midX - kArrorHeight, maxY)
        
        CGContextAddArcToPoint(context, minX, maxY, minX, minY, radius)
        CGContextAddArcToPoint(context, minX, minX, maxX, minY, radius)
        CGContextAddArcToPoint(context, maxX, minY, maxX, maxX, radius)
        CGContextAddArcToPoint(context, maxX, maxY, midX, maxY, radius)
        CGContextClosePath(context)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
