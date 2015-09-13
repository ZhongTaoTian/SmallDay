//
//  WNXMapView.swift
//  SmallDay
//
//  Created by MacBook on 15/9/13.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  自定义MapView

import UIKit

class WNXMapView: MAMapView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        showsCompass = false
        showsScale = false
        showsUserLocation = true
        logoCenter.x = AppWidth - logoSize.width + 20
        zoomLevel = 12
        setCenterCoordinate(CLLocationCoordinate2D(latitude: 23.1312628531958, longitude: 113.378072237339), animated: true)
        mapType = MAMapType.Standard
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
