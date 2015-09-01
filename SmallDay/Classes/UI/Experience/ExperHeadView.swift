//
//  ExperHeadView.swift
//  SmallDay
//
//  Created by MacBook on 15/8/27.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验的headView

import UIKit

class ExperHeadView: UIView, UIScrollViewDelegate {
    
    var scrollImageView: UIScrollView!
    var page: UIPageControl!
    weak var delegate: ExperHeadViewDelegate?
    
    var experModel: ExperienceModel? {
        didSet {
            if experModel?.head?.count > 0 {
                page.numberOfPages = experModel!.head!.count
                scrollImageView.contentSize = CGSizeMake(self.width * CGFloat(experModel!.head!.count), 0)
                for i in 0..<experModel!.head!.count {
                    let imageV = UIImageView(frame: CGRectMake(CGFloat(i) * AppWidth, 0, AppWidth, self.height * 0.8))
                    imageV.kf_setImageWithURL(NSURL(string: experModel!.head![i].adurl!)!, placeholderImage: UIImage(named: "quesheng"))
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
        self.backgroundColor = theme.SDBackgroundColor

        scrollImageView = UIScrollView()
        scrollImageView.delegate = self
        scrollImageView.showsHorizontalScrollIndicator = false
        scrollImageView.showsVerticalScrollIndicator = false
        scrollImageView.pagingEnabled = true
        addSubview(scrollImageView)
        
        page = UIPageControl()
        page.pageIndicatorTintColor = UIColor.grayColor()
        page.currentPageIndicatorTintColor = UIColor.blackColor()
        page.hidesForSinglePage = true
        addSubview(page)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        scrollImageView.frame = CGRectMake(0, 0, self.width, self.height * 0.8)
        page.frame = CGRectMake(0, self.height * 0.8, self.width, self.height * 0.2)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let flag = Int(scrollView.contentOffset.x / scrollView.width)
        page.currentPage = flag
    }
    
    func imageClick(tap: UITapGestureRecognizer) {
        if delegate != nil {
            if delegate!.respondsToSelector("experHeadView:didClickImageViewAtIndex:") {
                delegate!.experHeadView!(self, didClickImageViewAtIndex: tap.view!.tag - 1000)
            }
        }
    }
}

@objc protocol ExperHeadViewDelegate: NSObjectProtocol {

    optional func experHeadView(headView: ExperHeadView, didClickImageViewAtIndex index: Int)
    
}





