//
//  NetworkManager.swift
//  HMWeibo04
//
//  Created by apple on 15/8/17.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import Foundation

///  网路访问接口 - 单例
///  用来隔离应用程序和第三方框架之间的网络访问
class NetworkManager {
    
    // 单例的概念：
    // 1. 内存中有一个唯一的实例
    // 2. 提供唯一的全局访问入口
    // let 是定义常量，而且在 swift 中，let 是线程安全的
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
