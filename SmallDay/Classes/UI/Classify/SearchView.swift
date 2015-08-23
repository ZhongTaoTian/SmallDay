//
//  SearchView.swift
//  SmallDay
//
//  Created by MacBook on 15/8/18.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  搜索控制器

import UIKit

class SearchView: UIView {
    // 动画时长
    let animationDuration = 0.5
    var searchTextField: SearchTextField!
    var searchLabel: UILabel!
    var flag = 0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchTextField = SearchTextField()
        let margin: CGFloat = 20
        searchTextField.frame = CGRectMake(margin, 20 * 0.5, theme.appWidth - 2 * margin, 30)
        addSubview(searchTextField)
        
        searchLabel = UILabel()
        searchLabel.text = "搜索"
        searchLabel.font = UIFont.systemFontOfSize(18)
        searchLabel.textColor = UIColor.blackColor()
        searchLabel.alpha = 0
        searchLabel.textAlignment = .Center
        searchLabel.frame = CGRectMake(theme.appWidth - 100, 0, 100, 50)
        addSubview(searchLabel)
        
        // 监听键盘弹出
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillshow", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillhiden", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func keyBoardWillshow() {
        if flag == 0 {
            self.flag = 1
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.searchLabel.alpha = 1
                self.searchTextField.frame.size.width = self.searchTextField.width - 60
                
            })
        }
    }
    
    func keyBoardWillhiden() {
        if flag == 1 {
            self.flag = 0
            UIView.animateWithDuration(animationDuration, animations: { () -> Void in
                self.searchLabel.alpha = 0
                self.searchTextField.frame.size.width = self.searchTextField.width + 60
            })
        }
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        self.endEditing(true)
    }
}
