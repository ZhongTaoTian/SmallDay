//
//  LoadAnimatImageView.swift
//  SmallDay
//
//  Created by MacBook on 15/9/7.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  加载时等待的ImageView动画

import UIKit

class LoadAnimatImageView: UIImageView {
    lazy var loadImageView: UIImageView! = {
        let loadImageView = UIImageView()
        loadImageView.animationImages = self.loadAnimImages!
        loadImageView.animationRepeatCount = 100
        loadImageView.animationDuration = 1.0
        return loadImageView
        }()
    
    lazy var loadAnimImages: [UIImage]? = {
        var images = [UIImage]()
        for i in 0...24 {
            let image = UIImage(named: String(format: "zanimabg%02d", i))
            images.append(image!)
        }
        
        return images
        }()
    
//    class func showLoadAnimat(superView: UIView, rect: CGRect) {
//        let animat = LoadAnimatImageView()
//    }

}
