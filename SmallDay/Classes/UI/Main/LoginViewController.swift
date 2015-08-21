//
//  LoginViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/20.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  登陆控制器

import UIKit

class LoginViewController: UIViewController, UIScrollViewDelegate {
    
    var bottomView: UIView!
    var backScrollView: UIScrollView!
    var topView: UIView!
    var phoneTextField: UITextField!
    var psdTextField: UITextField!
    var loginImageView: UIImageView!
    var quickLoginBtn: UIButton!
    var forgetPwdImageView: UIImageView!
    var registerImageView: UIImageView!
    let textCoclor: UIColor = UIColor.colorWith(50, green: 50, blue: 50, alpha: 1)
    let loginW: CGFloat = 250
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "登录"
        view.backgroundColor = theme.SDBackgroundColor
        //添加scrollView
        addScrollView()
        // 添加手机文本框和密码文本框
        addTextField()
        // 添加登录View
        addLoginImageView()
        // 添加快捷登录按钮
        addQuictLoginBtn()
        // 添加底部忘记密码和注册view
        addBottomView()
        // 添加键盘通知
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrameNotification:", name: UIKeyboardWillChangeFrameNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func addScrollView() {
        backScrollView = UIScrollView(frame: view.bounds)
        backScrollView.backgroundColor = theme.SDBackgroundColor
        backScrollView.alwaysBounceVertical = true
        let tap = UITapGestureRecognizer(target: self, action: "backScrollViewTap")
        backScrollView.addGestureRecognizer(tap)
        view.addSubview(backScrollView)
    }
    
    func addLoginImageView() {
        let loginH: CGFloat = 50
        loginImageView = UIImageView(frame: CGRectMake((theme.appWidth - loginW) * 0.5, CGRectGetMaxY(topView!.frame) + 10, loginW, loginH))
        loginImageView.userInteractionEnabled = true
        loginImageView.image = UIImage(named: "signin_1")
        
        let loginLabel = UILabel(frame: loginImageView.bounds)
        loginLabel.text = "登  录"
        loginLabel.textAlignment = .Center
        loginLabel.textColor = textCoclor
        loginLabel.font = UIFont.systemFontOfSize(22)
        loginImageView.addSubview(loginLabel)
        
        let tap = UITapGestureRecognizer(target: self, action: "loginClick")
        loginImageView.addGestureRecognizer(tap)
        
        backScrollView.addSubview(loginImageView)
    }
    
    func addTextField() {
        let textH: CGFloat = 55
        let leftMargin: CGFloat = 10
        let alphaV: CGFloat = 0.2
        topView = UIView(frame: CGRectMake(0, 20, theme.appWidth, textH * 2))
        topView?.backgroundColor = UIColor.whiteColor()
        backScrollView.addSubview(topView!)
        
        let line1 = UIView(frame: CGRectMake(0, 0, theme.appWidth, 1))
        line1.backgroundColor = UIColor.grayColor()
        line1.alpha = alphaV
        topView!.addSubview(line1)
        
        phoneTextField = UITextField()
        phoneTextField?.keyboardType = UIKeyboardType.NumberPad
        addTextFieldToTopViewWiht(phoneTextField!, frame: CGRectMake(leftMargin, 1, theme.appWidth - leftMargin, textH - 1), placeholder: "请输入手机号")
        
        let line2 = UIView(frame: CGRectMake(0, textH, theme.appWidth, 1))
        line2.backgroundColor = UIColor.grayColor()
        line2.alpha = alphaV
        topView!.addSubview(line2)
        
        psdTextField = UITextField()
        addTextFieldToTopViewWiht(psdTextField!, frame: CGRectMake(leftMargin, textH + 1, theme.appWidth - leftMargin, textH - 1), placeholder: "密码")
    }
    
    func addQuictLoginBtn() {
        quickLoginBtn = UIButton()
        quickLoginBtn.setTitle("无账号快捷登录", forState: .Normal)
        quickLoginBtn.titleLabel?.sizeToFit()
        quickLoginBtn.contentMode = .Right
        let quickW: CGFloat = quickLoginBtn.titleLabel!.width
        quickLoginBtn.frame = CGRectMake(theme.appWidth - quickW - 10, CGRectGetMaxY(loginImageView.frame) + 10, quickW, 30)
        quickLoginBtn.titleLabel?.font = UIFont.systemFontOfSize(14)
        quickLoginBtn.addTarget(self, action: "quickLoginClick", forControlEvents: .TouchUpInside)
        quickLoginBtn.setTitle("无账号快捷登录", forState: .Normal)
        quickLoginBtn.setTitleColor(textCoclor, forState: .Normal)
        quickLoginBtn.setTitleColor(UIColor.lightGrayColor(), forState: .Highlighted)
        backScrollView.addSubview(quickLoginBtn)
    }
    
    func addTextFieldToTopViewWiht(textField: UITextField ,frame: CGRect, placeholder: String) {
        textField.frame = frame
        textField.autocorrectionType = UITextAutocorrectionType.No
        textField.clearButtonMode = UITextFieldViewMode.Always
        textField.backgroundColor = UIColor.whiteColor()
        textField.placeholder = placeholder
        topView!.addSubview(textField)
    }
    
    func addBottomView() {
        let forgetPwdImageViewH: CGFloat = 45
        
        bottomView = UIView(frame: CGRectMake((theme.appWidth - loginW) * 0.5, theme.appHeight - forgetPwdImageViewH - 10 - 64, loginW, forgetPwdImageViewH))
        bottomView.backgroundColor = UIColor.clearColor()
        backScrollView.addSubview(bottomView)
        
        forgetPwdImageView = UIImageView()
        addBottomViewWithImageView(forgetPwdImageView, tag: 10, frame: CGRectMake(0, 0, loginW * 0.5, forgetPwdImageViewH), imageName: "c1_1", title: "忘记密码")
        
        registerImageView = UIImageView()
        addBottomViewWithImageView(registerImageView, tag: 11, frame: CGRectMake(bottomView.width * 0.5, 0, loginW * 0.5, forgetPwdImageViewH), imageName: "c1_2", title: "注册")
    }
    
    func addBottomViewWithImageView(imageView: UIImageView, tag: Int, frame: CGRect, imageName: String, title: String) {
        imageView.frame = frame
        imageView.image = UIImage(named: imageName)
        imageView.tag = tag
        imageView.userInteractionEnabled = true
        
        let label = UILabel(frame: CGRectMake(0, 0, imageView.width, imageView.height))
        label.textAlignment = .Center
        label.textColor = textCoclor
        label.text = title
        label.font = UIFont.systemFontOfSize(15)
        imageView.addSubview(label)
        let tap = UITapGestureRecognizer(target: self, action: "bottomViewColcikWith:")
        imageView.addGestureRecognizer(tap)
        
        bottomView.addSubview(imageView)
        
    }
    
    /// 底部忘记密码和注册按钮点击
    func bottomViewColcikWith(tap: UIGestureRecognizer) {
        if tap.view!.tag == 10 { // 忘记密码
            print("忘记密码")
        } else {                 // 注册
            print("注册")
        }
    }
    
    /// 登录按钮被点击
    func loginClick() {
        print("登陆")
    }
    
    /// 快捷登录点击
    func quickLoginClick() {
        print("快捷登陆")
    }
    
    func keyboardWillChangeFrameNotification(note: NSNotification) {
        // TODO 添加键盘弹出的事件
        let userinfo = note.userInfo!
        let rect = userinfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
        var boardH = theme.appHeight - rect.origin.y
        if boardH > 0 {
            boardH = boardH + 64
        }
        backScrollView.contentSize = CGSizeMake(0, view.height + boardH)
    }
    
    func backScrollViewTap() {
        view.endEditing(true)
    }
}
