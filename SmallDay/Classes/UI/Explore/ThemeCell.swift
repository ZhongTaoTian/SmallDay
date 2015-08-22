//
//  ThemeCell.swift
//  SmallDay
//
//  Created by MacBook on 15/8/22.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class ThemeCell: UITableViewCell {

    var model: ThemeModel? {
        didSet {
            self.titleLable.text = model!.title
            self.subTitleLable.text = model!.keywords
//            self.backImageView.image = 
        }
    }
    
    @IBOutlet weak var titleLable: UILabel!
    @IBOutlet weak var subTitleLable: UILabel!
    @IBOutlet weak var backImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
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
