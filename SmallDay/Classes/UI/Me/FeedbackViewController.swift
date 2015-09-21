//
//  FeedbackViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/20.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  用户反馈ViewController

import UIKit

class FeedbackViewController: UIViewController, UITextFieldDelegate {
    /// 反馈留言TextView
    private var feedbackTextView: UITextView!
    /// 联系方式textField
    private var contactTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 设置导航条上的内容
        setNav()
        
        view.backgroundColor = theme.SDWebViewBacagroundColor
        // 设置留言框和联系框
        setFeedbackTextViewAndContactTextField()
    }
    
    private func setNav() {
        self.navigationItem.title = "留言反馈"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "发送", style: UIBarButtonItemStyle.Done, target: self, action: "sendClick")
    }
    
    private func setFeedbackTextViewAndContactTextField() {
        let backView = UIView(frame: CGRectMake(0, 5, AppWidth, 130))
        backView.backgroundColor = theme.SDBackgroundColor
        feedbackTextView = UITextView(frame: CGRectMake(5, 0, AppWidth - 10, 130))
        feedbackTextView.backgroundColor = theme.SDBackgroundColor
        feedbackTextView.font = UIFont.systemFontOfSize(20)
        feedbackTextView.allowsEditingTextAttributes = true
        feedbackTextView.autocorrectionType = UITextAutocorrectionType.No
        backView.addSubview(feedbackTextView!)
        view.addSubview(backView)
        
        contactTextField = UITextField(frame: CGRectMake(0, CGRectGetMaxY(feedbackTextView.frame) + 10, AppWidth, 50))
        contactTextField.clearButtonMode = UITextFieldViewMode.Always
        contactTextField.backgroundColor = theme.SDBackgroundColor
        contactTextField.font = UIFont.systemFontOfSize(18)
        let leffView = UIView(frame: CGRectMake(0, 0, 10, 20))
        contactTextField.leftView = leffView
        contactTextField.leftViewMode = UITextFieldViewMode.Always
        contactTextField.placeholder = "留下邮箱或电话,以方便我们给你回复"
        contactTextField.autocorrectionType = UITextAutocorrectionType.No
        contactTextField.delegate = self
        view.addSubview(contactTextField)
    }
    
    func sendClick() {
        let contactStr = contactTextField.text
        var alartView: UIAlertView?
        
        if feedbackTextView.text.isEmpty {
            alartView = UIAlertView(title: "提示", message: "请填写您的留言反馈", delegate: nil, cancelButtonTitle: "确定")
            alartView?.show()
            return
        }
        
        if contactStr!.validateEmail() || contactStr!.validateMobile() {
            // TODO 将用户反馈和联系方式发送给服务器
            alartView = UIAlertView(title: "提示", message: "感谢您的反馈", delegate: nil, cancelButtonTitle: "确定")
            alartView?.show()
            self.navigationController?.popViewControllerAnimated(true)
            return
        } else {
            alartView = UIAlertView(title: "提示", message: "请填写正确的联系方式,以便我们给您回复", delegate: nil, cancelButtonTitle: "确定")
            alartView?.show()
        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        feedbackTextView.becomeFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        sendClick()
        return true
    }
    
    deinit {
        print("反馈留言ViewController被销毁了", terminator: "")
    }
}


