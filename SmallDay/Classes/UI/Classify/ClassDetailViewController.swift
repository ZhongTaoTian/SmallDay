//
//  ClassDetailViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/25.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  分类详情控制器

import UIKit

public let DetailCellHeight: CGFloat = 220

class ClassDetailViewController: UIViewController {
    
    private lazy var detailTableView: UITableView? = {
        let tableView = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        tableView.backgroundColor = theme.SDBackgroundColor
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = DetailCellHeight
        tableView.separatorStyle = .None
        tableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0)
        tableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        return tableView
        }()
    
    var details: DetailModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = theme.SDBackgroundColor
        view.addSubview(detailTableView!)
        
        loadDatas()
    }
    
    private func loadDatas() {
        weak var tmpSelf = self
        DetailModel.loadDetails { (data, error) -> () in
            if error != nil {
                return
            }
            tmpSelf!.details = data
            tmpSelf!.detailTableView?.reloadData()
        }
    }
}


extension ClassDetailViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return details?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let event = details!.list![indexPath.row] as EventModel
        var cell = tableView.dequeueReusableCellWithIdentifier("DetailCell") as? DetailCell
        cell?.model = event
        
        return cell!
    }
    
}