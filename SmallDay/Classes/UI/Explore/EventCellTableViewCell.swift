//
//  EventCellTableViewCell.swift
//  SmallDay
//  项目GitHub地址:         https://github.com/ZhongTaoTian/SmallDay
//  项目思路和架构讲解博客:    http://www.jianshu.com/p/bcc297e19a94
//  Created by MacBook on 15/8/23.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//  探店每天的自定义cell

import UIKit

class EventCellTableViewCell: UITableViewCell {

    var eventModel: EveryDay? {
        didSet {
            cellTileLabel.text = eventModel!.events?.last?.feeltitle
            titleLabel.text = eventModel!.events?.last?.title
            subTltleLabel.text = eventModel!.events?.last?.address
            dayLabel.text = eventModel?.day
            monthLabel.text = eventModel?.month
            if let imageURL = NSURL(string: eventModel!.events!.last!.imgs!.last!) {
                imageImageView.wxn_setImageWithURL(imageURL, placeholderImage: UIImage(named: "quesheng")!)
            }
        }
    }
    
    @IBOutlet weak var cellTileLabel: UILabel!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTltleLabel: UILabel!
    @IBOutlet weak var imageImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .None
        
    }
    
    class func eventCell(tableView: UITableView) -> EventCellTableViewCell {
        let identifier = "eventCell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(identifier) as? EventCellTableViewCell
        if cell == nil {
            cell = NSBundle.mainBundle().loadNibNamed("EventCellTableViewCell", owner: nil, options: nil).last as? EventCellTableViewCell
        }
        
        return cell!
    }
    
}
