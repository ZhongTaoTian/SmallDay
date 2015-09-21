//
//  EveryDayModel.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/21.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探店Model, 这个APP的很多model都很相近,其实可以提取出所有不同的模型汇总成一个通用模型,我个人喜欢分开不同的模型

import UIKit

class EveryDays: NSObject, DictModelProtocol {
    
    var msg: String?
    var code: Int = -1
    var list: [EveryDay]?
    
    class func loadEventsData(completion: (data: EveryDays?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("events", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: EveryDays.self) as? EveryDays
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(EveryDay.self)"]
    }
}

/// 美天model
class EveryDay: NSObject, DictModelProtocol {
    
    var date: NSString? {
        willSet {
            if let tmpDate = newValue {
                if tmpDate.length == 10 {
                    if let tmpM = Int(tmpDate.substringWithRange(NSRange(location: 5, length: 2))) {
                        switch tmpM {
                        case 1:
                            self.month = "Jan."
                        case 2:
                            self.month = "Feb."
                        case 3:
                            self.month = "Mar."
                        case 4:
                            self.month = "Apr."
                        case 5:
                            self.month = "May."
                        case 6:
                            self.month = "Jun."
                        case 7:
                            self.month = "Jul."
                        case 8:
                            self.month = "Aug."
                        case 9:
                            self.month = "Sep."
                        case 10:
                            self.month = "Oct."
                        case 11:
                            self.month = "Nov."
                        case 12:
                            self.month = "Dec."
                        default:
                            self.month = "\(tmpM)."
                        }
                    } else {
                        self.month = "Aug."
                    }
                    
                    self.day = tmpDate.substringWithRange(NSRange(location: 8, length: 2))
                } else {
                    self.date = newValue
                    return
                }
            }
            
            self.date = newValue
        }
    }
    
    var themes: [ThemeModel]?
    var events: [EventModel]?
    
    // 辅助模型, 为了优化 每个模型只计算一次
    var month: String?
    var day: String?
    
    /// 接口有加密 模拟数据
    //    class func loadEveryDays() -> EveryDays? {
    //        let net = NetworkManager.sharedManager
    //        /* ?cityid=101&offset=30&page=1&token_time=1440170554&app_token=D2104E5F31726F2C&version=2.3.9&channel=iTunes&uuid=DDB32FF0-2140-4C7E-BC49-8464D2046532 */
    //        net.requestJSON(.GET, "http://api.xiaorizi.me/api/catapi/", ["cityid" : "101", "offset" : "30", "page" : "1", "token_time" : "1440170554", "app_token" : "D2104E5F31726F2C", "version" : "2.3.9", "channel" : "iTunes", "uuid" : "DDB32FF0-2140-4C7E-BC49-8464D2046532"]) { (result, error) -> () in
    //            print(result)
    //        }
    //        return nil
    //    }
    
    static func customClassMapping() -> [String : String]? {
        return ["themes" : "\(ThemeModel.self)", "events" : "\(EventModel.self)"]
    }
    
}

/// 美辑model
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
    var text: String?
    
}

/// 美天model
class EventModel: NSObject, DictModelProtocol {
    var feel: String?
    /// 分享url地址
    var shareURL: String?
    var note: String?
    var questionURL: String?
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
    /// cellTitle
    var feeltitle: String?
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
    
    // 辅助模型
    /// 标记是否需要显示距离
    var isShowDis = false
    /// 计算出用户当前位置距离店铺我距离,单位km
    var distanceForUser: String?
    
    static func customClassMapping() -> [String : String]? {
        return ["more" : "\(GuessLikeModel.self)"]
    }
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
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ThemeModels.self) as? ThemeModels
            completion(data: data, error: nil)
        }
    }
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(ThemeModel.self)"]
    }
}




