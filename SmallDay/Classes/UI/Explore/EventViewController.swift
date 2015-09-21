//
//  EventViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/24.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  Event点击出来的ViewController ,这个控制器和另一个控制器高度重合,应该抽取一个基类的,这里我开始没注意,另一个都写完了,懒得抽取了...

import UIKit

/// 店发现 店详情的高度
public let EventViewController_ShopView_Height: CGFloat = 45

class EventViewController: UIViewController {

    lazy var loadImage: LoadAnimatImageView = LoadAnimatImageView.sharedManager
    private let imageW = AppWidth - 23.0
    private let scrollShowNavH = DetailViewController_TopImageView_Height - NavigationH
    private lazy var showBlackImage = false
    private lazy var isLoadFinsih = false
    private lazy var isAddBottomView = false
    private lazy var loadFinishScrollHeihgt: CGFloat = 0
    private lazy var guessLikeView: GuessLikeView = GuessLikeView.guessLikeViewFromXib()
    private lazy var moreArr: [MoreView] = [MoreView]()
    private lazy var shareView: ShareView = ShareView.shareViewFromXib()
    private lazy var backBtn: UIButton = UIButton()
    private lazy var likeBtn: UIButton = UIButton()
    private lazy var sharedBtn: UIButton = UIButton()
    private lazy var webView: EventWebView = EventWebView(rect: MainBounds, webViewDelegate: self, webViewScrollViewDelegate: self)
    private lazy var detailContentView: ShopDetailContentView = ShopDetailContentView.shopDetailContentViewFromXib()
    ///  记录scrollView最后一次偏移的Y值
    private var lastOffsetY: CGFloat = 0
    
    /// MARK:- 方法
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        setCustomNavigationItem()
    }
    
    private func setUpUI() {
        view.clipsToBounds = true
        view.backgroundColor = theme.SDWebViewBacagroundColor
        view.addSubview(webView)
        view.addSubview(detailSV)
        view.addSubview(topImageView)
        view.addSubview(shopView)
    }
    
    private func setCustomNavigationItem() {
        view.addSubview(customNav)
        //添加返回按钮
        setButton(backBtn, CGRectMake(-7, 20, 44, 44), "back_0", "back_2", "backButtonClick")
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
            //TODO: 将设置模型数据的代码封装到模型的方法里
            loadImage.startLoadAnimatImageViewInView(view, center: view.center)
            webView.hidden = true
            // 将模型传入给店铺详情页
            detailContentView.detailModel = model
            // 设置地图按钮点击回调闭包
            weak var tmpSelf = self

            detailContentView.mapBtnClickCallback = {
                let navVC = NavigatorViewController()
                navVC.model = tmpSelf!.model
                tmpSelf!.navigationController?.pushViewController(navVC, animated: true)
            }
            detailSV.addSubview(detailContentView)
            detailSV.contentSize = CGSize(width: AppWidth, height: detailContentView.height - EventViewController_ShopView_Height)
            
            if let imageStr = model?.imgs?.last {
                topImageView.wxn_setImageWithURL(NSURL(string: imageStr)!, placeholderImage: UIImage(named: "quesheng")!)
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
                    let newStr: NSMutableString = NSMutableString(string: htmlSrt!)
                    newStr.insertString(titleStr!, atIndex: 31)
                    htmlSrt = newStr as String
                }
            }
            
            let newStr = NSMutableString.changeHeigthAndWidthWithSrting(NSMutableString(string: htmlSrt!))
            webView.loadHTMLString(newStr as String, baseURL: nil)
            webView.hidden = false
            
            if model?.more?.count > 0 {
                guessLikeView.hidden = true
                webView.scrollView.addSubview(guessLikeView)
                for i in 0..<model!.more!.count {
                    let moreModel = model!.more![i]
                    let moreView = MoreView.moreViewWithGuessLikeModel(moreModel)
                    moreView.hidden = true
                    moreView.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 0)
                    webView.scrollView.addSubview(moreView)
                    moreArr.append(moreView)
                }
            }
            
            loadImage.stopLoadAnimatImageView()
        }
    }
    
    /// MARK:- 懒加载属性
    private lazy var customNav: UIView = {
        let customNav = UIView(frame: CGRectMake(0, 0, AppWidth, NavigationH))
        customNav.backgroundColor = UIColor.whiteColor()
        customNav.alpha = 0.0
        return customNav
        }()
    
    private lazy var topImageView: UIImageView = {
        let image = UIImageView(frame: CGRectMake(0, 0, AppWidth, DetailViewController_TopImageView_Height))
        image.image = UIImage(named: "quesheng")
        image.contentMode = .ScaleToFill
        image.clipsToBounds = true
        return image
        }()
    
    private lazy var detailSV: UIScrollView = {
        let detailSV = UIScrollView(frame: MainBounds)
        detailSV.contentInset = UIEdgeInsets(top: DetailViewController_TopImageView_Height + EventViewController_ShopView_Height, left: 0, bottom: 0, right: 0)
        detailSV.showsHorizontalScrollIndicator = false
        detailSV.backgroundColor = theme.SDWebViewBacagroundColor
        detailSV.alwaysBounceVertical = true
        detailSV.hidden = true
        detailSV.delegate = self
        detailSV.setContentOffset(CGPoint(x: 0, y: -(DetailViewController_TopImageView_Height + EventViewController_ShopView_Height)), animated: false)
        return detailSV
        }()
    
    private lazy var shopView: ShopDetailView = {
        let shopView = ShopDetailView(frame: CGRect(x: 0, y: DetailViewController_TopImageView_Height, width: AppWidth, height: EventViewController_ShopView_Height))

        shopView.delegate = self
        return shopView
        }()
    
    ///MARK:- 导航按钮Action
    func backButtonClick() {
        navigationController!.popViewControllerAnimated(true)
    }
    
    func lickBtnClick() {
        //TODO: 将对应的店铺数据插入到本地数据库
        likeBtn.selected = !likeBtn.selected
    }
    
    func sharedBtnClick() {
        view.addSubview(shareView)
        shareView.shareVC = self
        shareView.showShareView(CGRectMake(0, AppHeight - 215, AppWidth, 215))
    }
    
    /// MARK:- 处理导航条显示消失
    override func viewWillAppear(animated: Bool) {
        navigationController!.setNavigationBarHidden(true, animated: true)
        if isLoadFinsih && isAddBottomView {
            webView.scrollView.contentSize.height = loadFinishScrollHeihgt
        }
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        navigationController!.setNavigationBarHidden(false, animated: true)
        super.viewWillDisappear(animated)
    }
    
    deinit {
        print("详情控制器被销毁", terminator: "")
    }
}


