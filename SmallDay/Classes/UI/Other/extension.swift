//
//  extension.swift
//  SmallDay
//
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

/// 对UIView的扩展
extension UIView {
    /// X值
    var x: CGFloat {
        return self.frame.origin.x
    }
    /// Y值
    var y: CGFloat {
        return self.frame.origin.y
    }
    /// 宽度
    var width: CGFloat {
        return self.frame.size.width
    }
    ///高度
    var height: CGFloat {
        return self.frame.size.height
    }
    var size: CGSize {
        return self.frame.size
    }
    var point: CGPoint {
        return self.frame.origin
    }
}

/// 扩展UIBarButtonItem
extension UIBarButtonItem {
    /// 针对导航条右边按钮的自定义item
    convenience init(imageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        var button: UIButton = UIButton.buttonWithType(.Custom) as! UIButton
        button.setImage(UIImage(named: imageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, -10)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Right
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    /// 针对导航条左边按钮的自定义item
    convenience init(leftimageName: String, highlImageName: String, targer: AnyObject, action: Selector) {
        let button: UIButton = UIButton.buttonWithType(.Custom) as! UIButton
        button.setImage(UIImage(named: leftimageName), forState: .Normal)
        button.setImage(UIImage(named: highlImageName), forState: .Highlighted)
        button.frame = CGRectMake(0, 0, 50, 44)
        button.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 0)
        button.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
    
    /// 导航条纯文字按钮
    convenience init(title: String, titleClocr: UIColor, targer: AnyObject ,action: Selector) {
        
        let button = UIButton.buttonWithType(.Custom) as! UIButton
        button.setTitle(title, forState: .Normal)
        button.setTitleColor(titleClocr, forState: .Normal)
        button.titleLabel?.font = theme.SDNavTitleFont
        button.setTitleColor(UIColor.grayColor(), forState: .Highlighted)
        button.sizeToFit()
        button.addTarget(targer, action: action, forControlEvents: .TouchUpInside)
        
        self.init(customView: button)
    }
}

// UIColor的扩展
extension UIColor {
    class func colorWith(red: Int, green: Int, blue: Int, alpha: CGFloat) -> UIColor {
        let color = UIColor(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
        return color
    }
    
}

// UIImage的扩展
extension UIImage {
    /// 将传入的图片裁剪成带边缘的原型图片
    class func imageWithClipImage(image: UIImage, borderWidth: CGFloat, borderColor: UIColor) -> UIImage {
        let imageWH = image.size.width
        let border = borderWidth
        let ovalWH = imageWH + 2 * borderWidth
        
        UIGraphicsBeginImageContextWithOptions(CGSizeMake(ovalWH, ovalWH), false, 0)
        let path = UIBezierPath(ovalInRect: CGRectMake(0, 0, ovalWH, ovalWH))
        borderColor.set()
        path.fill()
        
        let clipPath = UIBezierPath(ovalInRect: CGRectMake(borderWidth, borderWidth, imageWH, imageWH))
        clipPath.addClip()
        image.drawAtPoint(CGPointMake(borderWidth, borderWidth))
        
        let clipImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return clipImage
    }
    
    /// 将传入的图片裁剪成圆形图片
    func imageClipOvalImage() -> UIImage {
        UIGraphicsBeginImageContextWithOptions(self.size, false, 0.0)
        let ctx = UIGraphicsGetCurrentContext()
        let rect = CGRectMake(0, 0, self.size.width, self.size.height)
        CGContextAddEllipseInRect(ctx, rect)
        
        CGContextClip(ctx)
        self.drawInRect(rect)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
    
}

// String扩展
extension String {
    // 判断是否是邮箱
    func validateEmail() -> Bool {
        let emailRegex: String = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest: NSPredicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluateWithObject(self)
    }
    
    // 判断是否是手机号
    func validateMobile() -> Bool {
        let phoneRegex: String = "^((13[0-9])|(15[^4,\\D])|(18[0,0-9])|(17[0,0-9]))\\d{8}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluateWithObject(self)
    }
    
}


