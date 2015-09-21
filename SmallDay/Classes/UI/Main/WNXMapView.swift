//
//  WNXMapView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/13.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  附近控制器地图View

import UIKit

private let customIdentifier = "pointReuseIndentifier"

class WNXMapView: MAMapView {
    var flags: [MAPointAnnotation] = [MAPointAnnotation]()
    var lastMAAnnotationView: MAAnnotationView?
    weak var pushVC: NearViewController?
    
    var nearsModel: DetailModel? {
        didSet {
            flags.removeAll(keepCapacity: true)
            nearCollectionView.reloadData()
            for i in 0..<nearsModel!.list!.count {
                let eventModel = nearsModel!.list![i]
                if let position = eventModel.position?.stringToCLLocationCoordinate2D(",") {
                    let po = MAPointAnnotation()
                    po.coordinate = position
                    flags.append(po)
                    addAnnotation(po)
                    
                    if i == 0 {
                        selectAnnotation(po, animated: true)
                    }
                }
            }
        }
    }
    
    private lazy var nearCollectionView: UICollectionView = {
        let nearH: CGFloat = 105
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 20
        let itemW = AppWidth - 35 - 10
        
        layout.scrollDirection = .Horizontal
        layout.itemSize = CGSizeMake(itemW, nearH)
        
        let nearCV = UICollectionView(frame: CGRectMake(15, AppHeight - nearH - 10 - NavigationH, AppWidth - 35, nearH), collectionViewLayout: layout)
        nearCV.delegate = self
        nearCV.dataSource = self
        nearCV.clipsToBounds = false
        nearCV.registerNib(UINib(nibName: "nearCell", bundle: nil), forCellWithReuseIdentifier: "nearCell")
        nearCV.pagingEnabled = true
        nearCV.showsVerticalScrollIndicator = false
        nearCV.backgroundColor = UIColor.clearColor()
        return nearCV
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        delegate = self
        showsCompass = false
        showsScale = false
        showsUserLocation = true
        logoCenter.x = AppWidth - logoSize.width + 20
        zoomLevel = 12
        setCenterCoordinate(CLLocationCoordinate2D(latitude: 22.5633480000, longitude: 114.0795910000), animated: true)
        mapType = MAMapType.Standard
        addSubview(myLocalBtn)
        addSubview(nearCollectionView)
    }
    
    private lazy var myLocalBtn: UIButton = {
        let btnWH: CGFloat = 57
        let btn = UIButton(frame: CGRectMake(20, AppHeight - 180 - btnWH, btnWH, btnWH)) as UIButton
        btn.setBackgroundImage(UIImage(named: "dingwei_1"), forState: .Normal)
        btn.setBackgroundImage(UIImage(named: "dingwei_2"), forState: .Highlighted)
        btn.addTarget(self, action: "backCurrentLocal", forControlEvents: .TouchUpInside)
        return btn
        }()
    
    func backCurrentLocal() {
        setCenterCoordinate(userLocation.coordinate, animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    deinit {
        
        clearDisk()
        print("地图view被销毁", terminator: "")
        showsUserLocation = false
    }
}

extension WNXMapView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nearsModel?.list?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("nearCell", forIndexPath: indexPath) as! nearCell
        let model = nearsModel!.list![indexPath.row]
        cell.nearModel = model
        cell.titleLabel.text = "\(indexPath.row + 1)." + cell.titleLabel.text!
        return cell
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let currentIndext = Int(nearCollectionView.contentOffset.x / nearCollectionView.width + 0.5)
        let po = flags[currentIndext]
        selectAnnotation(po, animated: true)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let eventVC = EventViewController()
        eventVC.model = nearsModel!.list![indexPath.item]
        pushVC?.navigationController?.pushViewController(eventVC, animated: true)
    }
}

extension WNXMapView: MAMapViewDelegate {
    
    func mapView(mapView: MAMapView!, viewForAnnotation annotation: MAAnnotation!) -> MAAnnotationView! {
        if annotation.isKindOfClass(MAPointAnnotation.self) {
            var annot = mapView.dequeueReusableAnnotationViewWithIdentifier(customIdentifier) as? MAPinAnnotationView
            if annot == nil {
                annot = MAPinAnnotationView(annotation: annotation, reuseIdentifier: customIdentifier) as MAPinAnnotationView
            }
            
            annot!.image = UIImage(named: "zuobiao1")
            annot!.center = CGPoint(x: 0, y: -(annot!.image.size.height * 0.5))
            return annot!
        }
        
        return nil
    }
    
    func mapView(mapView: MAMapView!, didSelectAnnotationView view: MAAnnotationView!) {
        lastMAAnnotationView?.image = UIImage(named: "zuobiao1")
        view.image = UIImage(named: "zuobiao2")
        lastMAAnnotationView = view
        setCenterCoordinate(view.annotation.coordinate, animated: true)
        
        let currentIndex = CGFloat(annotationViewForIndex(view))
        nearCollectionView.setContentOffset(CGPoint(x: currentIndex * nearCollectionView.width, y: 0), animated: true)
    }
    
    private func annotationViewForIndex(annot: MAAnnotationView) -> Int {
        
        for i in 0..<flags.count {
            let po = flags[i]
            if viewForAnnotation(po) === annot {
                return i
            }
        }
        
        return 0
    }
    
}


