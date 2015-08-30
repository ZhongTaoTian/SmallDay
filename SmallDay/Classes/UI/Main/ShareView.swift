//
//  ShareView.swift
//  SmallDay
//
//  Created by MacBook on 15/8/31.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class ShareView: UIView {

    var shareModel: EventModel?
    lazy var coverBtn: UIButton! = {
        let coverBtn = UIButton(frame: UIScreen.mainScreen().bounds)
        coverBtn.backgroundColor = UIColor.blackColor()
        coverBtn.alpha = 0.2
        coverBtn.addTarget(self, action: "coverClick", forControlEvents: UIControlEvents.TouchUpInside)
        return coverBtn
        }()
    
    class func shareViewFromXib() -> ShareView {
        let shareV = NSBundle.mainBundle().loadNibNamed("ShareView", owner: nil, options: nil).last as! ShareView
        shareV.frame = CGRectMake(0, AppHeight, AppWidth, 215)
        return shareV
    }
 
    @IBAction func weChat(sender: AnyObject) {
        hideShareView()
        ShareTool.shareToWeChat(self.shareModel!)
    }
    
    @IBAction func friends(sender: AnyObject) {
        hideShareView()
        ShareTool.shareToWeChatFriends(self.shareModel!)
    }
    
    @IBAction func sina(sender: AnyObject) {
        hideShareView()
        ShareTool.shareToSina(self.shareModel!)
    }
    
    @IBAction func cancle(sender: AnyObject) {
        hideShareView()
    }

    func showShareView() {
        self.superview?.insertSubview(coverBtn, belowSubview: self)
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.frame = CGRectMake(0, AppHeight - 215, AppWidth, 215)
        })
    }
    
    func hideShareView() {
        coverBtn.removeFromSuperview()
        UIView.animateWithDuration(0.4, animations: { () -> Void in
            self.frame = CGRectMake(0, AppHeight, AppWidth, 215)
        }) { (finsch) -> Void in
            self.removeFromSuperview()
        }
    }
    
    func coverClick()  {
        hideShareView()
    }
}
