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
        
//        aboutLabel = PoeLabel(fontname: FontID.FontFamily.Songkeben.rawValue, labelText: aboutLabel.text!, fontSize: 18, lineHeight: 8)
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
