//
//  String+wnxString.swift
//  SmallDay
//
//  Created by MacBook on 15/9/8.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import Foundation
// String扩展
extension String {
    /// 判断是否是邮箱
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
    
    /// 判断是否是手机号
    func validateMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluateWithObject(self)
    }
}

extension NSMutableString {
    
    class func changeHeigthAndWidthWithSrting(searchStr: NSMutableString) -> NSMutableString {
        var mut = [CGFloat]()
        var mutH = [CGFloat]()
        let imageW = AppWidth - 23
        let rxHeight = NSRegularExpression(pattern: "(?<= height=\")\\d*")
        let rxWidth = NSRegularExpression(pattern: "(?<=width=\")\\d*")
        let widthArray = rxWidth.matches(searchStr as String) as! [String]
        
        for width  in widthArray {
            width.toInt()!
            mut.append(imageW/CGFloat(width.toInt()!))
        }
        
        var widthMatches = rxWidth.matchesInString(searchStr as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, searchStr.length))
        
        for var i = widthMatches.count - 1; i >= 0; i-- {
            var widthMatch = widthMatches[i] as? NSTextCheckingResult
            searchStr.replaceCharactersInRange(widthMatch!.range, withString: "\(imageW)")
        }
        
        var newString = searchStr.mutableCopy() as! NSMutableString
        
        let heightArray = rxHeight.matches(newString as String) as! [String]
        for i in 0..<mut.count {
            mutH.append(mut[i] * CGFloat(heightArray[i].toInt()!))
        }
        
        var matches = rxHeight.matchesInString(newString as String, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, newString.length))
        
        for var i = matches.count - 1; i >= 0; i--
        {
            var match = matches[i] as? NSTextCheckingResult
            newString.replaceCharactersInRange(match!.range, withString: "\(mutH[i])")
        }
        
        return newString
    }
}