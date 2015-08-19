//
//  SettingViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/19.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  设置控制器

import UIKit

class SettingViewController: UIViewController {
    lazy var images: NSMutableArray! = {
        var array = NSMutableArray(array: ["score", "recommendfriend", "about", "remove"])
        return array
        }()
    lazy var titles: NSMutableArray! = {
        var array = NSMutableArray(array: ["去APP Store评价", "推荐给朋友", "关于我们", "清理缓存"])
        return array
        }()
    
    var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置tableView
        setTableView()
    }
    
    func setTableView() {
        tableView = UITableView(frame: view.bounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        tableView.rowHeight = 50
        tableView.separatorStyle = .None
        tableView.registerNib(UINib(nibName: "SettingCell", bundle: nil), forCellReuseIdentifier: "settingCell")
        view.addSubview(tableView)
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = SettingCell.settingCellWithTableView(tableView)
        cell.imageImageView.image = UIImage(named: images[indexPath.row] as! String)
        cell.titleLabel.text = titles[indexPath.row] as? String 
        
        if indexPath.row == 3 {
            cell.bottomView.hidden = true
            cell.sizeLabel.hidden = false
        } else {
            cell.bottomView.hidden = false
            cell.sizeLabel.hidden = true
        }
        
        return cell
    }
}