/// MARK: 处理内容滚动时的事件
extension EventViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        // 解决弹出新的控制器后返回后contentSize自动还原的问题
        if loadFinishScrollHeihgt > webView.scrollView.contentSize.height && scrollView === webView.scrollView {
            webView.scrollView.contentSize.height = loadFinishScrollHeihgt
        }
        
        let offsetY: CGFloat = scrollView.contentOffset.y
        // 判断顶部自定义导航条的透明度,以及图片的切换
        customNav.alpha = 1 + (offsetY + NavigationH + EventViewController_ShopView_Height) / scrollShowNavH
        if offsetY + EventViewController_ShopView_Height >= -NavigationH && showBlackImage == false {
            backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_1"), forState: .Normal)
            sharedBtn.setImage(UIImage(named: "share_1"), forState: .Normal)
            showBlackImage = true
        } else if offsetY < -NavigationH - EventViewController_ShopView_Height && showBlackImage == true {
            backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
            likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
            sharedBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
            showBlackImage = false
        }
        
        // 顶部imageView的跟随动画
        if offsetY <= -DetailViewController_TopImageView_Height - EventViewController_ShopView_Height {
            topImageView.frame.origin.y = 0
            topImageView.frame.size.height = -offsetY - EventViewController_ShopView_Height
            topImageView.frame.size.width = AppWidth - offsetY - DetailViewController_TopImageView_Height
            topImageView.frame.origin.x = (0 + DetailViewController_TopImageView_Height + offsetY) * 0.5
        } else {
            topImageView.frame.origin.y = -offsetY - DetailViewController_TopImageView_Height - EventViewController_ShopView_Height
        }
        
        // 处理shopView
        if offsetY >= -(EventViewController_ShopView_Height + NavigationH) {
            shopView.frame = CGRect(x: 0, y: NavigationH, width: AppWidth, height: EventViewController_ShopView_Height)
        } else {
            shopView.frame = CGRect(x: 0, y: CGRectGetMaxY(topImageView.frame), width: AppWidth, height: EventViewController_ShopView_Height)
        }
        
        // 记录scrollView最后的偏移量,用于切换scrollView时同步俩个scrollView的偏移值
        lastOffsetY = offsetY
    }
}

/// MARK: UIWebViewDelegate
extension EventViewController: UIWebViewDelegate {
    
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#F5F5F5';")
        isLoadFinsih = true
        guessLikeView.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 50)
        guessLikeView.hidden = false
        webView.scrollView.contentSize.height += 50
        for more in moreArr {
            more.frame = CGRect(x: 0, y: webView.scrollView.contentSize.height, width: AppWidth, height: 230)
            more.hidden = false
            webView.scrollView.contentSize.height += 235
            isAddBottomView = true
        }
        loadFinishScrollHeihgt = webView.scrollView.contentSize.height
    }
}

/// MARK: ShopDetailViewDelegate
extension EventViewController: ShopDetailViewDelegate {
    
    func shopDetailView(shopDetailView: ShopDetailView, didSelectedLable index: Int) {
        if index == 0 {
            detailSV.hidden = true
            webView.hidden = false
            if lastOffsetY > webView.scrollView.contentSize.height + AppHeight {
                webView.scrollView.setContentOffset(CGPoint(x: 0, y: webView.scrollView.contentSize.height), animated: false)
            } else {
                webView.scrollView.setContentOffset(CGPoint(x: 0, y: lastOffsetY), animated: false)
            }
            
        } else {
            detailSV.hidden = false
            webView.hidden = true
            if lastOffsetY > detailSV.contentSize.height - AppHeight {
                detailSV.setContentOffset(CGPoint(x: 0, y: detailSV.contentSize.height - AppHeight), animated: false)
            } else {
                detailSV.setContentOffset(CGPoint(x: 0, y: lastOffsetY), animated: false)
            }
        }
    }
}
