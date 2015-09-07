//
//  EventViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/24.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  Event点击出来的ViewController ,这个控制器和另一个控制器高度重合,应该抽取一个基类的,这里我开始没注意,另一个都写完了,懒得抽取了...

import UIKit

class EventViewController: UIViewController {
    private var showBlackImage: Bool = false
    private let shopViewHeight: CGFloat = 45
    private let scrollShowNavH: CGFloat = DetailViewController_TopImageView_Height - NavigationH
    private var imageWHArray = [(CGFloat, CGFloat)]()
    private let imageW: CGFloat = UIScreen.mainScreen().bounds.size.width - 23.0
    private lazy var customNav: UIView! = {
        let customNav = UIView(frame: CGRectMake(0, 0, AppWidth, NavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
        }()
    
    lazy var shareView: ShareView! = {
        let shareView = ShareView.shareViewFromXib()
        return shareView
        }()
    
    lazy var backBtn: UIButton! = {
        let btn = UIButton() as UIButton
        return btn
        }()
    
    lazy var likeBtn: UIButton! = {
        let btn = UIButton() as UIButton
        return btn
        }()
    
    lazy var sharedBtn: UIButton! = {
        let btn = UIButton() as UIButton
        return btn
        }()
    
    private lazy var topImageView: UIImageView! = {
        let image = UIImageView(frame: CGRectMake(0, 0, AppWidth, DetailViewController_TopImageView_Height))
        image.image = UIImage(named: "quesheng")
        image.contentMode = .ScaleAspectFill
        return image
        }()
    
    private lazy var webView: UIWebView! = {
        let webView = UIWebView(frame: UIScreen.mainScreen().bounds)
        let topImageShopViewHeight: CGFloat = DetailViewController_TopImageView_Height - 20 + self.shopViewHeight
        webView.scrollView.contentInset = UIEdgeInsets(top: topImageShopViewHeight, left: 0, bottom: 0, right: 0)
        webView.scrollView.setContentOffset(CGPoint(x: 0, y: -topImageShopViewHeight), animated: false)
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.delegate = self
        webView.delegate = self
        webView.backgroundColor = theme.SDWebViewBacagroundColor
        webView.paginationBreakingMode = UIWebPaginationBreakingMode.Column

        return webView
        }()
    
    private lazy var detailSV: UIScrollView! = {
        
        let detailSV = UIScrollView(frame: UIScreen.mainScreen().bounds)
        return detailSV
        }()
    
    private lazy var shopView: ShopDetailView! = {
        let shopView = ShopDetailView(frame: CGRect(x: 0, y: DetailViewController_TopImageView_Height, width: AppWidth, height: self.shopViewHeight))
        shopView.delegate = self
        return shopView
        }()
    
    deinit {
        print("More详情ViewController已经销毁")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        setCustomNavigationItem()
    }
    
    private func setUpUI() {
        view.backgroundColor = theme.SDBackgroundColor
        view.addSubview(webView)
        view.addSubview(topImageView)
        view.addSubview(shopView)
    }
    
    private func setCustomNavigationItem() {
        view.addSubview(customNav)
        //添加返回按钮
        setButton(backBtn, CGRectMake(0, 20, 44, 44), "back_0", "back_2", "backButtonClick")
        view.addSubview(backBtn)
        // 添加收藏按钮
        setButton(likeBtn, CGRectMake(AppWidth - 105, 20, 44, 44), "collect_0", "collect_0", "lickBtnClick")
        likeBtn.setImage(UIImage(named: "collect_2"), forState: .Selected)
        view.addSubview(likeBtn)
        // 添加分享按钮
        setButton(sharedBtn, CGRectMake(AppWidth - 54, 20, 44, 44), "share_0", "share_2", "sharedBtnClick")
        view.addSubview(sharedBtn)
    }
    
    private func setButton(btn: UIButton, _ frame: CGRect, _ imageName: String, _ highlightedImageName: String, _ action: Selector) {
        btn.frame = frame
        btn.setImage(UIImage(named: imageName), forState: .Normal)
        btn.setImage(UIImage(named: highlightedImageName), forState: .Highlighted)
        btn.addTarget(self, action: action, forControlEvents: .TouchUpInside)
    }
    
    var model: EventModel? {
        didSet {
            self.webView.hidden = true
            if let imageStr = model?.imgs?.last {
                self.topImageView.kf_setImageWithURL(NSURL(string: imageStr)!, placeholderImage: UIImage(named: "quesheng"))
            }
            self.shareView.shareModel = ShareModel(shareTitle: model?.title, shareURL: model?.shareURL, image: nil, shareDetail: model?.detail)
            var htmlSrt = model?.mobileURL
            
            if htmlSrt != nil {
                var titleStr: String?
                
                if model?.title != nil {
                    titleStr = String(format: "<p style='font-size:20px;'> %@</p>", model!.title!)
                }
                
                if model?.tag != nil {
                    titleStr = titleStr?.stringByAppendingFormat("<p style='font-size:13px; color: gray';>%@</p>", model!.tag!)
                }
                
                if titleStr != nil {
                    var newStr: NSMutableString = NSMutableString(string: htmlSrt!)
                    newStr.insertString(titleStr!, atIndex: 31)
                    htmlSrt = newStr as String
                }
                
                var arr = htmlSrt!.componentsSeparatedByString("<img alt=")
                for i in 1..<arr.count {
                    let str = arr[i] as NSString
                    let rangH = str.rangeOfString("height=\"")
                    let rangW = str.rangeOfString("width=\"")
                    let widthStr = str.substringWithRange(NSRange(location: rangW.location + rangW.length, length: 10)) as NSString
                    let heightStr = str.substringWithRange(NSRange(location: rangH.location + rangH.length, length: 10)) as NSString
                    var widthW =  CGFloat(self.numStrWith(widthStr).intValue)
                    var heightH = CGFloat(self.numStrWith(heightStr).intValue)
                    let newH = self.imageW / widthW * heightH
                    let WH = (self.imageW, newH)
                    self.imageWHArray.append(WH)
                }
            }
            
            //TODO: 将新的宽高重新替换掉原始的宽高
            
            self.webView.loadHTMLString(htmlSrt!, baseURL: nil)
            self.webView.hidden = false
        }
    }
    
}

/// MARK: 所有按钮的事件
extension EventViewController {
    /// 返回
    func backButtonClick() {
        navigationController!.popViewControllerAnimated(true)
    }
    
    /// 收藏
    func lickBtnClick() {

    }
    
    /// 分享
    func sharedBtnClick() {
        view.addSubview(shareView)
        shareView.shareVC = self
        shareView.showShareView(CGRectMake(0, AppHeight - 215, AppWidth, 215))
    }
}

/// MARK: 处理导航条显示消失
extension EventViewController {
    override func viewWillAppear(animated: Bool) {
        
        navigationController!.setNavigationBarHidden(true, animated: true)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController!.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
}

/// MARK: 处理内容滚动时的事件
extension EventViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offsetY: CGFloat = scrollView.contentOffset.y
        
        // 判断顶部自定义导航条的透明度,以及图片的切换
        customNav.alpha = 1 + (offsetY + NavigationH + shopViewHeight) / scrollShowNavH
        if offsetY + shopViewHeight >= -NavigationH && showBlackImage == false {
            backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_1"), forState: .Normal)
            sharedBtn.setImage(UIImage(named: "share_1"), forState: .Normal)
            showBlackImage = true
        } else if offsetY < -NavigationH - shopViewHeight && showBlackImage == true {
            backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
            sharedBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
            showBlackImage = false
        }
        
        // 顶部imageView的跟随动画
        if offsetY < -DetailViewController_TopImageView_Height - shopViewHeight {
            
            self.topImageView.frame.origin.y = 0
            self.topImageView.frame.size.height = -offsetY - shopViewHeight
            
        } else {
            topImageView.frame.origin.y = -offsetY - DetailViewController_TopImageView_Height - shopViewHeight
        }
        
        // 处理shopView
        if offsetY >= -(shopViewHeight + NavigationH) {
            shopView.frame = CGRect(x: 0, y: NavigationH, width: AppWidth, height: shopViewHeight)
        } else {
            shopView.frame = CGRect(x: 0, y: CGRectGetMaxY(topImageView.frame), width: AppWidth, height: shopViewHeight)
        }
        
    }
    
    /// 返回负数
    private func negativeNumber(num: CGFloat) -> CGFloat {
        return num >= 0 ? -num : num
    }
    
    /// 返回正数
    private func positiveNumber(num: CGFloat) -> CGFloat {
        return num >= 0 ? num : -num
    }
    
    /// 返回数字字符串
    private func numStrWith(str: NSString) -> NSString {
        return str.componentsSeparatedByString("\"")[0] as! NSString
    }
}

/// MARK: UIWebViewDelegate
extension EventViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#F5F5F5';")
        for i in 0..<imageWHArray.count {
            let imageW = String(format: "document.getElementsByTagName('img')[%d].style.width='%f';", i, imageWHArray[i].0)
            let imageH = String(format: "document.getElementsByTagName('img')[%d].style.height='%f';", i, imageWHArray[i].1)
            webView.stringByEvaluatingJavaScriptFromString(imageW)
            webView.stringByEvaluatingJavaScriptFromString(imageH)
        }
    }
}

/// MARK: ShopDetailViewDelegate
extension EventViewController: ShopDetailViewDelegate {
    func shopDetailView(shopDetailView: ShopDetailView, didSelectedLable index: Int) {
        if index == 0 {
            
        } else {
            
        }
    }
}


