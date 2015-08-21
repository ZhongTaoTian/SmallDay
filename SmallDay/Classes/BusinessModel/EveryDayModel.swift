//
//  EveryDayModel.swift
//  SmallDay
//
//  Created by MacBook on 15/8/21.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class EveryDayModel: NSObject {
    
    var date: NSString?
    var themes: [ThemeModel]?
    var events: [EventModel]?
    
}


class ThemeModel: NSObject {
    /// 美辑的url网址
    var themeurl: String?
    /// 图片url
    var img: String?
    /// cell主标题
    var title: String?
    /// 是否有web地址 1是有, 0没有
    var hasweb: Int = 0
    /// cell的副标题
    var keywords: String?
    /// 美辑的编号
    var id: Int = 0
}

class EventModel: NSObject {
    var feel: String?
    /// 分享url地址
    var shareURL: String?
    /// 电话
    var telephone: String?
    /// 标签
    var tag: String?
    /// 编号
    var id: Int = 0
    /// 标题
    var title:String?
    /// 详情
    var detail: String?
    /// 城市
    var city: String?
    /// 地址
    var address: String?
    /// 店详情店名
    var remark: String?
    /// 顶部图片数组
    var imgs: NSArray?
    /// 猜你喜欢
    var more: NSArray?
    /// cell内容
    var mobileURL: String?
    /// 位置
    var position: String?
    
}