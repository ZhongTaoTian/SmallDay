//
//  MainTableView.swift
//  SmallDay
//
//  Created by MacBook on 15/9/17.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  对TableView共同代码的抽取

import UIKit

class MainTableView: UITableView {
    
    init(frame: CGRect, style: UITableViewStyle, dataSource: UITableViewDataSource?, delegate: UITableViewDelegate?) {
        super.init(frame: frame, style: style)
        self.delegate = delegate
        self.dataSource = dataSource
        separatorStyle = .None
        backgroundColor = theme.SDBackgroundColor
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
