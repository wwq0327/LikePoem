//
//  HomeViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/1.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit
import RealmSwift

private let realm = try! Realm()
private let reuseIdentifier = "Cell"

class HomeViewController: UICollectionViewController {
    
    var poems: Results<Poem>!
    let defaults = NSUserDefaults.standardUserDefaults()
    var fontName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstLaunch()
        
//        self.navigationController?.navigationBar.lt_setBackgroundColor(UIColor().colorWithAlphaComponent(0))
        self.navigationController?.navigationBar.tintColor = UIColor.darkGrayColor()
//        self.navigationController?.navigationBar.shadowImage = UIImage()
        
        // 去掉Back图标后的文字
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.Plain, target: nil, action: nil)
        
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        // load nib 
        let nib = UINib(nibName: "PoemCollectionViewCell", bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: "poemCell")
        
        // 布局
        let customlayout = CustomLayout()
        self.collectionView?.setCollectionViewLayout(customlayout, animated: true)
        
    }
    
    override func viewWillAppear(animated: Bool) {
        if  defaults.stringForKey(FontID.fontName) == nil {
            fontName = FontID.FontFamily.Songkeben.rawValue
        } else {
            fontName = defaults.stringForKey(FontID.fontName)
        }
        
        // 按创建的时候作降序排列
        poems = realm.objects(Poem).sorted("createAt", ascending: false)
        
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func firstLaunch() {
        let isFirst = defaults.boolForKey("isFirst")
        if !isFirst {
            let firstPoem = Poem()
            firstPoem.title = "第一首诗"
            firstPoem.author = "记诗"
            firstPoem.content = "当你想到或看到\n一段美好的文字，\n它让你心灵为之一颤，\n想记录以作留念，\n并将它分享给你的友人。\n此时，\n我们已为你准备好了一切！"
            
            try! realm.write({ () -> Void in
                realm.add(firstPoem)
            })
            
            defaults.setBool(true, forKey: "isFirst")
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
       
        if segue.identifier == "show Detail" {
            if let navvc = segue.destinationViewController as? UINavigationController {
                if let vc = navvc.topViewController as? PoemViewController {
                    if let indexPath = collectionView?.indexPathForCell(sender as! UICollectionViewCell) {
                        vc.poem = poems[indexPath.row]
                    }
                }
            }
        }
    }
    

    // MARK: UICollectionViewDataSource

    override func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return poems.count
    }

    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("poemCell", forIndexPath: indexPath) as! PoemCollectionViewCell
    
        // Configure the cell
        let poem = poems[indexPath.row]
        cell.titleLabel.text = poem.title
        cell.titleLabel.font = UIFont(name: fontName, size: 20)
        cell.authorLabel.text = poem.author
        cell.authorLabel.font = UIFont(name: fontName, size: 16)
        cell.poemTextLabel.text = poem.content
        cell.poemTextLabel.font = UIFont(name: fontName, size: 18)
        cell.poemTextLabel.setLineHeight(1.6)
        cell.poemTextLabel.textAlignment = .Center
        cell.poemTextLabel.verticalAlignment = VerticalAlignmentTop
    
        return cell
    }
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        if let cell = collectionView.cellForItemAtIndexPath(indexPath) {
            performSegueWithIdentifier("show Detail", sender: cell)
        }
    }

    

}
