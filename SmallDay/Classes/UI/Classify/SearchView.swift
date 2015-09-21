//
//  SearchView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/18.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  搜索控制器

import UIKit

protocol SearchViewDelegate: NSObjectProtocol {
    func searchView(searchView: SearchView, searchTitle: String)
}

class SearchView: UIView {
    /// 动画时长
    private let animationDuration = 0.5
    var searchTextField: SearchTextField!
    var searchBtn: UIButton!
    /// 是否已经缩放过
    private var isScale: Bool = false
    weak var delegate: SearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        searchTextField = SearchTextField()
        let margin: CGFloat = 20
        searchTextField.frame = CGRectMake(margin, 20 * 0.5, AppWidth - 2 * margin, 30)
        searchTextField.delegate = self
        addSubview(searchTextField)
        
        searchBtn = SearchButton(frame: CGRect(x: AppWidth - 100, y: 0, width: 100, height: 50), target: self, action: "searchBtnClick:")

        addSubview(searchBtn)
        
        // 监听键盘弹出
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillshow", name: UIKeyboardWillShowNotification, object: nil)
    }

    func keyBoardWillshow() {
        
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            self.searchBtn.alpha = 1
            self.searchBtn.selected = false
            if !self.isScale {
                self.searchTextField.frame.size.width = self.searchTextField.width - 60
                self.isScale = true
            }
        })
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        self.endEditing(true)
    }
    
    func resumeSearchTextField() {
        UIView.animateWithDuration(animationDuration, animations: { () -> Void in
            if self.isScale {
                self.searchBtn.alpha = 0
                self.searchBtn.selected = false
                self.searchTextField.frame.size.width = self.searchTextField.width + 60
                self.isScale = false
            }
        })
    }
    
    func searchBtnClick(sender: UIButton) {
        if sender.selected {
            sender.selected = false
            searchTextField.becomeFirstResponder()
        } else if searchTextField.text!.isEmpty {
            return
        } else {
            sender.selected = true
            if delegate != nil {
                delegate!.searchView(self, searchTitle: searchTextField.text!)
            }
        }
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension SearchView: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        if textField.text!.isEmpty {
            return false
        }
        
        searchBtnClick(searchBtn)
        return true
    }
}
