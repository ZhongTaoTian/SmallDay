//
//  LoadAnimatImageView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/7.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  加载时等待的ImageView动画

import UIKit

class LoadAnimatImageView: NSObject {
    
    private static let sharedInstance = LoadAnimatImageView()
    class var sharedManager : LoadAnimatImageView {
        return sharedInstance
    }
    
    private lazy var loadImageView: UIImageView! = {
        let loadImageView = UIImageView()
        loadImageView.animationImages = self.loadAnimImages!
        loadImageView.animationRepeatCount = 10000
        loadImageView.animationDuration = 1.0
         loadImageView.frame = CGRectMake(0, 0, 44, 51)
        return loadImageView
        }()
    
    private lazy var loadAnimImages: [UIImage]? = {
        var images = [UIImage]()
        for i in 0...92 {
            let image = UIImage(named: String(format: "wnx%02d", i))
            images.append(image!)
        }
        
        return images
        }()
    
    func startLoadAnimatImageViewInView(view: UIView, center: CGPoint)  {

        loadImageView.center = center
        view.addSubview(loadImageView)
        loadImageView.startAnimating()
    }
    
    func stopLoadAnimatImageView() {
        loadImageView.removeFromSuperview()
        loadImageView.stopAnimating()
    }
    
}
