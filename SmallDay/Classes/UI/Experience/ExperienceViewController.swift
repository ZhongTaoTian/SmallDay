//
//  ExperienceViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验

import UIKit

class ExperienceViewController: MainViewController {
    
    var experModel: ExperienceModel?
    private let cellIdentifier: String = "experienceCell"
    
    lazy var tableView: UITableView! = {
        let tableV = UITableView(frame: UIScreen.mainScreen().bounds, style: .Plain)
        tableV.separatorStyle = .None
        tableV.delegate = self
        tableV.backgroundColor = theme.SDBackgroundColor
        tableV.dataSource = self
        tableV.estimatedRowHeight = 200
        tableV.rowHeight = UITableViewAutomaticDimension
        tableV.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0)
        tableV.registerNib(UINib(nibName: "ExperienceCell", bundle: nil), forCellReuseIdentifier: self.cellIdentifier)
        return tableV
        }()
    lazy var headView: ExperHeadView? = {
        let viewH = ExperHeadView(frame: CGRectMake(0, 0, AppWidth, 170))
        viewH.delegate = self
        return viewH
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "体验"
        
        loadDatas()
        
        setTableView()
    }
    
    func setTableView() {
        
        headView?.experModel = experModel
        tableView.tableHeaderView = headView!
        view.addSubview(tableView)
    }
    
    func loadDatas() {
        weak var tmpSelf = self
        ExperienceModel.loadExperienceModel { (data, error) -> () in
            if error != nil {
                return
            }
            
            tmpSelf!.experModel = data
            tmpSelf!.tableView.reloadData()
        }
    }
    
}

extension ExperienceViewController: UITableViewDelegate, UITableViewDataSource, ExperHeadViewDelegate {
    
    func experHeadView(headView: ExperHeadView, didClickImageViewAtIndex index: Int) {
        let headModel = experModel!.head![index]
        let pushVC = ExperHeadPushViewController()
        pushVC.model = headModel
        navigationController!.pushViewController(pushVC, animated: true)
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return experModel?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier(self.cellIdentifier) as! ExperienceCell
        let eventModel = experModel!.list![indexPath.row]
        cell.eventModel = eventModel
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let detailVC = DetailViewController()
        navigationController!.pushViewController(detailVC, animated: true)
    }
    
}










