//
//  ColorViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/5.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit

class ColorViewController: UITableViewController {
    
    let colorList = [0xFFFFFF, 0xD3BFA0, 0x957A5F, 0xC45E5C, 0xE7B7AD, 0xFBD380, 0x9CA374, 0xA9CCBF, 0x81758D]
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var checkedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let nib = UINib(nibName: "ColorViewCell", bundle: nil)
        self.tableView.registerNib(nib, forCellReuseIdentifier: "colorCell")
        
        self.tableView.separatorStyle = .SingleLineEtched
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return colorList.count
    }


    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("colorCell", forIndexPath: indexPath) as! ColorViewCell
        
        cell.backView.backgroundColor = UIColor(hex: colorList[indexPath.row])
        if indexPath.row != 0 {
            cell.colorTextLabel.textColor = UIColor.whiteColor()
        }
        
        if indexPath.row == defaults.integerForKey("checkIndex") {
            cell.accessoryType = .Checkmark
            checkedIndexPath = indexPath
        }

        return cell
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 64.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // checkIndexPath 有值，代表的是上一次的选择，而本次选择时，则需要先清除掉上一次选择标记
        if (self.checkedIndexPath != nil) {
            let cell = tableView.cellForRowAtIndexPath(self.checkedIndexPath!)
            cell?.accessoryType = .None
        }
        
        // 标记当前选择项，标记成功之后，将值传给 checkIndexPath 记录下来，作为下次选择的提前值
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        cell?.accessoryType = .Checkmark
        self.checkedIndexPath = indexPath
        
        defaults.setInteger(colorList[indexPath.row], forKey: "backColor")
        if indexPath.row == 0 {
            defaults.setInteger(0x000000, forKey: "textColor")
        } else {
            defaults.setInteger(0xffffff, forKey: "textColor")
        }
        
//        if indexPath.row == 0 {
//            defaults.setInteger(colorList[0], forKey: "backColor")
//            defaults.setInteger(0x000000, forKey: "textColor")
//        } else if indexPath.row == 1 {
//            defaults.setInteger(colorList[1], forKey: "backColor")
//            defaults.setInteger(0xffffff, forKey: "textColor")
//        } else if indexPath.row == 2 {
//            defaults.setInteger(colorList[2], forKey: "backColor")
//            defaults.setInteger(0xffffff, forKey: "textColor")
//        } else if indexPath.row == 3 {
//            defaults.setInteger(colorList[3], forKey: "backColor")
//            defaults.setInteger(0xffffff, forKey: "textColor")
//        } else if indexPath.row == 4 {
//            defaults.setInteger(colorList[4], forKey: "backColor")
//            defaults.setInteger(0xffffff, forKey: "textColor")
//        }
        
        defaults.setInteger(indexPath.row, forKey: "checkIndex")
        
    }

}
