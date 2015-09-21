//
//  SearchViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/18.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  搜索控制器

import UIKit

public let searchViewH: CGFloat = 50

class SearchViewController: UIViewController, SearchViewDelegate {
    
    private var searchView: SearchView!
    
    var searchModel: SearchsModel?
    
    private var scrollView: UIScrollView!
    
    private var hotSearchs: [String] = ["北京", "东四", "南锣鼓巷", "798", "三里屯", "维尼的小熊"]
    
    private var tableView: UITableView = {
        let tableView = UITableView(frame: CGRectMake(0, searchViewH, AppWidth, AppHeight - searchViewH), style: .Plain)
        tableView.separatorStyle = .None
        tableView.rowHeight = 230
        tableView.hidden = true
        tableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0)
        tableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: SD_DetailCell_Identifier)
        return tableView
        }()
    
    private lazy var hotBtns: NSMutableArray = NSMutableArray()
    
    private lazy var hotLabel: UILabel = {
        let label = UILabel(frame: CGRectMake(10, 0, 200, 50))
        label.textAlignment = NSTextAlignment.Left
        label.textColor = UIColor.blackColor()
        label.font = UIFont.systemFontOfSize(16)
        label.text = "热门搜索"
        return label
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "搜索"
        view.backgroundColor = theme.SDBackgroundColor
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyBoardWillshow", name: UIKeyboardWillShowNotification, object: nil)
        // 添加顶部的searchView
        setSearchView()
        
        setScrollView()
        
        setTableView()
    }
    
    private func setScrollView() {
        scrollView = UIScrollView(frame: CGRectMake(0, searchViewH, AppWidth, AppHeight - searchViewH))
        scrollView.backgroundColor = theme.SDBackgroundColor
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .OnDrag
        let tap = UITapGestureRecognizer(target: self, action: "hideKeyboard")
        scrollView.addGestureRecognizer(tap)
        view.addSubview(scrollView)
        
        if hotSearchs.count > 0 {
            scrollView.addSubview(hotLabel)
            let margin: CGFloat = 10
            let btnH: CGFloat = 32
//            var btnX: CGFloat = 0
            var btnY: CGFloat = CGRectGetMaxY(hotLabel.frame)
            var btnW: CGFloat = 0
            let textMargin: CGFloat = 35
            for i in 0..<hotSearchs.count {
                let btn = UIButton()
                btn.setTitle(hotSearchs[i], forState: .Normal)
                btn.setTitleColor(UIColor.blackColor(), forState: .Normal)
                btn.titleLabel!.sizeToFit()
                btn.setBackgroundImage(UIImage(named: "populartags"), forState: .Normal)
                btnW = btn.titleLabel!.width + textMargin
                btn.addTarget(self, action: "searchBtnClick:", forControlEvents: .TouchUpInside)
                if hotBtns.count > 0 {
                    let lastBtn = hotBtns.lastObject as! UIButton
                    let freeW = AppWidth - CGRectGetMaxX(lastBtn.frame)
                    if freeW > btnW + 2 * margin {
                        btn.frame = CGRectMake(CGRectGetMaxX(lastBtn.frame) + margin, btnY, btnW, btnH)
                    } else {
                        btnY = CGRectGetMaxY(lastBtn.frame) + margin
                        btn.frame = CGRectMake(margin, btnY, btnW, btnH)
                    }
                    hotBtns.addObject(btn)
                    scrollView.addSubview(btn)
                } else {
                    btn.frame = CGRectMake(margin, btnY, btnW, btnH)
                    hotBtns.addObject(btn)
                    scrollView.addSubview(btn)
                }
            }
        }
    }
    
    func setTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        view.addSubview(tableView)
    }
    
    func setSearchView() {
        searchView = SearchView(frame: CGRectMake(0, 0, view.width, searchViewH))
        searchView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        searchView.delegate = self
        view.addSubview(searchView)
    }
    
    func searchBtnClick(sender: UIButton) {
        let text: String = sender.titleLabel!.text!
        searchDetail(text)
        
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        view.endEditing(true)
    }
    
    func searchDetail(title: String) {
        searchView.searchTextField.text = title
        searchModel = nil
        searchView.searchTextField.resignFirstResponder()
        
        weak var tmpSelf = self
        SearchsModel.loadSearchsModel(title, completion: { (data, error) -> () in
            if error != nil {//添加搜索失败view
                return
            }
            
            tmpSelf!.searchModel = data!
            tmpSelf!.tableView.hidden = false
            tmpSelf!.scrollView.hidden = true
            tmpSelf!.tableView.reloadData()
            tmpSelf!.searchView.searchBtn.selected = true
        })
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        searchView.searchTextField.becomeFirstResponder()
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("搜索控制器被销毁", terminator: "")
    }
    
    func keyBoardWillshow() {
        scrollView.hidden = false
        tableView.hidden = true
        self.searchModel = nil
        tableView.reloadData()
    }
    
    func searchView(searchView: SearchView, searchTitle: String) {
        searchDetail(searchTitle)
    }
    
    func hideKeyboard() {
        searchView.searchTextField.resignFirstResponder()
        searchView.resumeSearchTextField()
    }
}


extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchModel?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(SD_DetailCell_Identifier) as! DetailCell
        let everyModel = searchModel!.list![indexPath.row]
        cell.model = everyModel
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let eventModel = searchModel!.list![indexPath.row]
        let searchDetailVC = EventViewController()
        searchDetailVC.model = eventModel
        navigationController!.pushViewController(searchDetailVC, animated: true)
    }
}




