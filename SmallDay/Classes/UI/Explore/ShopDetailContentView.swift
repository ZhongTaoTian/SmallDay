//
//  ShopDetailContentView.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/9/8.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  店.详情的contentView


import UIKit

class ShopDetailContentView: UIView {
    
    @IBOutlet weak private var shopName: UILabel!
    @IBOutlet weak private var phoneNumberLabel: UILabel!
    @IBOutlet weak private var adressLabel: UILabel!
    @IBOutlet weak private var correctBtn: UIButton!
    
    var mapBtnClickCallback:(() -> ())?
    
    var shopDetailContentViewHeight: CGFloat = 0
    var detailModel: EventModel? {
        didSet {
            shopName.text = detailModel!.remark
            phoneNumberLabel.text = detailModel!.telephone
            adressLabel.text = detailModel!.address
            // 计算出contentView的高度
            shopDetailContentViewHeight = CGRectGetMaxY(correctBtn.frame)
        }
    }
    
    class func shopDetailContentViewFromXib() -> ShopDetailContentView {
        let shopView = NSBundle.mainBundle().loadNibNamed("ShopDetailContentView", owner: nil, options: nil).last as! ShopDetailContentView
        shopView.frame.size.width = AppWidth
        shopView.backgroundColor = theme.SDWebViewBacagroundColor
        return shopView
    }
    
    @IBAction func callBtnCleck(sender: UIButton) {
        if detailModel?.telephone == "" {
            return
        }
        callActionSheet.showInView(self)
    }
    
    @IBAction func mapBtnClick(sender: UIButton) {
//        let naviVC = NavigatorViewController()
        mapBtnClickCallback!()
    }
    
    @IBAction func correctBtnClick(sender: UIButton) {
        correctActionSheet.showInView(self)
    }
    
    /// MARK:- 懒加载属性
    private lazy var callActionSheet: UIActionSheet = {
        let call = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: self.phoneNumberLabel.text)
        return call
        }()
    private lazy var correctActionSheet: UIActionSheet = {
        let correct = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "地址错误", "电话错误", "店名/店铺介绍/图片错误", "关门/歇业/即将转让")
        return correct
        }()
}

extension ShopDetailContentView: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        if actionSheet === callActionSheet {
            if buttonIndex == 0 {
                let numURL = "tel://" + phoneNumberLabel.text!
                UIApplication.sharedApplication().openURL(NSURL(string: numURL)!)
            }
        } else if actionSheet === correctActionSheet {
            switch buttonIndex {
            case 1, 2, 3, 4: SVProgressHUD.showSuccessWithStatus("反馈成功", maskType: SVProgressHUDMaskType.Black)
            default: break
            }
        }
    }
    
}
