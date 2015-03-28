//
//  ViewController.swift
//  Parse-Test-swift
//
//  Created by 加藤 周 on 2015/03/09.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet var tableView : UITableView!
    var pictures: NSArray = NSArray()
    var query:PFQuery = PFQuery()
    var objectss = [AnyObject]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView!.delegate = self
        tableView!.dataSource = self
        
//        self.navigationItem.leftBarButtonItem = self.editButtonItem()
//        
//        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
//        self.navigationItem.rightBarButtonItem = addButton
        
        //---------------------------------------
        self.loadData { (pictures, error) -> () in
        self.pictures = pictures
        self.tableView.reloadData()
    }
        //---------------------------------------
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
//    func insertNewObject(sender: AnyObject) {
//        objects.insert(NSDate(), atIndex: 0)
//        let indexPath = NSIndexPath(forRow: 0, inSection: 0)
//        self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//    }
    //------------------------------------------------------
    func loadData(callback:([PFObject]!, NSError!) -> ())  {
        
        NSLog("loadData")
        query = PFQuery(className:"monsuta")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objectss, error: NSError!) -> Void in
            if (error != nil){
                // エラー処理
            }
            callback(objectss as [PFObject], error)
            
            
        }
    

    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pictures.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var imageFile: PFFile? = self.pictures[indexPath.row].objectForKey("Image") as PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            self.objectss = self.pictures
            if(error == nil) {
                cell.imageView!.image = UIImage(data: imageData)!
                cell.textLabel!.text = self.pictures[indexPath.row].objectForKey("ImageName") as String?
                
            }
        })
        return cell
    }
//---------------------------------------------
    
//    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
//        // Return false if you do not want the specified item to be editable.
//        return true
//    }
    
    
//    @IBAction func tapAddButton(sender: AnyObject) {
//        var object: PFObject = PFObject(className:"monsuta")
//        object["ImageName"] = "PinkMonster"
//        var imageData: NSData = UIImageJPEGRepresentation(UIImage(named: "pinkukyarakuta.png"), 0.1)
//        var file: PFFile = PFFile(name:"pinkukyarakuta.png", data: imageData)
//        object["Image"] = file
//        object.saveInBackgroundWithBlock { (succeeded, error) -> Void in
//            self.loadData { (pictures, error) -> () in
//                self.pictures = pictures
//                self.tableView.reloadData()
//                
//            }
//
//            self.tableView.reloadData()
//        }
//
//    }
//    //音楽をparseにあげる
    
     func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            NSLog("hello")
          //ここに削除コードを書く
            objectss.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }

    @IBAction func refrsh(sender: AnyObject) {
        self.loadData { (pictures, error) -> () in
            self.pictures = pictures
            self.tableView.reloadData()
        }

    }
}
