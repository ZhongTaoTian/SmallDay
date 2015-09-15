//
//  nearCell.swift
//  SmallDay
//
//  Created by MacBook on 15/9/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  附近地图展示的cell

import UIKit

class nearCell: UICollectionViewCell {
    
    var nearModel: EventModel? {
        didSet {
            let urlStr = nearModel!.imgs![0]
            imageImageView.wxn_setImageWithURL(NSURL(string: urlStr)!, placeholderImage: UIImage(named: "quesheng")!)
            adressLabel.text = nearModel?.address
            titleLabel.text = nearModel?.title
            println(UserInfoManager.sharedUserInfoManager.userPosition)
            if UserInfoManager.sharedUserInfoManager.userPosition != nil {
                let userL = UserInfoManager.sharedUserInfoManager.userPosition!
                let shopL = nearModel!.position!.stringToCLLocationCoordinate2D(",")!
//                MAMetersBetweenMapPoints(UserInfoManager.sharedUserInfoManager.userPosition!, nearModel!.position!.stringToCLLocationCoordinate2D(",")!)
//                MAMetersBetweenMapPoints(<#a: MAMapPoint#>, <#b: MAMapPoint#>)
              let aaaa = MAMetersBetweenMapPoints(MAMapPointForCoordinate(userL), MAMapPointForCoordinate(shopL))

                println(aaaa)
            }
        }
    }
    
    @IBOutlet private weak var disLabel: UILabel!
    @IBOutlet private weak var adressLabel: UILabel!
    @IBOutlet private weak var imageImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        backgroundColor = UIColor.whiteColor()
    }
    
}
