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
    
    @IBOutlet weak var scrollView: UIScrollView!
    var poemTextLabel: myUILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor().colorWithAlphaComponent(0))
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        poemTextLabel = PoeLabel(fontname: "FZSKBXKJW--GB1-0", labelText: poemText, fontSize: 18, lineHeight: 14)
        
        scrollView.addSubview(poemTextLabel)
        
        var labelSize = CGSizeZero
        if poemTextLabel.bounds.height < UIScreen.mainScreen().bounds.height {
            labelSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height )
        } else {
            labelSize = CGSizeMake(poemTextLabel.frame.size.width, poemTextLabel.frame.size.height )
            
        }
        
        self.scrollView.contentSize = labelSize
        
        
        // 添加手势
//        let swipeGesture = UISwipeGestureRecognizer(target: self, action: "handleSwipes:")
//        swipeGesture.direction = .Down
//        view.addGestureRecognizer(swipeGesture)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func handleSwipes(sender: UISwipeGestureRecognizer) {
        if sender.direction == .Down {
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    @IBAction func backClicked(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
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
