//
//  NetworkManager.swift
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  网络请求管理者,本项目没有网络请求,数据都是读取本地的

import Foundation

class NetworkManager {
    
    private static let instance = NetworkManager()
    /// 定义一个类变量，提供全局的访问入口，类变量不能存储数值，但是可以返回数值
    class var sharedManager: NetworkManager {
        return instance
    }
    
    // 定义了一个类的完成闭包类型
    typealias Completion = (result: AnyObject?, error: NSError?) -> ()

    func requestJSON(method: HTTPMethod, _ urlString: String, _ params: [String: String]?, completion: Completion) {

        net.requestJSON(method, urlString, params, completion: completion)
    }

    /// 取消全部网络请求
    func cancleAllNetwork() {
        net.cancleAllNetwork()
    }
    
    ///  全局的一个网络框架实例，本身也只会被实例化一次
    private let net = SimpleNetwork()
}
