//
//  SignUpViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/28.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  报名ViewController

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    init() {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "报名"
        
        // 从XIB中加载后的初始化
        setUpXIB()

    }

    private func setUpXIB() {
        scrollView.alwaysBounceVertical = true
        let nameTFLeftView: UIImageView = UIImageView()
    }

  

}
