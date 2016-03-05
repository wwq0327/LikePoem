//
//  PoemViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/3.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit
import RealmSwift

private let realm = try! Realm()

class PoemViewController: UIViewController {
    
    var poem: Poem!
    var titleTextLabel: UILabel!
    var authorTextLabel: UILabel!
    var poemTextLabel: myUILabel!
    
    var fontName: String!
    var backColor: Int!
    var textColor: Int!

    @IBOutlet weak var scrollView: UIScrollView!
    var y: CGFloat = 0
    
    
    var defaults = NSUserDefaults.standardUserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        if  defaults.stringForKey(FontID.fontName) == nil {
            fontName = FontID.FontFamily.Songkeben.rawValue
        } else {
            fontName = defaults.stringForKey(FontID.fontName)
        }
        
        if defaults.integerForKey("backColor") == 0 {
            backColor = 0xffffff
        } else {
            backColor = defaults.integerForKey("backColor")
        }
        
        if defaults.integerForKey("textColor") == 0 {
            textColor = 0x000000
        } else {
            textColor = defaults.integerForKey("textColor")
        }
        
        view.backgroundColor = UIColor(hex: backColor)
        
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor().colorWithAlphaComponent(0))
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // title
        titleTextLabel = UILabel(frame: CGRectMake(0, y, UIScreen.mainScreen().bounds.width, 24))
        titleTextLabel.textAlignment = .Center
        titleTextLabel.textColor = UIColor(hex: textColor)
        titleTextLabel.text = poem.title
        titleTextLabel.font = UIFont(name: fontName, size: 24)
        scrollView.addSubview(titleTextLabel)
        y += titleTextLabel.bounds.size.height + 10
        
        // author
        authorTextLabel = UILabel(frame: CGRectMake(0, y, UIScreen.mainScreen().bounds.width, 24))
        authorTextLabel.textAlignment = .Center
        authorTextLabel.textColor = UIColor(hex: textColor)
        authorTextLabel.text = poem.author
        authorTextLabel.font = UIFont(name: fontName, size: 16)
        scrollView.addSubview(authorTextLabel)
        y += authorTextLabel.bounds.size.height + 10
        
        // content
        let fontSize = defaults.integerForKey(FontID.fontSize)
        poemTextLabel = PoeLabel(fontname: fontName, labelText: poem.content, fontSize: CGFloat(fontSize), lineHeight: 8)
        poemTextLabel.frame.origin.y = y
        poemTextLabel.textColor = UIColor(hex: textColor)
        poemTextLabel.textAlignment = .Center
        scrollView.addSubview(poemTextLabel)
        y += poemTextLabel.bounds.size.height + 10

        var labelSize = CGSizeZero
        if poemTextLabel.bounds.height < UIScreen.mainScreen().bounds.height {
            labelSize = CGSizeMake(UIScreen.mainScreen().bounds.width, UIScreen.mainScreen().bounds.height )
        } else {
            labelSize = CGSizeMake(poemTextLabel.frame.size.width, y )

        }
        
        self.scrollView.contentSize = labelSize
        print(scrollView.frame)
        print(view.frame)
        

	
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func close(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
        
    }

    @IBAction func deletePoem(sender: AnyObject) {
        try! realm.write({ () -> Void in
            realm.delete(poem)
    
        })
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "show Edit" {
            if let nav = segue.destinationViewController as? UINavigationController {
                if let vc = nav.topViewController as? AddPoemViewController {
                    vc.isEditingMode = true
                    vc.delegate = self
                    vc.poem = poem
                }
            }
        }
    }
    
    @IBAction func tapActiion(sender: AnyObject) {
        
        // 创建alertView
        let optionMenu = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertControllerStyle.ActionSheet)
        
        // 取消
        let cancelAction = UIAlertAction(title: "取消", style: UIAlertActionStyle.Cancel, handler: nil)
        optionMenu.addAction(cancelAction)
        
        // 分享
        let sharedAction = UIAlertAction(title: "分享", style: UIAlertActionStyle.Default) { (action) -> Void in
            print("分享")
            self.share()

        }
        optionMenu.addAction(sharedAction)
        
        
        self.presentViewController(optionMenu, animated: true, completion: nil)
        
        
    }
    
    
    func share() {
        let scale = UIScreen.mainScreen().scale
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, true, scale)
        view.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        let shareString = "\(poem.title)\n \(poem.author)\n \(poem.content)"
        let activity = UIActivity()
        
        let activityItems = [image, shareString]
        let activities = [activity]
        
        let activityController = UIActivityViewController(activityItems: activityItems, applicationActivities: activities)
        
        self.presentViewController(activityController, animated: true, completion: nil)
    }
}

extension PoemViewController: AddPoemViewControllerDelegate {
    func addPoemViewController(controller: AddPoemViewController, didFinishedReload item: Poem) {
        self.poem = item
        titleTextLabel.text = item.title
        authorTextLabel.text = item.author
        poemTextLabel.text = item.content
    }
}

