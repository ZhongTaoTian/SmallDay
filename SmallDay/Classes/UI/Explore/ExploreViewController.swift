//
//  ExploreViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探索

import UIKit

class ExploreViewController: MainViewController, DoubleTextViewDelegate {
    
    var backgroundScrollView: UIScrollView!
    var doubleTextView: DoubleTextView!
    var everyDays: EveryDays?
    var albumTableView: UITableView!
    var dayTableView: UITableView?
    var themes: ThemeModels?

    override func viewDidLoad() {
        super.viewDidLoad()

        // 初始化导航条内容
        setNav()
        
        // 设置scrollView
        setScrollView()
        
        // 初始化美天tablieView
        setdayTableView()
        
        // 初始化美辑tableView
        setalbumTableView()
        
        // 加载数据
        loadData()

    }
    
    func setdayTableView() {
        dayTableView = UITableView(frame: view.bounds, style: .Plain)
    }
    
    func setalbumTableView() {
        albumTableView = UITableView(frame: CGRectMake(theme.appWidth, 0, theme.appWidth, backgroundScrollView.height), style: .Plain)
        albumTableView.separatorStyle = .None
        albumTableView.delegate = self
        albumTableView.dataSource = self
        albumTableView.backgroundColor = UIColor.whiteColor()
        albumTableView.rowHeight = 230
        backgroundScrollView.addSubview(albumTableView)
    }

    func loadData() {
        ThemeModels.loadThemesData { (data, error) -> () in
            self.themes = data!
            print(self.themes!.list!.count)
            self.albumTableView.reloadData()
        }
    }
    
    func setScrollView() {
        backgroundScrollView = UIScrollView(frame: CGRectMake(0, 0, theme.appWidth, theme.appHeight - 64 - 49))
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView.backgroundColor = UIColor.redColor()
        backgroundScrollView.contentSize = CGSizeMake(theme.appWidth * 2.0, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        view.addSubview(backgroundScrollView)
    }
    
    func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleClocr: UIColor.blackColor(), targer: self, action: "nearClick")
        
        doubleTextView = DoubleTextView(leftText: "美天", rigthText: "美辑");
        doubleTextView.frame = CGRectMake(0, 0, 140, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
    }
    
    /// 附近action
    func nearClick() {
        let nearVC = NearViewController()
        navigationController?.pushViewController(nearVC, animated: true)
    }
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        backgroundScrollView.setContentOffset(CGPointMake(theme.appWidth * CGFloat(index), 0), animated: true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        KingfisherManager.sharedManager.cache.clearMemoryCache()
        KingfisherManager.sharedManager.cache.clearDiskCache()
        KingfisherManager.sharedManager.cache.cleanExpiredDiskCache()
    }
    
}

/// 扩展代理方法
extension ExploreViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / theme.appWidth)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}

extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return themes?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView === albumTableView {
            let theme = self.themes!.list![indexPath.row]
            cell = ThemeCell.themeCellWithTableView(tableView)
            (cell as! ThemeCell).model = theme
        }   else {
            
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView === albumTableView {
            let theme = self.themes!.list![indexPath.row]
            let themeVC = ThemeViewController()
            themeVC.themeModel = theme
            navigationController?.pushViewController(themeVC, animated: true)
        }
    }

}

