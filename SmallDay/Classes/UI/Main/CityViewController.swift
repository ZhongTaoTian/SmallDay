//
//  CityViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class CityViewController: UIViewController {

    var collView: UICollectionView!
    var layout = UICollectionViewFlowLayout()
    
    lazy var domesticCitys: NSMutableArray? = {
        let arr = NSMutableArray(array: ["北京", "上海", "成都", "广州", "杭州", "西安", "重庆", "厦门", "台北"])
        return arr
        }()
    lazy var overseasCitys: NSMutableArray? = {
        let arr = NSMutableArray(array: ["罗马", "迪拜", "里斯本", "巴黎", "柏林", "伦敦"])
        return arr
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航条内容
        setNav()
        
        // 设置collectionView
        setCollectionView()
    }
    
    func setNav() {
        view.backgroundColor = UIColor.whiteColor()
        navigationItem.title = "选择城市"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", titleClocr: UIColor.blackColor(), targer: self, action: "cancle")
        
    }
    
    func setCollectionView() {
        // 设置布局
        let itemW = theme.appWidth / 3.0 - 1.0
        let itemH: CGFloat = 50
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.headerReferenceSize = CGSizeMake(view.width, 60)
        layout.footerReferenceSize = CGSizeMake(view.width, 100)
        
        // 设置collectionView
        collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.delegate = self
        collView.dataSource = self
        collView.backgroundColor = UIColor.colorWith(247, green: 247, blue: 247, alpha: 1)
        collView.registerClass(CityCollectionViewCell.self, forCellWithReuseIdentifier: "cellID")
        collView.registerClass(CityHeadCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collView.registerClass(CityFootCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footView")
        collView.alwaysBounceVertical = true
        
        view.addSubview(collView!)
    }
    
    func cancle() {
        navigationController?.dismissViewControllerAnimated(true, completion: nil)
    }
}



// MARK - UICollectionViewDelegate, UICollectionViewDataSource
extension CityViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return domesticCitys!.count
        } else {
            return overseasCitys!.count
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! CityCollectionViewCell
        if indexPath.section == 0 {
            cell.cityName = domesticCitys!.objectAtIndex(indexPath.row) as? String
        } else {
            cell.cityName = overseasCitys!.objectAtIndex(indexPath.row) as? String
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter && indexPath.section == 1 {
            var footView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footView", forIndexPath: indexPath) as! CityFootCollectionReusableView

            return footView
        }
        
        var headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath) as! CityHeadCollectionReusableView
        
        if indexPath.section == 0 {
            headView.headTitle = "国内城市"
        } else {
            headView.headTitle = "国外城市"
        }

        return headView
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 拿出当前选择的cell
        var cell = collectionView.cellForItemAtIndexPath(indexPath) as! CityCollectionViewCell
        let currentCity = cell.cityName
        
    }
    
    /// 这方法是UICollectionViewDelegateFlowLayout 协议里面的， 我现在是 默认的flow layout， 没有自定义layout，所以就没有实现UICollectionViewDelegateFlowLayout协议,需要完全手敲出来方法,对应的也有设置header的尺寸方法
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        } else {
            return CGSizeMake(view.width, 140)
        }
    }
    
}



