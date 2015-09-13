//
//  NearViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  附近控制器

import UIKit

class NearViewController: UIViewController {
    
    private lazy var nearTableView: UITableView = {
        let tableV = UITableView(frame: self.view.bounds, style: .Plain)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.separatorStyle = .None
        let diyHeader = SDRefreshHeader(refreshingTarget: self, refreshingAction: "pullLoadDatas")
        diyHeader.gifView.frame = CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height)
        tableV.header = diyHeader
        return tableV
        }()
    
    private lazy var mapView: WNXMapView = WNXMapView(frame: self.view.bounds)
    private lazy var myLocalBtn: UIButton = {
        let btnWH: CGFloat = 57
        let btn = UIButton(frame: CGRectMake(20, AppHeight - 180 - btnWH, btnWH, btnWH)) as UIButton
        btn.setBackgroundImage(UIImage(named: "dingwei_1"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "dingwei_2"), forState: .Highlighted)
        btn.addTarget(self, action: "backCurrentLocal", forControlEvents: .TouchUpInside)
        return btn
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = theme.SDBackgroundColor
        MAMapServices.sharedServices().apiKey = theme.GaoDeAPPKey
        view.addSubview(nearTableView)
        
        // 加载附近是否有店铺, 这里就定位到了我的附近,在深圳,模拟一直有附近,数据是本地的,所以获取的是固定的
        nearTableView.header.beginRefreshing()
        
        // 添加地图
//        addMapView()
    }
    
    func pullLoadDatas() {
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.5 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            
        }
    }
    
    private func addMapView() {
        mapView.delegate = self
        view.addSubview(mapView)
        
        view.addSubview(myLocalBtn)
    }
    
    func backCurrentLocal() {
        mapView.setCenterCoordinate(mapView.userLocation.coordinate, animated: true)
    }
    
    deinit {
        mapView.clearDisk()
    }
}


//MARK:- MAMapViewDelegate
extension NearViewController: MAMapViewDelegate {
    
}

//MARK:- TableView代理方法
extension NearViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Default, reuseIdentifier: "aaa")
        cell.contentView.backgroundColor = UIColor.greenColor()
        return cell
    }
}
