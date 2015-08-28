//
//  ExperienceModel.swift
//  SmallDay
//
//  Created by MacBook on 15/8/27.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验模型

import UIKit

class ExperienceModel: NSObject, DictModelProtocol {
    var head: [ExperienceHeadModel]?
    var list: [EventModel]?
    
    static func customClassMapping() -> [String : String]? {
        return ["head" : "\(ExperienceHeadModel.self)", "list" : "\(EventModel.self)"]
    }
    
    class func loadExperienceModel(completion: (data: ExperienceModel?, error: NSError?) -> ()) {
        let path = NSBundle.mainBundle().pathForResource("Experience", ofType: nil)
        var data = NSData(contentsOfFile: path!)
        if data != nil {
            var dict: NSDictionary = NSJSONSerialization.JSONObjectWithData(data!, options: .AllowFragments, error: nil) as! NSDictionary
            
            var modelTool = DictModelManager.sharedManager
            var data = modelTool.objectWithDictionary(dict, cls: ExperienceModel.self) as? ExperienceModel
            completion(data: data, error: nil)
        }
        
    }
}

class ExperienceHeadModel: NSObject {
    var feel: String?
    var shareURL: String?
    var tag: String?
    var id: Int = -1
    /// imageURL
    var adurl: String?
    var title: String?
    var mobileURL: String?
}
