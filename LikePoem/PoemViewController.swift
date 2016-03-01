//
//  PoemViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/1.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit

class PoemViewController: UIViewController {

    var poemText: String!
    
    @IBOutlet weak var poemTextLabel: myUILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        poemTextLabel.text = poemText
        
        poemTextLabel.font = UIFont(name: "FZSKBXKJW--GB1-0", size: 20)
        poemTextLabel.setLineHeight(1.6)
        poemTextLabel.textAlignment = .Center
        poemTextLabel.verticalAlignment = VerticalAlignmentMiddle
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
