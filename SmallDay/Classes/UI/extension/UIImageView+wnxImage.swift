//
//  UIImageView+wnxImage.swift
//  SmallDay
//
//  Created by MacBook on 15/9/8.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  对UIImageView的扩展

import Foundation

extension UIImageView {
    
    func wxn_setImageWithURL(url: NSURL, placeholderImage: UIImage) {
        self.kf_setImageWithURL(url, placeholderImage: placeholderImage)
    }
    
}