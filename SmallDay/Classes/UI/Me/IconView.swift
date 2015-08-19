//
//  IconView.swift
//  SmallDay
//
//  Created by MacBook on 15/8/19.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class IconView: UIView {

    var iconButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clearColor()
        iconButton = UIButton.buttonWithType(.Custom) as? UIButton
        iconButton.setImage(UIImage(named: "my"), forState: .Normal)
        iconButton.addTarget(self, action: "iconBtnClick", forControlEvents: .TouchUpInside)
        addSubview(iconButton)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        let mrgin: CGFloat = 8
        iconButton.frame = CGRectMake(mrgin, mrgin, self.width - mrgin * 2, self.height - mrgin * 2)
        iconButton.setBackgroundImage(UIImage(named: "white")?.imageClipOvalImage(), forState: .Normal)
    }
    
    override func drawRect(rect: CGRect) {
        let circleWidth: CGFloat = 2
        // 圆角矩形
        let path = UIBezierPath(roundedRect: CGRectMake(circleWidth, circleWidth, rect.size.width - circleWidth * 2, rect.size.width - circleWidth * 2), cornerRadius: rect.size.width)
        path.lineWidth = circleWidth
        UIColor.whiteColor().set()
        path.stroke()
    }
    
    func iconBtnClick() {
        print("头像按钮被点击了")
    }
}
