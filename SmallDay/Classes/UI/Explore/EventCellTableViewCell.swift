//
//  EventCellTableViewCell.swift
//  SmallDay
//
//  Created by MacBook on 15/8/23.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class EventCellTableViewCell: UITableViewCell {

    var eventModel: EventModel? {
        didSet {
            
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
        
    }
    
}
