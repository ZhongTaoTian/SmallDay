//
//  SignUpViewController.swift
//  SmallDay
//
//  Created by MacBook on 15/8/28.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  报名ViewController

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var submitBtn: UIButton!
    @IBOutlet weak var codeTextField: UITextField!
    @IBOutlet weak var sendCodeBtn: UIButton!
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var remarkTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    var topTitle: String?
    
    var second: Int = 60
    
    var timer: NSTimer?
    
    init() {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(nibName: "SignUpViewController", bundle: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        print("报名控制器被销毁")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "报名"
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillChangeFrame:", name: UIKeyboardWillChangeFrameNotification, object: nil)
        
        // 从XIB中加载后的初始化
        setUpXIB()
        
    }
    
    /// 键盘frame即将改变
    func keyboardWillChangeFrame(noti: NSNotification) {
        var fristTF:UITextField?
        if nameTextField.isFirstResponder() {
            fristTF = nameTextField
        } else if phoneNumTextField.isFirstResponder() {
            fristTF = phoneNumTextField
        } else if codeTextField.isFirstResponder() {
            fristTF = codeTextField
        }
        
        if let userInfo = noti.userInfo {
            let newF = userInfo[UIKeyboardFrameEndUserInfoKey]!.CGRectValue()
            let boardH = AppHeight - newF.origin.y
            let animDuration = userInfo[UIKeyboardAnimationDurationUserInfoKey]! as! Double
            if fristTF != nil && boardH != 0 {
                let maxY = CGRectGetMaxY(fristTF!.frame) + CGRectGetMinY(fristTF!.superview!.frame) + NavigationH
                let offsetY = boardH + maxY - AppHeight
                UIView.animateWithDuration(animDuration, animations: { () -> Void in
                    self.scrollView.contentOffset = CGPointMake(0, self.positiveNumber(offsetY))
                })
            } else {
                UIView.animateWithDuration(animDuration, animations: { () -> Void in
                    self.scrollView.contentOffset = CGPointMake(0, 0)
                })
            }
        }
    }
    
    private func setUpXIB() {
        scrollView.alwaysBounceVertical = true
        let tap = UITapGestureRecognizer(target: self, action: "scrollViewClick")
        scrollView.addGestureRecognizer(tap)
        scrollView.keyboardDismissMode = .OnDrag
        //        remarkTextField.autocorrectionType = .No
        //        nameTextField.autocorrectionType = .No
        titleLabel.text = topTitle
        sendCodeBtn.addTarget(self, action: "sendCodeBtnClick:", forControlEvents: .TouchUpInside)
    }
    
    func scrollViewClick() {
        view.endEditing(true)
    }
    
    func positiveNumber(num: CGFloat) -> CGFloat {
        return num >= 0 ? num : -num
    }
    
    /// 发送验证码
    func sendCodeBtnClick(sender: UIButton) {
        if phoneNumTextField.text.validateMobile() {
            sendCodeBtn.enabled = false
            self.timer = NSTimer(timeInterval: 1.0, target: self, selector: "changeBtn", userInfo: nil, repeats: true)
            NSRunLoop.mainRunLoop().addTimer(timer!, forMode: NSRunLoopCommonModes)
            timer!.fire()
            codeTextField.becomeFirstResponder()
        } else {
            SVProgressHUD.showErrorWithStatus("请输入正确的手机号")
        }
    }
    
    func changeBtn() {
        sendCodeBtn.setTitle("已发送\(second)秒", forState: .Disabled)
        second--
        if second == 0 {
            sendCodeBtn.enabled = true
            timer!.invalidate()
            self.timer = nil
            second = 60
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        if self.timer != nil {
            self.timer!.invalidate()
            self.timer = nil
        }
        
        super.viewWillDisappear(animated)
    }
}
