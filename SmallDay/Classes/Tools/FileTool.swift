//
//  FileTool.swift
//  SmallDay
//
//  Created by MacBook on 15/9/1.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  管理沙盒文件的工具

import UIKit

class FileTool: NSObject {
    
    static let fileManager = NSFileManager.defaultManager()
    
    /// 计算单个文件的大小
    class func fileSize(path: String) -> Double {
        
        if fileManager.fileExistsAtPath(path) {
            var dict = fileManager.attributesOfItemAtPath(path, error: nil)
            if let fileSize = dict![NSFileSize] as? Int{
                return Double(fileSize) / 1024.0 / 1024.0
            }
        }

        return 0.0
    }
    
    /// 计算整个文件夹的大小
    class func folderSize(path: String) -> Double {
        var folderSize: Double = 0
        if fileManager.fileExistsAtPath(path) {
            let chilerFiles = fileManager.subpathsAtPath(path) as! [String]
            for fileName in chilerFiles {
                let fileFullPathName = path.stringByAppendingPathComponent(fileName)
                folderSize += FileTool.fileSize(fileFullPathName)
            }
            return folderSize
        }
        return 0
    }
    
    /// 彻底清除文件夹,异步
    class func cleanFolder(path: String, complete:() -> ()) {
        SVProgressHUD.showWithStatus("正在清理缓存", maskType: SVProgressHUDMaskType.Clear)
        let queue = dispatch_queue_create("cleanQueue", nil)
        
        dispatch_async(queue) { () -> Void in
            let chilerFiles = self.fileManager.subpathsAtPath(path) as! [String]
            for fileName in chilerFiles {
                let fileFullPathName = path.stringByAppendingPathComponent(fileName)
                if self.fileManager.fileExistsAtPath(fileFullPathName) {
                    self.fileManager.removeItemAtPath(fileFullPathName, error: nil)
                }
            }
            
            // 线程睡1秒 测试
            NSThread.sleepForTimeInterval(1.0)
            
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                SVProgressHUD.dismiss()
                complete()
            })
        }
    }
    
}
