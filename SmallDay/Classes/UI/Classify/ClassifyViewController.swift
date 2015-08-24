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
    var classData: ClassifyModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 初始化导航条上的内容
        setNav()
        
        // 初始化collView
        setCollectionView()
        
        // 加载分类数据
        loadClassDatas()
    }
    
    func loadClassDatas() {
        weak var tmpSelf = self
        ClassifyModel.loadClassifyModel { (data, error) -> () in
            if error != nil {
                SVProgressHUD.showErrorWithStatus("网络不给力")
                return
            }
            tmpSelf!.classData = data!
            tmpSelf!.collView.reloadData()
        }
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
        let margin: CGFloat = 10
        layout.minimumInteritemSpacing = margin
//        layout.minimumLineSpacing = 5
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        let itemH:CGFloat = 80
        let itemW = (theme.appWidth - 4 * margin) / 3
        layout.itemSize = CGSizeMake(itemW, itemH)
        layout.headerReferenceSize = CGSizeMake(theme.appWidth, 50)
        
        collView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collView.backgroundColor = theme.SDBackgroundColor
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
        
        return self.classData?.list?[section].tags?.count ?? 0
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return self.classData?.list?.count ?? 0
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier("classifyCell", forIndexPath: indexPath) as! ClassifyCell
        cell.model = classData!.list![indexPath.section].tags![indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var headView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "headView", forIndexPath: indexPath) as! CityHeadCollectionReusableView
        
        headView.headTitle = self.classData?.list?[indexPath.section].title
        return headView
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let every: EveryClassModel = classData!.list![indexPath.section].tags![indexPath.row]
        let detailVC = ClassDetailViewController()
        detailVC.title = every.name
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
    
}
