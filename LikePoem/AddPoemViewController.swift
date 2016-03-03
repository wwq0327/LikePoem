//
//  AddPoemViewController.swift
//  LikePoem
//
//  Created by wyatt on 16/3/2.
//  Copyright © 2016年 Wanqing Wang. All rights reserved.
//

import UIKit
import RealmSwift

private let realm = try! Realm()

protocol AddPoemViewControllerDelegate: class {
    func addPoemViewController(controller: AddPoemViewController, didFinishedReload item: Poem)
}

class AddPoemViewController: UITableViewController {
    
    var isEditingMode = false
    var poem: Poem!
    
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    weak var delegate: AddPoemViewControllerDelegate!

    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var authorLabel: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isEditingMode {
            title = "编辑内容"
            titleLabel.text = poem.title
            authorLabel.text = poem.author
            contentTextView.text = poem.content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func cancel(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func saveClicked(sender: AnyObject) {
        let contentCount = contentTextView.text.characters.count
        
        if contentCount == 0 {
            let alertController = UIAlertController(title: "错误", message: "内容不能为空", preferredStyle: UIAlertControllerStyle.Alert)
            let doneAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil)
            alertController.addAction(doneAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            return
            
        }
        
        if isEditingMode {
            try! realm.write({ () -> Void in
                poem.title = titleLabel.text!
                poem.author = authorLabel.text!
                poem.content = contentTextView.text
            })
            self.delegate.addPoemViewController(self, didFinishedReload: poem)
            self.dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            let newPoem = Poem()
            newPoem.title = titleLabel.text!
            newPoem.author = authorLabel.text!
            newPoem.content = contentTextView.text

            try! realm.write({ () -> Void in
                realm.add(newPoem)
            })
            
            self.dismissViewControllerAnimated(true, completion: nil)
        }
    }

}
