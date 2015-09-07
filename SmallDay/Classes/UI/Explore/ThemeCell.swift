//
//  ThemeCell.swift
//  SmallDay
//
//  Created by MacBook on 15/8/22.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探店美辑的cell

import UIKit

class ThemeCell: UITableViewCell {
    
    var model: ThemeModel? {
        didSet {
            self.titleLable.text = model!.title
            self.subTitleLable.text = model!.keywords
            //TODO: 封装一层自己的图片工具  隔离于三方库的依赖
            self.backImageView.kf_setImageWithURL(NSURL(string: model!.img!)!, placeholderImage: UIImage(named: "quesheng"), optionsInfo: [.Options: KingfisherOptions.BackgroundCallback]) { (image, error, cacheType, imageURL) -> () in
            }
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLable: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        self.titleLable.shadowOffset = CGSizeMake(-1, 1)
        self.titleLable.shadowColor = UIColor.colorWith(20, green: 20, blue: 20, alpha: 0.1)
        self.subTitleLable.shadowOffset = CGSizeMake(-1, 1)
        self.subTitleLable.shadowColor = UIColor.colorWith(20, green: 20, blue: 20, alpha: 0.1)
    }
    
    class func themeCellWithTableView(tableView: UITableView) -> ThemeCell {
        let identifier = "themeCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? ThemeCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("ThemeCell", owner: nil, options: nil).last as? ThemeCell
            
        }
        
        return cell!
    }
}
