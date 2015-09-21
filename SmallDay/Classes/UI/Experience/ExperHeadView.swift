//
//  ExperHeadView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/27.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验的顶部广告ScrollView

import UIKit

class ExperHeadView: UIView, UIScrollViewDelegate {
    
    var experModel: ExperienceModel? {
        didSet {
            if experModel?.head?.count > 0 {
                page.numberOfPages = experModel!.head!.count
                scrollImageView.contentSize = CGSizeMake(self.width * CGFloat(experModel!.head!.count), 0)
                
                for i in 0..<experModel!.head!.count {
                    let imageV = UIImageView(frame: CGRectMake(CGFloat(i) * AppWidth, 0, AppWidth, self.height * 0.8))
                    imageV.wxn_setImageWithURL(NSURL(string: experModel!.head![i].adurl!)!, placeholderImage: UIImage(named: "quesheng")!)
                    imageV.tag = i + 1000
                    
                    let tap = UITapGestureRecognizer(target: self, action: "imageClick:")
                    imageV.userInteractionEnabled = true
                    imageV.addGestureRecognizer(tap)
                    scrollImageView.addSubview(imageV)
                }
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = theme.SDBackgroundColor
        
        addSubview(scrollImageView)
        
        addSubview(page)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollImageView.frame = CGRectMake(0, 0, self.width, self.height * 0.8)
        page.frame = CGRectMake(0, self.height * 0.8, self.width, self.height * 0.2)
    }
    
    ///MARK:- 懒加载对象
    private lazy var scrollImageView: UIScrollView = {
        let scrollImageView = UIScrollView()
        scrollImageView.delegate = self
        scrollImageView.showsHorizontalScrollIndicator = false
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.pagingEnabled = true
        return scrollImageView
        }()
    
    private var page: UIPageControl = {
        let page = UIPageControl()
        page.pageIndicatorTintColor = UIColor.grayColor()
        page.currentPageIndicatorTintColor = UIColor.blackColor()
        page.hidesForSinglePage = true
        return page
        }()
    
    weak var delegate: ExperHeadViewDelegate?
    
    func imageClick(tap: UITapGestureRecognizer) {
        delegate?.experHeadView(self, didClickImageViewAtIndex: tap.view!.tag - 1000)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///MARK:- UIScrollViewDelegate
extension ExperHeadView {
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let flag = Int(scrollView.contentOffset.x / scrollView.width)
        page.currentPage = flag
    }
}

///MARK:- 协议
protocol ExperHeadViewDelegate: NSObjectProtocol {
    
    func experHeadView(headView: ExperHeadView, didClickImageViewAtIndex index: Int)
    
}





