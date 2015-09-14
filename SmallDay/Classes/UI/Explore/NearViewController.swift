//
//  NearViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  附近控制器

import UIKit

class NearViewController: UIViewController {
// MARK:- 懒加载对象
    private var nears: DetailModel?
    
    private lazy var backView:UIView = {
        let backView = UIView(frame: self.view.bounds)
        backView.backgroundColor = theme.SDBackgroundColor
        return backView
        }()
    
    private lazy var nearTableView: UITableView = {
        let tableV = UITableView(frame: self.view.bounds, style: .Plain)
        tableV.delegate = self
        tableV.dataSource = self
        tableV.separatorStyle = .None
        tableV.rowHeight = DetailCellHeight
        tableV.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: DetailCellIdentifier)
        let diyHeader = SDRefreshHeader(refreshingTarget: self, refreshingAction: "pullLoadDatas")
        diyHeader.gifView.frame = CGRectMake((AppWidth - SD_RefreshImage_Width) * 0.5, 10, SD_RefreshImage_Width, SD_RefreshImage_Height)
        tableV.header = diyHeader
        return tableV
        }()
    
    private lazy var mapView: WNXMapView = WNXMapView(frame: self.view.bounds)

    private lazy var rightItem: UIBarButtonItem = {
        let right = UIBarButtonItem(imageName: "map_2-1", highlImageName: "map_2", selectedImage: "list_1", targer: self, action: "leftItemClick:")
        return right
        }()
    
// MARK:- 方法
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(backView)
        
        title = "附近"
        view.backgroundColor = theme.SDBackgroundColor
        MAMapServices.sharedServices().apiKey = theme.GaoDeAPPKey
        backView.addSubview(nearTableView)
        
        // 加载附近是否有店铺, 这里就定位到了我的附近,在深圳,模拟一直有附近,数据是本地的,所以获取的是固定的
        nearTableView.header.beginRefreshing()
    }
    
    func pullLoadDatas() {
        weak var tmpSelf = self
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(0.8 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            DetailModel.loadNearDatas({ (data, error) -> () in
                if error != nil {
                    SVProgressHUD.showErrorWithStatus("网速不给力")
                    tmpSelf!.nearTableView.header.endRefreshing()
                    return
                }
                
                tmpSelf!.nears = data
                tmpSelf!.nearTableView.reloadData()
                tmpSelf!.nearTableView.header.endRefreshing()
                tmpSelf!.mapView.nearsModel = data
                tmpSelf!.addMapView()
            })
        }
    }
    
    private func addMapView() {
        backView.insertSubview(mapView, belowSubview: nearTableView)
    }
    

    
    func leftItemClick(sender: UIButton) {
        sender.selected = !sender.selected
        
        if sender.selected {
            UIView.transitionFromView(nearTableView, toView: mapView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromLeft, completion: nil)
        } else {
            UIView.transitionFromView(mapView, toView: nearTableView, duration: 1.0, options: UIViewAnimationOptions.TransitionFlipFromRight, completion: nil)
        }
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
        if nears?.list?.count > 0 {
            navigationItem.rightBarButtonItem = rightItem
        } else {
            navigationItem.rightBarButtonItem = nil
        }

        return nears?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(DetailCellIdentifier) as? DetailCell
        cell!.model = nears!.list![indexPath.row] as EventModel
        return cell!
    }
}
