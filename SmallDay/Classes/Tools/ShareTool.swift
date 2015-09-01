//
//  ShareTool.swift
//  SmallDay
//
//  Created by MacBook on 15/8/31.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  分享工具,新浪SSOren认证, 微信,微信朋友圈分享必须在真机上才能运行

import UIKit

class ShareTool: NSObject {

    class func shareToSina(model: ShareModel, viewController: UIViewController?)  {
        var image: UIImage = UIImage(named: "author")!
        // 新浪的连接直接写入到分享文字中就行
        UMSocialControllerService.defaultControllerService().setShareText(model.shareDetail! + theme.JianShuURL, shareImage: image, socialUIDelegate: nil)
        UMSocialSnsPlatformManager.getSocialPlatformWithName(UMShareToSina).snsClickHandler(viewController, UMSocialControllerService.defaultControllerService(), true)
    }
    
    class func shareToWeChat(model: ShareModel) {
        
        UMSocialData.defaultData().extConfig.wechatSessionData.url = theme.JianShuURL
        UMSocialData.defaultData().extConfig.wechatSessionData.title = model.shareTitle
        var image: UIImage = UIImage(named: "author")!
        
        var shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: model.shareURL)
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatSession], content: model.shareDetail, image: image, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.value == UMSResponseCodeSuccess.value {
                SVProgressHUD.showSuccessWithStatus("分享成功")
            }
        }
    }
    
    class func shareToWeChatFriends(model: ShareModel) {
        UMSocialData.defaultData().extConfig.wechatSessionData.url = theme.JianShuURL
        UMSocialData.defaultData().extConfig.wechatSessionData.title = model.shareTitle
        var image: UIImage = UIImage(named: "author")!
        
        var shareURL = UMSocialUrlResource(snsResourceType: UMSocialUrlResourceTypeImage, url: model.shareURL)
        UMSocialDataService.defaultDataService().postSNSWithTypes([UMShareToWechatTimeline], content: model.shareTitle, image: image, location: nil, urlResource: shareURL, presentedController: nil) { (response) -> Void in
            if response.responseCode.value == UMSResponseCodeSuccess.value {
                SVProgressHUD.showSuccessWithStatus("分享成功")
            }
        }
    }
    
}
