//
//  AppDelegate.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  由于Swift语言还不稳定,每个版本都会出现语法修改,本项目用最新的Xcode7正式版编写,建议使用Xcode7正式版运行工程
//  本项目之前使用的Xcode6.2编译, 9.18更新到了Xcode7,临时修改了新语法,但是针对iOS9.0只是修改了网络请求,发现在程序运行的时候会输出很多错误信息,iOS9.0多了很多变动,小熊还在研究,如有任何意见请到我的博客或者微博留言交流,小熊会在看到的第一时间回复

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        setKeyWindow()
        
        setAppAppearance()
        
        setShared()
        
        setUserMapInfo()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "showMianViewController", name: SD_ShowMianTabbarController_Notification, object: nil)
        
        return true
    }
    
    private func setKeyWindow() {
        window = UIWindow(frame: MainBounds)
        
        window?.rootViewController = showLeadpage()
        
        window?.makeKeyAndVisible()
    }
    
    func setUserMapInfo() {
        UserInfoManager.sharedUserInfoManager.startUserlocation()
        MAMapServices.sharedServices().apiKey = theme.GaoDeAPPKey
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    //MARK: - 分享设置
    func setAppAppearance() {
        let itemAppearance = UITabBarItem.appearance()
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.blackColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Selected)
        itemAppearance.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.grayColor(), NSFontAttributeName : UIFont.systemFontOfSize(12)], forState: .Normal)
        
        //设置导航栏主题
        let navAppearance = UINavigationBar.appearance()
        // 设置导航titleView字体
        navAppearance.translucent = false
        navAppearance.titleTextAttributes = [NSFontAttributeName : theme.SDNavTitleFont, NSForegroundColorAttributeName : UIColor.blackColor()]
        
        let item = UIBarButtonItem.appearance()
        item.setTitleTextAttributes([NSFontAttributeName : theme.SDNavItemFont, NSForegroundColorAttributeName : UIColor.blackColor()], forState: .Normal)
    }
    
    func setShared() {
        UMSocialData.setAppKey(theme.UMSharedAPPKey)
//        UMSocialSinaHandler.openSSOWithRedirectURL("http://www.jianshu.com/users/5fe7513c7a57/latest_articles")
        UMSocialSinaHandler.openSSOWithRedirectURL(nil)
        UMSocialWechatHandler.setWXAppId("wx485c6ee1758251bd", appSecret: "468ab73eef432f59a2aa5630e340862f", url: theme.JianShuURL)
        UMSocialConfig.hiddenNotInstallPlatforms([UMShareToWechatSession,UMShareToWechatTimeline])
    }
    
    func application(application: UIApplication, handleOpenURL url: NSURL) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    func application(application: UIApplication, openURL url: NSURL, sourceApplication: String?, annotation: AnyObject) -> Bool {
        return UMSocialSnsService.handleOpenURL(url)
    }
    
    //MARK: - 引导页设置
    private func showLeadpage() -> UIViewController {
        let versionStr = "CFBundleShortVersionString"
        let cureentVersion = NSBundle.mainBundle().infoDictionary![versionStr] as! String
        let oldVersion = (NSUserDefaults.standardUserDefaults().objectForKey(versionStr) as? String) ?? ""
        
        if cureentVersion.compare(oldVersion) == NSComparisonResult.OrderedDescending {
            NSUserDefaults.standardUserDefaults().setObject(cureentVersion, forKey: versionStr)
            NSUserDefaults.standardUserDefaults().synchronize()
            return LeadpageViewController()
        }
        
        return MainTabBarController()
    }
    
    func showMianViewController() {
        let mainTabBarVC = MainTabBarController()
        self.window!.rootViewController = mainTabBarVC
        let nav = mainTabBarVC.viewControllers![0] as? MainNavigationController
        (nav?.viewControllers[0] as! MainViewController).pushcityView()
    }
    
    func applicationDidReceiveMemoryWarning(application: UIApplication) {
        SDWebImageManager.sharedManager().imageCache.cleanDisk()
        SDWebImageManager.sharedManager().cancelAll()
    }
}

