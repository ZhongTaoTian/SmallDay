//
//  MyCenterViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/9/9.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  个人中心控制器

import UIKit

class MyCenterViewController: UIViewController {

    @IBOutlet weak private var alterPwdView: UIView!
    @IBOutlet weak private var iconView: IconView!
    @IBOutlet weak var accountLabel: UILabel!
    
    init() {
        super.init(nibName: "MyCenterViewController", bundle: nil)
    }

    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "MyCenterViewController", bundle: nil)
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap = UITapGestureRecognizer(target: self, action: "alterPwdViewClick")
        alterPwdView.userInteractionEnabled = true
        alterPwdView.addGestureRecognizer(tap)
        
        accountLabel.text = UserAccountTool.userAccount()!
    }
    
    func alterPwdViewClick() {
        print("修改密码")
    }
    
    @IBAction func logoutBtnClick(sender: UIButton) {
        
    }

}
