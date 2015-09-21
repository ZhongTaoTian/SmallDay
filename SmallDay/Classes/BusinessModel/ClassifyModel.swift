//
//  ClassifyModel.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/25.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  分类模型

import UIKit

/// 分类首页模型
class ClassifyModel: NSObject, DictModelProtocol{
    var code: Int = -1
    var list: [ClassModel]?
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(ClassModel.self)"]
    }
    
    class func loadClassifyModel(completion: (data: ClassifyModel?, error: NSError?)->()) {
        let path = NSBundle.mainBundle().pathForResource("Classify", ofType: nil)
        let data = NSData(contentsOfFile: path!)
        if data != nil {
            let dict: NSDictionary = (try! NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments)) as! NSDictionary
            
            let modelTool = DictModelManager.sharedManager
            let data = modelTool.objectWithDictionary(dict, cls: ClassifyModel.self) as? ClassifyModel
            completion(data: data, error: nil)
        }
    }
}

class ClassModel: NSObject, DictModelProtocol{
    var title: String?
    var id: Int = -1
    var tags: [EveryClassModel]?
    
    static func customClassMapping() -> [String : String]? {
        return ["tags" : "\(EveryClassModel.self)"]
    }
}

class EveryClassModel: NSObject {
    /// 分类详情的个数
    var ev_count: Int = -1
    var id: Int = -1
    var img: String?
    var name: String?
}

class DetailModel: NSObject, DictModelProtocol {
    var msg: String?
    var code: Int = -1
    var list: [EventModel]?
    
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(EventModel.self)"]
    }
    
    /// 加载详情模型
    class func loadDetails(completion: (data: DetailModel?, error: NSError?) -> ()) {
        loadDatas("Details", isShowDis: false, completion: completion)
    }
    
    /// 加载美辑点击按钮的更多模型
    class func loadMore(completion: (data: DetailModel?, error: NSError?) -> ()) {
        loadDatas("More", isShowDis: false, completion: completion)
    }
    
    /// 加载附近店铺数据
    class func loadNearDatas(completion: (data: DetailModel?, error: NSError?) -> ()) {
        loadDatas("Nears", isShowDis: true, completion: completion)
    }
    
    private class func loadDatas(fileName: String, isShowDis: Bool, completion: (data: DetailModel?, error: NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource(fileName, ofType: nil)
        if let data = NSData(contentsOfFile: path!) {
            let dict = (try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let datas = modelTool.objectWithDictionary(dict, cls: DetailModel.self) as? DetailModel
            if isShowDis {
                for event in datas!.list! {
                    event.isShowDis = true
                    if UserInfoManager.sharedUserInfoManager.userPosition != nil {
                        let userL = UserInfoManager.sharedUserInfoManager.userPosition!
                        let shopL = event.position!.stringToCLLocationCoordinate2D(",")!
                        let dis = MAMetersBetweenMapPoints(MAMapPointForCoordinate(userL), MAMapPointForCoordinate(shopL))
                        event.distanceForUser = String(format: "%.1fkm", dis * 0.001)
                    }
                }
            }
            completion(data: datas, error: nil)
        }
    }
}

class SearchsModel: NSObject, DictModelProtocol {
    var list: [EventModel]?
    static func customClassMapping() -> [String : String]? {
        return ["list" : "\(EventModel.self)"]
    }
    
    class func loadSearchsModel(title: String, completion: (data: SearchsModel?, error: NSError?) -> ()) {
        var path: String?
        if title == "南锣鼓巷" || title == "798" || title == "三里屯" {
            path = NSBundle.mainBundle().pathForResource(title, ofType: nil)
        } else {
            path = NSBundle.mainBundle().pathForResource("南锣鼓巷", ofType: nil)
        }
        
        if let data = NSData(contentsOfFile: path!) {
            let dict = (try! NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)) as! NSDictionary
            let modelTool = DictModelManager.sharedManager
            let datas = modelTool.objectWithDictionary(dict, cls: SearchsModel.self) as? SearchsModel
            completion(data: datas, error: nil)
        }
        
    }
}









