//
//  MeViewController.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/14.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  这种cell最好用stroyboard的静态单元格来描述

import UIKit

public let SD_UserIconData_Path = theme.cachesPath + "/iconImage.data"

enum SDMineCellType: Int {
    /// 个人中心
    case MyCenter = 0
    /// 我的订单
    case MyOrder = 1
    /// 我的收藏
    case MyCollect = 2
    ///  反馈留言
    case Feedback = 3
    ///  应用推荐
    case RecommendApp = 4
}

class MeViewController: MainViewController {
    private var loginLabel: UILabel!
    private var tableView: UITableView!
    private lazy var pickVC: UIImagePickerController = {
        let pickVC = UIImagePickerController()
        pickVC.delegate = self
        pickVC.allowsEditing = true
        return pickVC
        }()
    private lazy var mineIcons: NSMutableArray = NSMutableArray(array: ["usercenter", "orders", "setting_like", "feedback", "recomment"])
    
    private lazy var iconActionSheet: UIActionSheet = UIActionSheet(title: nil, delegate: self, cancelButtonTitle: "取消", destructiveButtonTitle: nil, otherButtonTitles: "拍照", "从手机相册选择")
    
    private lazy var mineTitles: NSMutableArray = NSMutableArray(array: ["个人中心", "我的订单", "我的收藏", "留言反馈", "应用推荐"])
    private var iconView: IconView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 初始化导航条上的内容
        setNav()
        
        // 设置tableView
        setTableView()
    }
    
    private func setNav() {
        navigationItem.title = "我的"
        navigationItem.leftBarButtonItem = nil
        navigationItem.rightBarButtonItem = UIBarButtonItem(imageName: "settinghhhh", highlImageName: "settingh", targer: self, action: "settingClick")
    }
    
    private func setTableView() {
        self.automaticallyAdjustsScrollViewInsets = false
        
        tableView = UITableView(frame: CGRectMake(0, 0, AppWidth, AppHeight - NavigationH - 49), style: UITableViewStyle.Grouped)
        tableView.backgroundColor = UIColor.colorWith(245, green: 245, blue: 245, alpha: 1)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 45
        tableView.sectionFooterHeight = 0.1
        tableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        view.addSubview(tableView)
        
        // 设置tableView的headerView
        let iconImageViewHeight: CGFloat = 180
        let iconImageView = UIImageView(frame: CGRectMake(0, 0, AppWidth, iconImageViewHeight))
        iconImageView.image = UIImage(named: "quesheng")
        iconImageView.userInteractionEnabled = true
        
        // 添加未登录的文字
        let loginLabelHeight: CGFloat = 40
        loginLabel = UILabel(frame: CGRectMake(0, iconImageViewHeight - loginLabelHeight, AppWidth, loginLabelHeight))
        loginLabel.textAlignment = .Center
        loginLabel.text = "登陆,开始我的小日子"
        loginLabel.font = UIFont.systemFontOfSize(16)
        loginLabel.textColor = UIColor.colorWith(80, green: 80, blue: 80, alpha: 1)
        iconImageView.addSubview(loginLabel)
        
        // 添加iconImageView
        iconView = IconView(frame: CGRectMake(0, 0, 100, 100))
        iconView!.delegate = self
        iconView!.center = CGPointMake(iconImageView.width * 0.5, (iconImageViewHeight - loginLabelHeight) * 0.5 + 8)
        iconImageView.addSubview(iconView!)
        
        tableView.tableHeaderView = iconImageView
    }
    
    func settingClick() {
        let settingVC = SettingViewController()
        navigationController?.pushViewController(settingVC, animated: true)
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        loginLabel.hidden = UserAccountTool.userIsLogin()
        if UserAccountTool.userIsLogin() {
            if let data = NSData(contentsOfFile: SD_UserIconData_Path) {
                iconView!.iconButton.setImage(UIImage(data: data)!.imageClipOvalImage(), forState: .Normal)
            } else {
                iconView!.iconButton.setImage(UIImage(named: "my"), forState: .Normal)
            }
        } else {
            iconView!.iconButton.setImage(UIImage(named: "my"), forState: .Normal)
        }
    }
}

/// MARK: iconViewDelegate
extension MeViewController: IconViewDelegate {
    func iconView(iconView: IconView, didClick iconButton: UIButton) {
        // TODO 判断用户是否登录了
        if UserAccountTool.userIsLogin() {
            iconActionSheet.showInView(view)
        } else {
            let login = LoginViewController()
            navigationController?.pushViewController(login, animated: true)
        }
    }
}

/// MARK: UIActionSheetDelegate
extension MeViewController: UIActionSheetDelegate {
    
