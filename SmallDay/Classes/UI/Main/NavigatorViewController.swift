//
//  NavigatorViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  地图导航控制器

import UIKit

class NavigatorViewController: UIViewController {
    
    var model: EventModel? {
        didSet {
            if let shopLocaltion = model?.position?.stringToCLLocationCoordinate2D(",") {
                let point = MAPointAnnotation()
                point.coordinate = shopLocaltion
                self.mapView.addAnnotation(point)
                self.mapView.setCenterCoordinate(shopLocaltion, animated: true)
                self.mapView.setZoomLevel(15, animated: true)
            }
        }
    }
    
    var adressTitle: String?
    
    private lazy var mapView: MAMapView = {
        let mapView = MAMapView()
        mapView.frame = MainBounds
        mapView.delegate = self
        mapView.showsCompass = false
        mapView.showsScale = false
        mapView.showsUserLocation = true
        mapView.logoCenter.x = AppWidth - mapView.logoSize.width + 20
        mapView.setZoomLevel(14, animated: true)
        return mapView
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        title = "位置"
        view.addSubview(mapView)
        print("MapView被销毁了")
    }
    
    deinit {
        mapView.showsUserLocation = false
        mapView.clearDisk()
    }
}

extension NavigatorViewController: MAMapViewDelegate {
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation.self) {
            var annot = mapView.dequeueReusableAnnotationViewWithIdentifier("point") as? CustomAnnotationView
            if annot == nil {
                annot = CustomAnnotationView(annotation: annotation, reuseIdentifier: "point") as CustomAnnotationView
            }
            annot!.userInteractionEnabled = false
            annot!.setSelected(true, animated: true)
            annot!.canShowCallout = false
            annot!.image = UIImage(named: "zuobiao1")
            annot!.center = CGPoint(x: 0, y: -(annot!.image.size.height * 0.5))
            annot!.calloutView?.adressTitle = model?.address
            return annot!
        }
        
        return nil
    }
}