//
//  ClassifyViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  分类

import UIKit

class ClassifyViewController: MainViewController {

    var collView: UICollectionView!
    var headTitles: NSArray = ["闲时光·发现·惊喜", "涨知识·分享·丰盈"]
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // 初始化导航条上的内容
        setNav()
        
        // 初始化collView
        setCollectionView()
    }

    func setNav() {
        navigationItem.title = "分类"
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "search_1", highlImageName: "search_2", targer: self, action: "searchClick")
        self.automaticallyAdjustsScrollViewInsets = false
    }
    
    func searchClick() {
        let searchVC = SearchViewController()
        navigationController?.pushViewController(searchVC, animated: true)
    }

    func setCollectionView() {
        let layout = UICollectionViewFlowLayout()
        let margin: CGFloat = 5
        layout.minimumInteritemSpacing = margin
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        let itemH:CGFloat = 100
        let itemW = (theme.appWidth - 4 * margin) / 3
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.headerReferenceSize = CGSizeMake(theme.appWidth, 70)
        
        collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.backgroundColor = UIColor.whiteColor()
        collView.delegate = self
        collView.dataSource = self
        collView.alwaysBounceVertical = true
        collView.registerClass(CityHeadCollectionReusableView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "headView")
        collView.registerNib(UINib(nibName: "ClassifyCell", bundle: nil), forCellWithReuseIdentifier: "classifyCell")
        collView.showsHorizontalScrollIndicator = false
        collView.showsVerticalScrollIndicator = false
        collView.contentInset = UIEdgeInsetsMake(0, 0, 64 + 49, 0)
        view.addSubview(collView)
    }
}


// MARK - UICollectionViewDelegate UICollectionViewDataSource 代理方法
extension ClassifyViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 6
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {

        return headTitles.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("classifyCell", forIndexPath: indexPath) as! ClassifyCell
        
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath) as! CityHeadCollectionReusableView
        
        if indexPath.section == 0 {
            headView.headTitle = headTitles[0] as? String
        } else {
            headView.headTitle = headTitles[1] as? String
        }
        
        return headView
    }
    


}
