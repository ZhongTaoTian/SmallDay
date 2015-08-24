//
//  ClassifyModel.swift
//  SmallDay
//
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
        var data = NSData(contentsOfFile: path!)
        if data != nil {
            var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: nil) as! NSDictionary
            
            var modelTool = DictModelManager.sharedManager
            var data = modelTool.objectWithDictionary(dict, cls: ClassifyModel.self) as? ClassifyModel
            print(data)
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