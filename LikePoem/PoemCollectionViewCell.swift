//
//  PoemCollectionViewCell.swift
//  LikePoem
//
//  Created by wyatt on 16/3/1.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit

class PoemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var poemTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        // 关键参数，允许边界面显示阴影
        self.layer.masksToBounds = false
        
        self.layer.shadowColor = UIColor.blackColor().CGColor
        
        // 阴影偏移
        self.layer.shadowOffset = CGSizeMake(0, 0)
        
        // 阴影半径
        self.layer.shadowRadius = 2
        self.layer.shadowOpacity = 0.20
    }

}
