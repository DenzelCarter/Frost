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

class TweetViewController: UIViewController, UITextViewDelegate{
    
    @IBOutlet var messageTxt: UITextView!
    
    @IBOutlet var charLbls: UILabel!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
    @IBAction func cancelBtn_click(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
        
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
