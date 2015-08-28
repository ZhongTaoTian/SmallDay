//
//  MeViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  我的, 这种cell最好用sb来的静态单元格来描述

import UIKit

class MeViewController: MainViewController, UITableViewDelegate, UITableViewDataSource, IconViewDelegate {
    var loginLabel: UILabel!
    
    var tableView: UITableView!
    lazy var mineIcons: NSMutableArray! = {
        var arr = NSMutableArray(array: ["usercenter", "orders", "setting_like", "feedback", "recomment"])
        return arr
        }()
    lazy var mineTitles: NSMutableArray! = {
        var arr = NSMutableArray(array: ["个人中心", "我的订单", "我的收藏", "留言反馈", "应用推荐"])
        return arr
        }()
    var iconView: IconView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化导航条上的内容
        setNav()
        
        // 设置tableView
        setTableView()
    }
    
    func setNav() {
        navigationItem.title = "我的"
        navigationItem.leftBarButtonItem = nil
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "settinghhhh", highlImageName: "settingh", targer: self, action: "settingClick")
    }
    
    func setTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        tableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH - 49), style: UITableViewStyle.Grouped)
        tableView.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
        
        // 设置tableView的headerView
        let iconImageViewHeight: CGFloat = 160
        var iconImageView = UIImageView(frame: CGRectMake(0, 0, AppWidth, iconImageViewHeight))
        iconImageView.image = UIImage(named: "quesheng")
        iconImageView.userInteractionEnabled = true
        
        // 添加未登录的文字
        let loginLabelHeight: CGFloat = 40
        loginLabel = UILabel(frame: CGRectMake(0, iconImageViewHeight - loginLabelHeight, AppWidth, loginLabelHeight))
        loginLabel.textAlignment = .Center
        loginLabel.text = "登陆,开始我的小日子"
        loginLabel.font = UIFont.systemFontOfSize(16)
        loginLabel.textColor = UIColor.colorWith(80, green: 80, blue: 80, alpha: 1)
        iconImageView.addSubview(loginLabel)
        
        // 添加iconImageView
        iconView = IconView(frame: CGRectMake(0, 0, 100, 100))
        iconView!.delegate = self
        iconView!.center = CGPointMake(iconImageView.width * 0.5, (iconImageViewHeight - loginLabelHeight) * 0.5 + 8)
        iconImageView.addSubview(iconView!)

        tableView.tableHeaderView = iconImageView
    }
    
    func settingClick() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    // MARK:UITableViewDelegate, UITableViewDataSource 代理方法
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mineIcons.count
        } else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? UITableViewCell
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.section == 0 {
            cell!.imageView!.image = UIImage(named: mineIcons[indexPath.row] as! String)
            cell!.textLabel?.text = mineTitles[indexPath.row] as? String
        } else {
            cell!.imageView!.image = UIImage(named: "yaoyiyao")
            cell!.textLabel!.text = "摇一摇 每天都有小惊喜"
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 && indexPath.row == 3 {
            // 留言反馈
            let feedbackVC = FeedbackViewController()
            navigationController?.pushViewController(feedbackVC, animated: true)
        } else if indexPath.section == 1 {
            let shakeVC = ShakeViewController()
            navigationController?.pushViewController(shakeVC, animated: true)
        }
    }
    
    func iconView(iconView: IconView, didClick iconButton: UIButton) {
        // TODO 判断用户是否登录了
        let login = LoginViewController()
        navigationController?.pushViewController(login, animated: true)
    }
}
