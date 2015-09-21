//
//  DoubleTextView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探店的titleView

import UIKit

class DoubleTextView: UIView {
    
    private let leftTextButton: NoHighlightButton =  NoHighlightButton()
    private let rightTextButton: NoHighlightButton = NoHighlightButton()
    private let textColorFroNormal: UIColor = UIColor(red: 100 / 255.0, green: 100 / 255.0, blue: 100 / 255.0, alpha: 1)
    private let textFont: UIFont = theme.SDNavTitleFont
    private let bottomLineView: UIView = UIView()
    private var selectedBtn: UIButton?
    weak var delegate: DoubleTextViewDelegate?

    /// 便利构造方法
    convenience init(leftText: String, rigthText: String) {
        self.init()
        // 设置左边文字
        setButton(leftTextButton, title: leftText, tag: 100)
        // 设置右边文字
        setButton(rightTextButton, title: rigthText, tag: 101)
        // 设置底部线条View
        setBottomLineView()
        
        titleButtonClick(leftTextButton)
    }
    
    private func setBottomLineView() {
        bottomLineView.backgroundColor = UIColor(red: 60 / 255.0, green: 60 / 255.0, blue: 60 / 255.0, alpha: 1)
        addSubview(bottomLineView)
    }
    
    private func setButton(button: UIButton, title: String, tag: Int) {
        button.setTitleColor(UIColor.blackColor(), forState: .Selected)
        button.setTitleColor(textColorFroNormal, forState: .Normal)        
        button.titleLabel?.font = textFont
        button.tag = tag
        button.addTarget(self, action: "titleButtonClick:", forControlEvents: .TouchUpInside)
        button.setTitle(title, forState: .Normal)
        addSubview(button)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let btnW = width * 0.5
        leftTextButton.frame = CGRectMake(0, 0, btnW, height)
        rightTextButton.frame = CGRectMake(btnW, 0, btnW, height)
        bottomLineView.frame = CGRectMake(0, height - 2, btnW, 2)
    }
    
    func titleButtonClick(sender: UIButton) {
        selectedBtn?.selected = false
        sender.selected = true
        selectedBtn = sender
        bottomViewScrollTo(sender.tag - 100)
        delegate?.doubleTextView(self, didClickBtn: sender, forIndex: sender.tag - 100)
    }
    
    func bottomViewScrollTo(index: Int) {
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.bottomLineView.frame.origin.x = CGFloat(index) * self.bottomLineView.width
        })
    }
    
    func clickBtnToIndex(index: Int) {
        let btn: NoHighlightButton = self.viewWithTag(index + 100) as! NoHighlightButton
        self.titleButtonClick(btn)
    }
}

/// DoubleTextViewDelegate协议
protocol DoubleTextViewDelegate: NSObjectProtocol{

    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int)
    
}

/// 没有高亮状态的按钮
class NoHighlightButton: UIButton {
    /// 重写setFrame方法
    override var highlighted: Bool {
        didSet{
            super.highlighted = false
        }
    }
}
