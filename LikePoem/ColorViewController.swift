//
//  ColorViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/5.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit

class ColorViewController: UITableViewController {
    
    let colorList = [0xFFFFFF, 0xB5484A, 0x9AC2B2, 0x82674D, 0x8B9361]
    
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
        return 80.0
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
        
        if indexPath.row == 0 {
            defaults.setInteger(colorList[0], forKey: "backColor")
            defaults.setInteger(0x000000, forKey: "textColor")
        } else if indexPath.row == 1 {
            defaults.setInteger(colorList[1], forKey: "backColor")
            defaults.setInteger(0xffffff, forKey: "textColor")
        } else if indexPath.row == 2 {
            defaults.setInteger(colorList[2], forKey: "backColor")
            defaults.setInteger(0xffffff, forKey: "textColor")
        } else if indexPath.row == 3 {
            defaults.setInteger(colorList[3], forKey: "backColor")
            defaults.setInteger(0xffffff, forKey: "textColor")
        } else if indexPath.row == 4 {
            defaults.setInteger(colorList[4], forKey: "backColor")
            defaults.setInteger(0xffffff, forKey: "textColor")
        }
        
        defaults.setInteger(indexPath.row, forKey: "checkIndex")
        
    }


    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
