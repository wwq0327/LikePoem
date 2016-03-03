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

    @IBOutlet weak var scrollView: UIScrollView!
    var y: CGFloat = -64
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor().colorWithAlphaComponent(0))
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // title
        titleTextLabel = UILabel(frame: CGRectMake(0, y, UIScreen.mainScreen().bounds.width, 24))
        titleTextLabel.textAlignment = .Center
        titleTextLabel.text = poem.title
        titleTextLabel.font = UIFont(name: "FZSKBXKJW--GB1-0", size: 24)
        scrollView.addSubview(titleTextLabel)
        y += titleTextLabel.bounds.size.height + 10
        
        // author
        authorTextLabel = UILabel(frame: CGRectMake(0, y, UIScreen.mainScreen().bounds.width, 24))
        authorTextLabel.textAlignment = .Center
        authorTextLabel.text = poem.author
        authorTextLabel.font = UIFont(name: "FZSKBXKJW--GB1-0", size: 16)
        scrollView.addSubview(authorTextLabel)
        y += authorTextLabel.bounds.size.height + 10
        
        // content
        poemTextLabel = PoeLabel(fontname: "FZSKBXKJW--GB1-0", labelText: poem.content, fontSize: 18, lineHeight: 8)
        poemTextLabel.frame.origin.y = y
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
}

extension PoemViewController: AddPoemViewControllerDelegate {
    func addPoemViewController(controller: AddPoemViewController, didFinishedReload item: Poem) {
        self.poem = item
        titleTextLabel.text = item.title
        authorTextLabel.text = item.author
        poemTextLabel.text = item.content
    }
}

