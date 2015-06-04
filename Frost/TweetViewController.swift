//
//  TweetViewController.swift
//  Frost
//
//  Created by Denzel Carter on 6/2/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class TweetViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate{
    
    @IBOutlet var messageTxt: UITextView!
    
    @IBOutlet var charLbls: UILabel!
    
    @IBOutlet var tweetImg: UIImageView!
    
    var hasImage = false
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func cancelBtn_click(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    
    @IBAction func tweetBtnClick(sender: AnyObject) {
        var theTweet = messageTxt.text
        var len = count(messageTxt.text.utf16)
        
        if len > 90 {
            
            theTweet = theTweet.substringToIndex(advance(theTweet.startIndex, 90))
        }
        
        var tweetObj = PFObject(className: "tweets")
        tweetObj["username"] = PFUser.currentUser()?.username
        tweetObj["photo"] = PFUser.currentUser()?.valueForKey("photo") as! PFFile
        tweetObj["tweet"] = theTweet
        
        if hasImage == true {
            
            tweetObj["hasImage"] = "yes"
            let imageData = UIImagePNGRepresentation(self.tweetImg.image)
            let imageFile = PFFile(name: "tweetPhoto.png", data: imageData)
            tweetObj["tweetImage"] = imageFile
            
        } else {
            
            tweetObj["hasImage"] = "no"
        }
        
        
        
        tweetObj.save()
        
        println("Tweet")
        self.dismissViewControllerAnimated(true, completion: nil)
        
    
        
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [NSObject : AnyObject]) {
        
        let theInfo:NSDictionary = info as NSDictionary
        
        let image:UIImage = theInfo.objectForKey(UIImagePickerControllerEditedImage) as! UIImage
        
        tweetImg.image = image
        
        hasImage = true
        
        self.dismissViewControllerAnimated(true, completion: nil)
        
        
    }
    
    @IBAction func Add_photo_click(sender: AnyObject) {
        
        var image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        image.allowsEditing = true
        self.presentViewController(image, animated: true, completion: nil)
        
    }
    
    
    
    
    func textViewDidChange(textView: UITextView) {
        var len = count(messageTxt.text.utf16)
        var diff = 90 - len
        
        if diff < 0 {
            
            charLbls.textColor = UIColor.redColor()
        } else {
            
            charLbls.textColor = UIColor.blackColor()
        }
        
        charLbls.text = " \(diff) chars left"
        
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
