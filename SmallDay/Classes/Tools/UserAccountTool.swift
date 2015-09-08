//
//  UserAccountTool.swift
//  SmallDay
//
//  Created by MacBook on 15/9/9.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  管理用户账号工具

import UIKit

class UserAccountTool: NSObject {
   
    /// 判断当前用户是否登录
    class func userIsLogin() -> Bool {
        let user = NSUserDefaults.standardUserDefaults()
        var account = user.objectForKey(SD_UserDefaults_Account) as? String
        var password = user.objectForKey(SD_UserDefaults_Password) as? String
        
        if account != nil && password != nil {
            if !account!.isEmpty && !password!.isEmpty {
                return true
            }
        }
        return false
    }
    
    /// 如果用户登录了,返回用户的账号(电话号)
    class func userAccount() -> String? {
        if !userIsLogin() {
            return nil
        }
        
        let user = NSUserDefaults.standardUserDefaults()
        var account = user.objectForKey(SD_UserDefaults_Account) as? String
        return account!
    }
    
}
