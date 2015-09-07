//
//  ClassifyCell.swift
//  SmallDay
//
//  Created by MacBook on 15/8/18.
//  Copyright (c) 2015年 维尼的小熊. All rights reserved.
//

import UIKit

class ClassifyCell: UICollectionViewCell {

    @IBOutlet weak private var titleLabel: UILabel!
    @IBOutlet weak private var classifyImageView: UIImageView!
    var model:EveryClassModel? {
        didSet {
            titleLabel.text = model!.name
            classifyImageView.kf_setImageWithURL(NSURL(string: model!.img!)!, placeholderImage: UIImage(named: "quesheng"))
        }
    }

}
