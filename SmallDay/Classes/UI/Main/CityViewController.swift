//
//  CityViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/16.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

public let SD_Current_SelectedCity = "SD_Current_SelectedCity"
public let SD_CurrentCityChange_Notification = "SD_CurrentCityChange_Notification"

class CityViewController: UIViewController {
    var cityName: String?
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
        
        setNav()
        
        setCollectionView()
        
        let lastSelectedCityIndexPaht = selectedCurrentCity()
        collView.selectItemAtIndexPath(lastSelectedCityIndexPaht, animated: true, scrollPosition: UICollectionViewScrollPosition.None)
    }
    
    private func selectedCurrentCity() -> NSIndexPath {
        if let currentCityName = self.cityName {
            for var i = 0; i < domesticCitys!.count; i++ {
                if currentCityName == domesticCitys![i] as! String {
                    return NSIndexPath(forItem: i, inSection: 0)
                }
            }
            
            for var i = 0; i < overseasCitys!.count; i++ {
                if currentCityName == overseasCitys![i] as! String {
                    return NSIndexPath(forItem: i, inSection: 1)
                }
            }
        }
        
        return NSIndexPath(forItem: 0, inSection: 0)
    }
    
    func setNav() {
        view.backgroundColor = theme.SDBackgroundColor
        navigationItem.title = "选择城市"
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", titleClocr: UIColor.blackColor(), targer: self, action: "cancle")
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "取消", style: .Done, target: self, action: "cancle")
    }
    
    func setCollectionView() {
        // 设置布局
        let itemW = AppWidth / 3.0 - 1.0
        let itemH: CGFloat = 50
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.minimumLineSpacing = 1
        layout.minimumInteritemSpacing = 1
        layout.headerReferenceSize = CGSizeMake(view.width, 60)
        
        // 设置collectionView
        collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.delegate = self
        collView.dataSource = self
        collView.selectItemAtIndexPath(NSIndexPath(forItem: 1, inSection: 0), animated: true, scrollPosition: UICollectionViewScrollPosition.None)
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
        let cell = collView.dequeueReusableCellWithReuseIdentifier("cellID", forIndexPath: indexPath) as! CityCollectionViewCell
        if indexPath.section == 0 {
            cell.cityName = domesticCitys!.objectAtIndex(indexPath.row) as? String
        } else {
            cell.cityName = overseasCitys!.objectAtIndex(indexPath.row) as? String
        }
        return cell
    }

    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        if kind == UICollectionElementKindSectionFooter && indexPath.section == 1 {
            let footView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionFooter, withReuseIdentifier: "footView", forIndexPath: indexPath) as! CityFootCollectionReusableView
            footView.frame.size.height = 80
            return footView
        }
        
        let headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath) as! CityHeadCollectionReusableView
        
        if indexPath.section == 0 {
            headView.headTitle = "国内城市"
        } else {
            headView.headTitle = "国外城市"
        }

        return headView
    }

    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        // 拿出当前选择的cell
        let cell = collectionView.cellForItemAtIndexPath(indexPath) as! CityCollectionViewCell
        let currentCity = cell.cityName
        let user = NSUserDefaults.standardUserDefaults()
        user.setObject(currentCity, forKey: SD_Current_SelectedCity)
        if user.synchronize() {
            NSNotificationCenter.defaultCenter().postNotificationName(SD_CurrentCityChange_Notification, object: currentCity)
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    /// 这方法是UICollectionViewDelegateFlowLayout 协议里面的， 我现在是 默认的flow layout， 没有自定义layout，所以就没有实现UICollectionViewDelegateFlowLayout协议,需要完全手敲出来方法,对应的也有设置header的尺寸方法
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if section == 0 {
            return CGSizeZero
        } else {
            return CGSizeMake(view.width, 120)
        }
    }
    
}



