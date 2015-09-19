//
//  NavigatorViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/9/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  地图导航控制器

import UIKit

class NavigatorViewController: UIViewController {
    
    var shopLocaltion: CLLocationCoordinate2D? {
        didSet {
            mapView.setCenterCoordinate(shopLocaltion!, animated: true)
        }
    }
    
    private lazy var mapView: MAMapView = {
        let mapView = MAMapView()
        
        MAMapServices.sharedServices().apiKey = theme.GaoDeAPPKey
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.logoCenter.x = AppWidth - mapView.logoSize.width + 20
        mapView.zoomLevel = 12
        return mapView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        title = "位置"
        view.addSubview(mapView)
    }
    
    deinit {
        mapView.showsUserLocation = false
        mapView.clearDisk()
    }
}

extension NavigatorViewController: MAMapViewDelegate {
    
}