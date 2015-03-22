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
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView!.delegate = self
        tableView!.dataSource = self
        
        self.loadData { (pictures, error) -> () in
        self.pictures = pictures
        self.tableView.reloadData()
    }
}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func loadData(callback:([PFObject]!, NSError!) -> ())  {
        
        NSLog("loadData")
        query = PFQuery(className:"monsuta")
        query.orderByAscending("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects: [AnyObject]!, error: NSError!) -> Void in
            if (error != nil){
                // エラー処理
            }
            callback(objects as [PFObject], error)
            
            
        }
    

    }
    
    
    
    
     func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return pictures.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as UITableViewCell
        var imageFile: PFFile? = self.pictures[indexPath.row].objectForKey("Image") as PFFile?
        imageFile?.getDataInBackgroundWithBlock({ (imageData, error) -> Void in
            if(error == nil) {
                cell.imageView!.image = UIImage(data: imageData)!
                cell.textLabel!.text = self.pictures[indexPath.row].objectForKey("ImageName") as String?
            }
        })
        return cell
    }

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
    

 

}

