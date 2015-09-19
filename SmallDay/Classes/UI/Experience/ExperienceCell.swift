//
//  ExperienceCell.swift
//  SmallDay
//
//  Created by MacBook on 15/8/27.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  体验TableView的Cell

import UIKit

class ExperienceCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    
    var eventModel: EventModel? {
        didSet {
            titleLabel.text = eventModel!.title
            
            if eventModel!.imgs?.count > 0 {
                let urlStr = eventModel!.imgs![0]
                imageImageView.wxn_setImageWithURL(NSURL(string: urlStr)!, placeholderImage: UIImage(named: "quesheng")!)
            }
        }
    }
}
