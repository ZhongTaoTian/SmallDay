//
//  DetailViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/28.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验详情ViewController

import UIKit
/// 详情ViewController顶部图片的高度
public let DetailViewController_TopImageView_Height: CGFloat = 225

class DetailViewController: UIViewController {
    // 优化性能,防止重复设置
    var showBlackImage: Bool = false
    let scrollShowNavH: CGFloat = DetailViewController_TopImageView_Height - NavigationH
    var model: EventModel? {
        didSet {
            self.shareView.shareModel = model
        }
    }
    
    var signUpBtn: UIButton!
    
    lazy var customNav: UIView! = {
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
    
    lazy var topImageView: UIImageView! = {
        let image = UIImageView(frame: CGRectMake(0, 0, AppWidth, DetailViewController_TopImageView_Height))
        image.image = UIImage(named: "quesheng")
        return image
        }()
    
    lazy var webView: UIWebView! = {
        let webView = UIWebView(frame: UIScreen.mainScreen().bounds)
        webView.scrollView.contentInset = UIEdgeInsetsMake(DetailViewController_TopImageView_Height - 20, 0, -(DetailViewController_TopImageView_Height - 20), 0)

        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.scrollView.contentSize.width = AppWidth
        webView.backgroundColor = theme.SDBackgroundColor
        webView.scrollView.delegate = self
        webView.delegate = self
        
        //        webView.scalesPageToFit = true
        webView.paginationMode = UIWebPaginationMode.TopToBottom
        webView.paginationBreakingMode = UIWebPaginationBreakingMode.Column
        
        webView.loadHTMLString("<body><html><head></head><body><p>油画对你来说只是个名词？是挂在墙上的装饰？还是一种高高在上的艺术？</p><p>如果你厌倦了唱歌、逛街、看电影，希望尝试新的休闲娱乐方式， 培养一个优雅的爱好，有自我创作的欲望，尚美色彩自助画室是你最佳的选择！</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-08-04/event133426.jpg\" height=\"220\" src=\"http://pic.huodongjia.com/event/2015-08-04/event133426.jpg\" width=\"352\"></img></p><p>尚美色彩自助画室位于北京CBD核心商业圈双井商业区，国贸南十号线双井站，朝阳区双井优士阁大厦B座606，10号线地铁西南口出，交通银行上面入口。</p><p>画室为对绘画感兴趣的人士提供了一个无拘无束自由自在的绘画空间。我们为你准备了绘画所需的一切工具，并有专业老师指导。</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-08-04/event133427.jpg\" height=\"512\" src=\"http://pic.huodongjia.com/event/2015-08-04/event133427.jpg\" width=\"605\"></img></p><p>无论你是否有绘画基础，在尚美色彩自助画室都可以发掘自己的艺术天分，并在艺术创作的同时舒展情绪，摆脱压力和烦恼，用色彩和线条表现真正的自我。</p><p>你的创作，无论是临摹还是个性涂鸦，都会是全球限量版的艺术品！  </p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-08-04/event133428.png\" height=\"519\" src=\"http://pic.huodongjia.com/event/2015-08-04/event133428.png\" width=\"453\"></img>               </p><p><strong>油画体验套餐包括：</strong></p><p>实木框艺术家专用油画画布</p><p>全色系无毒无害环保颜料及全套作画工具、材料，无需自己准备任何额外物品</p><p>店内有彩图画册供参考选择，顾客也可自带参考图或自由创作</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-08-04/event133432.jpg\" height=\"460\" src=\"http://pic.huodongjia.com/event/2015-08-04/event133432.jpg\" width=\"690\"></img></p><p>驻店专业指导老师针对零基础的绘画者进行免费指导：画前理论讲解、绘画工具使用及注意事项、绘画过程中难点答疑和绘画技巧讲解演示，协助体验者完成一副漂亮的作品，作品可带走。</p><p>免费饮料（柠檬水、菊花茶、咖啡、小吃零食、应季水果）</p><p>免费提供特制便携包装，方便携带</p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-08-04/event133433.jpg\" height=\"699\" src=\"http://pic.huodongjia.com/event/2015-08-04/event133433.jpg\" width=\"1057\"></img></p><p><strong>画框大小</strong>30*30cm   </p><p><strong>体验时长</strong> 3-4小时</p><p><strong>价格 </strong>99元  </p><p><img alt=\"\" data-cke-saved-src=\"http://pic.huodongjia.com/event/2015-08-04/event133430.jpg\" height=\"1334\" src=\"http://pic.huodongjia.com/event/2015-08-04/event133430.jpg\" width=\"1001\"></img></p><p><strong>地址:</strong> 北京市朝阳区广渠门外大街8号东B座606（地下停车场：每小时5元）</p><p><strong>预约电话：</strong>18601204990（手机）请提前3个小时预约</p><p><strong>营业时间:</strong></p><p>周日至周四 10:00 — 22:00</p><p>周五、周六 10:00 — 23:00</p></body></html></body>", baseURL: nil)
        return webView
        }()
    
    deinit {
        print("已经销毁")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
        
        setCustomNavigationItem()
        
        setUpBottomView()
        
    }
    
    func setUpBottomView() {
        // 添加底部报名View
        let bottomView = UIView(frame: CGRectMake(0, AppHeight - 49, AppWidth, 49))
        bottomView.backgroundColor = UIColor.whiteColor()
        view.addSubview(bottomView)
        
        signUpBtn = UIButton()
        signUpBtn.setBackgroundImage(UIImage(named: "registration_1"), forState: .Normal)
        signUpBtn.frame = CGRectMake((AppWidth - 158) * 0.5, (49 - 36) * 0.5, 158, 36)
        signUpBtn.setTitle("报 名", forState: .Normal)
        signUpBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        signUpBtn.addTarget(self, action: "signUpBtnClick", forControlEvents: .TouchUpInside)
        bottomView.addSubview(signUpBtn)
    }
    
    func setUpUI() {
        view.backgroundColor = theme.SDBackgroundColor
        view.addSubview(webView)
        view.addSubview(topImageView)
    }
    
    func setCustomNavigationItem() {
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
    

}

/// MARK: 所有按钮的事件
extension DetailViewController {
    /// 返回
    func backButtonClick() {
        navigationController!.popViewControllerAnimated(true)
    }
    
    /// 收藏
    func lickBtnClick() {
        
    }
    
    /// 分享
    func sharedBtnClick() {
        /*[UMSocialSnsService presentSnsIconSheetView:self
        appKey:@"507fcab25270157b37000010"
        shareText:@"友盟社会化分享让您快速实现分享等社会化功能，http://umeng.com/social"
        shareImage:[UIImage imageNamed:@"icon"]
        shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
        delegate:self];*/
//        UMSocialSnsService.presentSnsController(self, appKey: theme.UMSharedAPPKey, shareText: "测试SSO分享", shareImage: nil, shareToSnsNames: [UMShareToSina], delegate: nil)
        view.addSubview(shareView)
        shareView.showShareView()
    }
    
    /// 报名
    func signUpBtnClick() {
        let suVC = SignUpViewController()
//        print()
        navigationController!.pushViewController(suVC, animated: true)
        suVC.topTitle = model!.title
    }
}

/// MARK: 处理导航条显示消失
extension DetailViewController {
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
extension DetailViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        var offsetY: CGFloat = scrollView.contentOffset.y
        
        //这里我说明下一加标记的作用:
        if scrollView === self.webView.scrollView {
            // 判断顶部自定义导航条的透明度,以及图片的切换
            customNav.alpha = 1 + (offsetY + NavigationH) / scrollShowNavH
            if offsetY >= -NavigationH && showBlackImage == false {
                backBtn.setImage(UIImage(named: "back_1"), forState: .Normal)
                likeBtn.setImage(UIImage(named: "collect_1"), forState: .Normal)
                sharedBtn.setImage(UIImage(named: "share_1"), forState: .Normal)
                showBlackImage = true
            } else if offsetY < -NavigationH && showBlackImage == true {
                backBtn.setImage(UIImage(named: "back_0"), forState: .Normal)
                likeBtn.setImage(UIImage(named: "collect_0"), forState: .Normal)
                sharedBtn.setImage(UIImage(named: "share_0"), forState: .Normal)
                showBlackImage = false
            }
            
            // 顶部imageView的跟随动画
            topImageView.frame.origin.y = -offsetY - DetailViewController_TopImageView_Height
        }
    }
    
    /// 返回负数
    func negativeNumber(num: CGFloat) -> CGFloat {
        return num >= 0 ? -num : num
    }
    
    /// 返回正数
    func positiveNumber(num: CGFloat) -> CGFloat {
        return num >= 0 ? num : -num
    }
}

/// MARK: UIWebViewDelegate
extension DetailViewController: UIWebViewDelegate {
    func webViewDidFinishLoad(webView: UIWebView) {
        webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('body')[0].style.background='#F5F5F5'")
    }
}



