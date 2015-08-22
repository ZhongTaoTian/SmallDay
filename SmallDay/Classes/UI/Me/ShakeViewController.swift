//
//  ShakeViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/21.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class ShakeViewController: UIViewController {

    @IBOutlet weak var yaoImageView1: UIImageView!
    @IBOutlet weak var yaoImageView2: UIImageView!
    @IBOutlet weak var bottomLoadView: UIView!
    
    /// 重写构造方法,直接在xib里加载    
    init() {
        super.init(nibName: "ShakeViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "ShakeViewController", bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        navigationItem.title = "摇一摇"
    }
    
    deinit {
        print("摇一摇控制器被销毁了")
    }

    // 摇一摇功能
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        bottomLoadView.hidden = false
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
                    // TODO 加载摇一摇数据
                    self.loadShakeData()
                })
            })
        }
    }
    
    func loadShakeData() {
    
    }
}
