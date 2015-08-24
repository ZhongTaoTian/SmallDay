//
//  SearchViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/18.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  搜索控制器

import UIKit

class SearchViewController: UIViewController {

    var searchView: SearchView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "搜索"
        view.backgroundColor = theme.SDBackgroundColor

        // 添加顶部的searchView
        setSearchView()
    }

    func setSearchView() {
        searchView = SearchView(frame: CGRectMake(0, 0, view.width, 50))
        searchView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        view.addSubview(searchView)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        view.endEditing(true)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchView.searchTextField.becomeFirstResponder()
    }
}
