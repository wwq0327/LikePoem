//
//  AboutViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/5.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var aboutLabel: myUILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = imageView.bounds.width /  2
        
        aboutLabel.font = UIFont(name: FontID.FontFamily.Fangsong.rawValue, size: 18)
        aboutLabel.verticalAlignment = VerticalAlignmentTop
        aboutLabel.setLineHeight(1.8)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
