//
//  EveryDayModel.swift
//  SmallDay
//
//  Created by MacBook on 15/8/21.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

/// 美天总model
class EveryDays: NSObject {
    
    var date: NSString?
    var themes: [ThemeModel]?
    var events: [EventModel]?

    /// 接口有加密 模拟数据
//    class func loadEveryDays() -> EveryDays? {
//        let net = NetworkManager.sharedManager
//        /* ?cityid=101&offset=30&page=1&token_time=1440170554&app_token=D2104E5F31726F2C&version=2.3.9&channel=iTunes&uuid=DDB32FF0-2140-4C7E-BC49-8464D2046532 */
//        net.requestJSON(.GET, "http://api.xiaorizi.me/api/catapi/", ["cityid" : "101", "offset" : "30", "page" : "1", "token_time" : "1440170554", "app_token" : "D2104E5F31726F2C", "version" : "2.3.9", "channel" : "iTunes", "uuid" : "DDB32FF0-2140-4C7E-BC49-8464D2046532"]) { (result, error) -> () in
//            print(result)
//        }
//        return nil
//    }

}

/// 美天model
class ThemeModel: NSObject {
    /// 美辑的url网址
    var themeurl: String?
    /// 图片url
    var img: String?
    /// cell主标题
    var title: String?
    /// 是否有web地址 1是有, 0没有
    var hasweb: Int = -1
    /// cell的副标题
    var keywords: String?
    /// 美辑的编号
    var id: Int = -1
    

}

/// 美天里的美辑model
class EventModel: NSObject {
    var feel: String?
    /// 分享url地址
    var shareURL: String?
    /// 电话
    var telephone: String?
    /// 标签
    var tag: String?
    /// 编号
    var id: Int = -1
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
    var imgs: [String]?
    /// 猜你喜欢
    var more: [GuessLikeModel]?
    /// cell内容
    var mobileURL: String?
    /// 位置
    var position: String?
}

/// 猜你喜欢
class GuessLikeModel: NSObject {
    /// 标题
    var title: String?
    /// 图片
    var imgs: [String]?
    /// 地址
    var address: String?
}

/// 美辑s
class ThemeModels: NSObject, DictModelProtocol {
    var lastdate: String?
    var list: [ThemeModel]?

    class func loadThemesData(completion: (data: ThemeModels?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("themes", ofType: nil)
        var data = NSData(contentsOfFile: path!)
        if data != nil {
            var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: nil) as! NSDictionary
            
            var modelTool = DictModelManager.sharedManager
            var data = modelTool.objectWithDictionary(dict, cls: ThemeModels.self) as? ThemeModels
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(ThemeModel.self)"]
    }
}




