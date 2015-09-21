//
//  CityCollectionReusableView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/17.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  选择城市的headView

import UIKit

class CityHeadCollectionReusableView: UICollectionReusableView {
    var headTitleLabel: UILabel = UILabel()
    var headTitle: String? {
        didSet {
            headTitleLabel.text = headTitle
            headTitleLabel.font = UIFont.systemFontOfSize(18)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUp()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setUp()
    }
    
    func setUp() {
        headTitleLabel.textAlignment = .Center
        headTitleLabel.font = UIFont.systemFontOfSize(22)
        headTitleLabel.textColor = UIColor.blackColor()
        addSubview(headTitleLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.headTitleLabel.frame = self.bounds
    }
}

class CityFootCollectionReusableView: UICollectionReusableView {
    
    var titleLabel: UILabel?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        titleLabel = UILabel()
        titleLabel?.text = "更多城市,敬请期待..."
        titleLabel?.textAlignment = .Center
        titleLabel?.textColor = UIColor.darkGrayColor()
        titleLabel?.font = UIFont.systemFontOfSize(16)
        addSubview(titleLabel!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel?.frame = self.bounds
    }
}