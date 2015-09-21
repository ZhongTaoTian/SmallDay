//
//  ExploreViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探索

import UIKit

public let SD_RefreshImage_Height: CGFloat = 40
public let SD_RefreshImage_Width: CGFloat = 35

class ExploreViewController: MainViewController, DoubleTextViewDelegate {
    
    private var backgroundScrollView: UIScrollView!
    private var doubleTextView: DoubleTextView!
    private var everyDays: EveryDays?
    private var albumTableView: MainTableView!
    private var dayTableView: MainTableView!
    private var themes: ThemeModels?
    private var events: EveryDays?
    
    
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
        
        // 下拉加载数据
        dayTableView.header.beginRefreshing()
        albumTableView.header.beginRefreshing()
    }
    
    
    private func setScrollView() {
        self.automaticallyAdjustsScrollViewInsets = false
        backgroundScrollView = UIScrollView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH - 49))
        backgroundScrollView.backgroundColor = theme.SDBackgroundColor
        backgroundScrollView.contentSize = CGSizeMake(AppWidth * 2.0, 0)
        backgroundScrollView.showsHorizontalScrollIndicator = false
        backgroundScrollView.showsVerticalScrollIndicator = false
        backgroundScrollView.pagingEnabled = true
        backgroundScrollView.delegate = self
        view.addSubview(backgroundScrollView)
    }
    
    private func setNav() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "附近", titleClocr: UIColor.blackColor(), targer: self, action: "nearClick")
        
        doubleTextView = DoubleTextView(leftText: "美天", rigthText: "美辑");
        doubleTextView.frame = CGRectMake(0, 0, 120, 44)
        doubleTextView.delegate = self
        navigationItem.titleView = doubleTextView
    }
    
    private func setdayTableView() {
        dayTableView = MainTableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH), style: .Grouped, dataSource: self, delegate: self)
        dayTableView.sectionHeaderHeight = 0.1
        dayTableView.sectionFooterHeight = 0.1
        dayTableView.contentInset = UIEdgeInsetsMake(-35, 0, 35, 0)
        backgroundScrollView.addSubview(dayTableView)
        
        setTableViewHeader(self, refreshingAction: "pullLoadDayData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 47, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: dayTableView)
    }
    
    
    private func setalbumTableView() {
        albumTableView = MainTableView(frame: CGRectMake(AppWidth, 0, AppWidth, backgroundScrollView.height), style: .Plain, dataSource: self, delegate: self)
        backgroundScrollView.addSubview(albumTableView)
        
        setTableViewHeader(self, refreshingAction: "pullLoadAlbumData", imageFrame: CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height), tableView: albumTableView)
    }
    
    private func setTableViewHeader(refreshingTarget: AnyObject, refreshingAction: Selector, imageFrame: CGRect, tableView: UITableView) {
        let header = SDRefreshHeader(refreshingTarget: refreshingTarget, refreshingAction: refreshingAction)
        header.gifView!.frame = imageFrame
        tableView.header = header
    }
    
    ///MARK:- 下拉加载刷新数据
    func pullLoadDayData() {
        weak var tmpSelf = self
        // 模拟延时加载
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(0.6 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            EveryDays.loadEventsData { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("数据加载失败")
                    tmpSelf!.dayTableView.header.endRefreshing()
                    return
                }
                tmpSelf!.everyDays = data!
                tmpSelf!.dayTableView.reloadData()
                tmpSelf!.dayTableView.header.endRefreshing()
            }
        }
    }
    
    func pullLoadAlbumData() {
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW,Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            ThemeModels.loadThemesData { (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("网络不给力")
                    tmpSelf!.albumTableView.header.endRefreshing()
                    return
                }
                tmpSelf!.themes = data!
                tmpSelf!.albumTableView.reloadData()
                tmpSelf!.albumTableView.header.endRefreshing()
            }
            
        }
    }
    
    
    /// 附近action
    func nearClick() {
        let nearVC = NearViewController()
        navigationController?.pushViewController(nearVC, animated: true)
    }
    
    // MARK: - DoubleTextViewDelegate
    func doubleTextView(doubleTextView: DoubleTextView, didClickBtn btn: UIButton, forIndex index: Int) {
        backgroundScrollView.setContentOffset(CGPointMake(AppWidth * CGFloat(index), 0), animated: true)
    }
}

/// MARK: UIScrollViewDelegate
extension ExploreViewController: UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate 监听scrollView的滚动事件
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        if scrollView === backgroundScrollView {
            let index = Int(scrollView.contentOffset.x / AppWidth)
            doubleTextView.clickBtnToIndex(index)
        }
    }
}

///MARK:- UITableViewDelegate和UITableViewDataSource
extension ExploreViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView === albumTableView {
            return themes?.list?.count ?? 0
        } else {
            let event = self.everyDays!.list![section]
            if let _ = event.themes?.last {
                return 2
            }
            
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if tableView === albumTableView {
            return 240
        } else {
            if indexPath.row == 1 {
                return 220
            } else {
                return 253
            }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView === albumTableView {
            return 1
        } else {
            return self.everyDays?.list?.count ?? 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell?
        
        if tableView === albumTableView { // 美辑TableView
            
            let theme = self.themes!.list![indexPath.row]
            cell = ThemeCell.themeCellWithTableView(tableView)
            (cell as! ThemeCell).model = theme
            
        }   else { // 美天TableView
            let event = self.everyDays!.list![indexPath.section]
            
            if indexPath.row == 1 {
                cell = ThemeCell.themeCellWithTableView(tableView)
                (cell as! ThemeCell).model = event.themes?.last
            } else {
                cell = EventCellTableViewCell.eventCell(tableView)
                (cell as! EventCellTableViewCell).eventModel = event
            }
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        // 点击的themeCell,美辑cell
        if tableView === albumTableView {
            let theme = self.themes!.list![indexPath.row]
            let themeVC = ThemeViewController()
            themeVC.themeModel = theme
            navigationController?.pushViewController(themeVC, animated: true)
            
        } else { // 点击的美天TableView里的美辑cell
            
            let event = self.everyDays!.list![indexPath.section]
            if indexPath.row == 1 {
                let themeVC = ThemeViewController()
                themeVC.themeModel = event.themes?.last
                navigationController!.pushViewController(themeVC, animated: true)
                
            } else { // 点击的美天的cell
                let eventVC = EventViewController()
                let event = self.everyDays!.list![indexPath.section]
                eventVC.model = event.events![indexPath.row]
                navigationController!.pushViewController(eventVC, animated: true)
            }
        }
    }
}

