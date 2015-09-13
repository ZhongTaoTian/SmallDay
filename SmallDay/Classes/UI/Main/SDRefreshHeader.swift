//
//  SDRefreshHeader.swift
//  SmallDay
//
//  Created by MacBook on 15/9/12.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  DIY 自己的下拉刷新动画

import UIKit

class SDRefreshHeader: MJRefreshGifHeader {
    
    override func prepare() {
        super.prepare()
        stateLabel.hidden = true
        lastUpdatedTimeLabel.hidden = true
        
        var idleImages = NSMutableArray()
        let idImage = UIImage(named: "wnx00")
        idleImages.addObject(idImage!)
        setImages(idleImages as [AnyObject], forState: MJRefreshStateIdle)
        
        var refreshingImages = NSMutableArray()
        let refreshingImage = UIImage(named: "wnx00")!
        setImages(refreshingImages as [AnyObject], forState: MJRefreshStatePulling)

        var refreshingStartImages = NSMutableArray()
        for i in 0...92 {
            let image = UIImage(named: String(format: "wnx%02d", i))
            refreshingStartImages.addObject(image!)
        }
        setImages(refreshingStartImages as [AnyObject], forState: MJRefreshStateRefreshing)
     
    }
    
}
