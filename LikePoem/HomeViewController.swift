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
//    let poems = ["元日\n爆竹声中一岁除，\n春风送暖入屠苏。\n千门万户曈曈日，\n总把新桃换旧符。", "天净沙·秋思\n枯藤老树昏鸦，\n小桥流水人家，\n古道西风瘦马。\n夕阳西下，\n断肠人在天涯。", "虞美人·春花秋月何时了\n春花秋月何时了？\n往事知多少。\n小楼昨夜又东风，\n故国不堪回首月明中。\n\n雕栏玉砌应犹在，\n只是朱颜改。\n问君能有几多愁？\n恰似一江春水向东流。\n春花秋月何时了？\n往事知多少。\n小楼昨夜又东风，\n故国不堪回首月明中。\n\n雕栏玉砌应犹在，\n只是朱颜改。\n问君能有几多愁？\n恰似一江春水向东流。"]
    
    var poems: Results<Poem>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.collectionView?.backgroundColor = UIColor.whiteColor()
        // load nib 
        let nib = UINib(nibName: "PoemCollectionViewCell", bundle: nil)
        self.collectionView?.registerNib(nib, forCellWithReuseIdentifier: "poemCell")
        
        // 布局
        let customlayout = CustomLayout()
        self.collectionView?.setCollectionViewLayout(customlayout, animated: true)
    }
    
    override func viewWillAppear(animated: Bool) {
        poems = realm.objects(Poem)
        self.collectionView?.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        cell.authorLabel.text = poem.author
        cell.poemTextLabel.text = poem.content
        cell.poemTextLabel.font = UIFont(name: "FZSKBXKJW--GB1-0", size: 18)
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

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(collectionView: UICollectionView, shouldHighlightItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(collectionView: UICollectionView, shouldSelectItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(collectionView: UICollectionView, shouldShowMenuForItemAtIndexPath indexPath: NSIndexPath) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, canPerformAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) -> Bool {
        return false
    }

    override func collectionView(collectionView: UICollectionView, performAction action: Selector, forItemAtIndexPath indexPath: NSIndexPath, withSender sender: AnyObject?) {
    
    }
    */
    
    

}