    func actionSheet(actionSheet: UIActionSheet, clickedButtonAtIndex buttonIndex: Int) {
        print(buttonIndex, terminator: "")
        switch buttonIndex {
        case 1:
            openCamera()
        case 2:
            openUserPhotoLibrary()
        default:
            print("", terminator: "")
        }
    }
    
}

/// MARK: 摄像机和相册的操作和代理方法
extension MeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    /// 打开照相功能
    private func openCamera() {
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            pickVC.sourceType = .Camera
            self.presentViewController(pickVC, animated: true, completion: nil)
        } else {
            SVProgressHUD.showErrorWithStatus("模拟器没有摄像头,请链接真机调试", maskType: SVProgressHUDMaskType.Black)
        }
    }
    
    /// 打开相册
    private func openUserPhotoLibrary() {
        pickVC.sourceType = .PhotoLibrary
        pickVC.allowsEditing = true
        presentViewController(pickVC, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // 对用户选着的图片进行质量压缩,上传服务器,本地持久化存储
        if let typeStr = info[UIImagePickerControllerMediaType] as? String {
            if typeStr == "public.image" {
                if let image = info[UIImagePickerControllerEditedImage] as? UIImage {
                    var data: NSData?
                    let smallImage = UIImage.imageClipToNewImage(image, newSize: iconView!.iconButton.size)
                    if UIImagePNGRepresentation(smallImage) == nil {
                        data = UIImageJPEGRepresentation(smallImage, 0.8)
                    } else {
                        data = UIImagePNGRepresentation(smallImage)
                    }
                    
                    if data != nil {
                        do {
                            // TODO: 将头像的data传入服务器
                            // 本地也保留一份data数据
                            try NSFileManager.defaultManager().createDirectoryAtPath(theme.cachesPath, withIntermediateDirectories: true, attributes: nil)
                        } catch _ {
                        }
                        NSFileManager.defaultManager().createFileAtPath(SD_UserIconData_Path, contents: data, attributes: nil)
                        
                        iconView!.iconButton.setImage(UIImage(data: NSData(contentsOfFile: SD_UserIconData_Path)!)!.imageClipOvalImage(), forState: .Normal)
                        
                    } else {
                        SVProgressHUD.showErrorWithStatus("照片保存失败", maskType: SVProgressHUDMaskType.Black)
                    }
                }
            }
        } else {
            SVProgressHUD.showErrorWithStatus("图片无法获取", maskType: SVProgressHUDMaskType.Black)
        }
        
        picker.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        pickVC.dismissViewControllerAnimated(true, completion: nil)
    }
}

/// MARK:UITableViewDelegate, UITableViewDataSource 代理方法
extension MeViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return mineIcons.count
        } else {
            return 1
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier: String = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: .Default, reuseIdentifier: identifier)
            cell!.accessoryType = UITableViewCellAccessoryType.DisclosureIndicator
            cell!.selectionStyle = .None
        }
        if indexPath.section == 0 {
            cell!.imageView!.image = UIImage(named: mineIcons[indexPath.row] as! String)
            cell!.textLabel?.text = mineTitles[indexPath.row] as? String
        } else {
            cell!.imageView!.image = UIImage(named: "yaoyiyao")
            cell!.textLabel!.text = "摇一摇 每天都有小惊喜"
        }
        
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 0 {
            
            if indexPath.row == SDMineCellType.Feedback.hashValue {         // 留言反馈
                let feedbackVC = FeedbackViewController()
                navigationController?.pushViewController(feedbackVC, animated: true)
            } else if indexPath.row == SDMineCellType.MyCenter.hashValue {  // 个人中心
                if UserAccountTool.userIsLogin() {
                    let myCenterVC = MyCenterViewController()
                    navigationController!.pushViewController(myCenterVC, animated: true)
                } else {
                    let login = LoginViewController()
                    navigationController?.pushViewController(login, animated: true)
                }
                
            } else if indexPath.row == SDMineCellType.MyCollect.hashValue { // 我的收藏
                
            } else if indexPath.row == SDMineCellType.MyOrder.hashValue {   // 我的订单
                if UserAccountTool.userIsLogin() {
                    let orderVC = OrderViewController()
                    navigationController!.pushViewController(orderVC, animated: true)
                } else {
                    let login = LoginViewController()
                    navigationController?.pushViewController(login, animated: true)
                }
            } else {                                                        // 应用推荐
                let rmdVC = RecommendViewController()
                navigationController!.pushViewController(rmdVC, animated: true)
            }
            
        } else {
            let shakeVC = ShakeViewController()
            navigationController?.pushViewController(shakeVC, animated: true)
        }
    }
    
}


