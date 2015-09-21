//
//  ShakeViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/21.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  摇一摇控制器

import UIKit
import AVFoundation

class ShakeViewController: UIViewController {
    var detailModel: DetailModel?
    private lazy var soundID: SystemSoundID? = {
        let url = NSBundle.mainBundle().URLForResource("glass.wav", withExtension: nil)
        let urlRef: CFURLRef = url!
        var id: SystemSoundID = 100
        AudioServicesCreateSystemSoundID(urlRef, &id)
        return id
        }()
    
    private lazy var foodView: UIView? = {
        let foodView = UIView(frame: CGRectMake(0, 0, AppWidth, 80))
        foodView.backgroundColor = UIColor.clearColor()
        let button = UIButton(frame: CGRectMake((AppWidth - 120) * 0.5, 20, 120, 40))
        button.setBackgroundImage(UIImage(named: "fsyzm"), forState: .Normal)
        button.setTitle("在摇一次", forState: .Normal)
        button.setTitleColor(UIColor.blackColor(), forState: .Normal)
        button.addTarget(self, action: "aginButtonClick", forControlEvents: .TouchUpInside)
        foodView.addSubview(button)
        return foodView
        }()
    
    @IBOutlet weak private var yaoImageView1: UIImageView!
    @IBOutlet weak private var yaoImageView2: UIImageView!
    @IBOutlet weak private var bottomLoadView: UIView!
    
    private lazy var tableView: UITableView? = {
        let tableView = UITableView(frame: MainBounds, style: .Plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.hidden = true
        tableView.rowHeight = DetailCellHeight
        tableView.contentInset = UIEdgeInsetsMake(0, 0, NavigationH, 0)
        tableView.separatorStyle = .None
        tableView.tableFooterView = self.foodView
        tableView.registerNib(UINib(nibName: "DetailCell", bundle: nil), forCellReuseIdentifier: "DetailCell")
        return tableView
        }()
    
    /// 重写构造方法,直接在xib里加载
    init() {
        super.init(nibName: "ShakeViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(nibName: "ShakeViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "摇一摇"
        view.addSubview(tableView!)
    }
    
    deinit {
        print("摇一摇控制器被销毁了", terminator: "")
    }
    
    ///MARK:- 摇一摇功能
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent?) {
        tableView!.hidden = true
        let animateDuration: NSTimeInterval = 0.3
        let offsetY: CGFloat = 50
        
        UIView.animateWithDuration(animateDuration, animations: { () -> Void in
            self.yaoImageView1.transform = CGAffineTransformMakeTranslation(0, -offsetY)
            self.yaoImageView2.transform = CGAffineTransformMakeTranslation(0, offsetY)
            
            }) { (finish) -> Void in
                let popTime = dispatch_time(DISPATCH_TIME_NOW,Int64(0.5 * Double(NSEC_PER_SEC)))
                dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                    
                    UIView.animateWithDuration(animateDuration, animations: { () -> Void in
                        self.yaoImageView1.transform = CGAffineTransformIdentity
                        self.yaoImageView2.transform = CGAffineTransformIdentity
                        }, completion: { (finish) -> Void in
                            
                            self.loadShakeData()
                            // 音效
                            AudioServicesPlayAlertSound(self.soundID!)
                    })
                })
        }
    }
    
    private func loadShakeData() {
        bottomLoadView.hidden = false
        let time = dispatch_time(DISPATCH_TIME_NOW, Int64(1.0 * Double(NSEC_PER_SEC)))
        dispatch_after(time, dispatch_get_main_queue()) { () -> Void in
            DetailModel.loadDetails({ (data, error) -> () in
                self.bottomLoadView.hidden = true
                self.tableView!.hidden = false
                self.detailModel = data
                self.tableView!.reloadData()
            })
        }
    }
    
    /// 再摇一次
    func aginButtonClick() {
        self.motionBegan(.MotionShake, withEvent: UIEvent())
    }
}

/// MARK: TableViewDelegate, TableViewDataSours
extension ShakeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return detailModel?.list?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("DetailCell") as! DetailCell
        let everyModel = detailModel!.list![indexPath.row]
        cell.model = everyModel
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let everyModel = detailModel!.list![indexPath.row]
        let vc = EventViewController()
        vc.model = everyModel
        navigationController!.pushViewController(vc, animated: true)
    }
    
}











