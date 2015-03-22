//
//  ContributionViewController.swift
//  Parse-Test-swift
//
//  Created by 加藤 周 on 2015/03/16.
//  Copyright (c) 2015年 mycompany. All rights reserved.
//

import UIKit
import AVFoundation
class ContributionViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var textfield: UITextField!
    @IBOutlet var imageView:UIImageView!
    var picker:UIImagePickerController?
     var timer : NSTimer!

    override func viewDidLoad() {
        super.viewDidLoad()
        picker = UIImagePickerController()
        picker!.delegate = self
        picker!.allowsEditing = false
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func contribution(sender: AnyObject) {
        SVProgressHUD.show()

        var object: PFObject = PFObject(className: "monsuta")

        object["ImageName"] = textfield.text
        
        var imageData: NSData = UIImageJPEGRepresentation((UIImage:imageView!.image), 0.1)
        var file: PFFile = PFFile(name: "image.jpg", data: imageData)
        object["Image"] = file
        object.saveInBackgroundWithBlock { (succeeded, error) -> Void in
            
        }

        
        timer=NSTimer.scheduledTimerWithTimeInterval(5, target: self, selector: "onUpdate:", userInfo: nil, repeats: true)

        

    }
    
    //timer
    func onUpdate(timer : NSTimer){
        var targetView: AnyObject = self.storyboard!.instantiateViewControllerWithIdentifier( "oneView" )
        
        self.presentViewController( targetView as UIViewController, animated: true, completion: nil)
         timer.invalidate()
        
    }
    @IBAction func openAlbum(sender: AnyObject) {
        //openAlbumが押されたときの処理
        println( "onTapButton - open album" )
        //フォトライブラリその端末で使えるか？使えるなら以下を、実行。43行
        //pickerはカメラにするかフォトライブラリにするかを決めれる。44行
        //今のViewControllerをpickerにする45行
        //Available=利用できる
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.PhotoLibrary) {
            picker!.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
            self.presentViewController(picker!, animated: true, completion: nil)
            
        }
        
        
        
    }
    @IBAction func take(sender:AnyObject)
    {
        //写真を撮影
        println( "onTapButton - take photo" )
        
        if picker==nil {
            return
        }
        //カメラ画をの端末で使えるか？使えるなら以下を実行
        //pickerをカメラにする
        //今のViewControllerをpickerにする
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera) {
            picker!.sourceType = UIImagePickerControllerSourceType.Camera
            self.presentViewController(picker!, animated: true, completion: nil)
        }
    }

    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
        println( "imagePickerController" )
        self.dismissViewControllerAnimated(true, completion: nil)
        //imageViewに撮影した写真を表示
        imageView.image = image
        if picker!.sourceType == UIImagePickerControllerSourceType.Camera {
            println( "save photo" )
            UIImageWriteToSavedPhotosAlbum(image, self, "onSaveImageWithUIImage:error:contextInfo:", nil)
        }
    }
    
    func onSaveImageWithUIImage(image: UIImage!, error: NSErrorPointer, contextInfo: UnsafePointer<()>){
        if (error != nil) {
            println( "error" )
            return
        }
        println( "success" )
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController!){
        
        println( "imagePickerControllerDidCancel" )
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    //parseに文字と写真を入れる。
    //できたら、SNSも作れる。
    //できたら、投稿の削除機能
    //SNSは報告機能か削除と利用契約
    //やらないとリジェクト！！！
    

    

}
