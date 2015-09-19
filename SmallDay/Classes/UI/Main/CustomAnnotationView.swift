//
//  CustomAnnotationView.swift
//  SmallDay
//
//  Created by MacBook on 15/9/19.
//  Copyright © 2015年 维尼的小熊. All rights reserved.
//  自定义大头针

import UIKit

class CustomAnnotationView: MAAnnotationView {

    var calloutView: CustomCalloutView?
    
    override func setSelected(selected: Bool, animated: Bool) {
        calloutView = CustomCalloutView(frame: CGRect(x: 0, y: 0, width: AppWidth - 50, height: 60))
        calloutView!.center = CGPointMake(CGRectGetWidth(self.bounds) * 0.5 + calloutOffset.x,
            -CGRectGetHeight(calloutView!.bounds) * 0.5 + calloutOffset.y)
        addSubview(calloutView!)
    }
}
