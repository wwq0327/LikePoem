//
//  FontViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/5.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit

class FontViewController: UITableViewController {
    

    
    let fontList = [FontID.FontFamily.Songkeben.rawValue, FontID.FontFamily.Pingfang.rawValue, FontID.FontFamily.Kaiti.rawValue,FontID.FontFamily.Fangsong.rawValue,FontID.FontFamily.Wenyue.rawValue, FontID.FontFamily.Zhao.rawValue]
    
    var defaults = NSUserDefaults.standardUserDefaults()
    var checkedIndexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fontList.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath)
        cell.textLabel?.text = "美好的文字岂可辜负？ -- 记诗。"
        cell.textLabel?.font = UIFont(name: fontList[indexPath.row], size: 16)
        
        if indexPath.row == defaults.integerForKey("checkIndex") {
            cell.accessoryType = .Checkmark
            checkedIndexPath = indexPath
        }
        
        return cell
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
            defaults.setValue(FontID.FontFamily.Songkeben.rawValue, forKey: FontID.fontName)
        } else if indexPath.row == 1 {
            defaults.setValue(FontID.FontFamily.Pingfang.rawValue, forKey: FontID.fontName)
        } else if indexPath.row == 2 {
            defaults.setValue(FontID.FontFamily.Kaiti.rawValue, forKey: FontID.fontName)
        } else if indexPath.row == 3 {
            defaults.setValue(FontID.FontFamily.Fangsong.rawValue, forKey: FontID.fontName)
        } else if indexPath.row == 4 {
            defaults.setValue(FontID.FontFamily.Wenyue.rawValue, forKey: FontID.fontName)
        } else if indexPath.row == 5 {
            defaults.setValue(FontID.FontFamily.Zhao.rawValue, forKey: FontID.fontName)
        }
        
        defaults.setInteger(indexPath.row, forKey: "checkIndex")
    }
    
    
    
}
