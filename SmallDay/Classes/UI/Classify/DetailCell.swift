//
//  DetailCell.swift
//  SmallDay
//
//  Created by MacBook on 15/8/25.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  分类详情cell

import UIKit

class DetailCell: UITableViewCell {
    
    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var subTitleLabel: UILabel!
    @IBOutlet weak private var backImageView: UIImageView!
    
    var model: EventModel? {
        didSet {
            titleLabel.text = model!.title
            subTitleLabel.text = model!.address
            
            if let imsStr = model?.imgs?.last {
                backImageView.kf_setImageWithURL(NSURL(string: imsStr)!, placeholderImage: UIImage(named: "quesheng"))
            }
        }
    }
    
    override func awakeFromNib() {
        self.selectionStyle = .None
    }

}
