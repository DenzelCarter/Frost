//
//  UsersViewCell.swift
//  Frost
//
//  Created by Denzel Carter on 5/31/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UsersViewCell: UITableViewCell {
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var usernameTxt: UILabel!
    
    @IBOutlet var followBtnTxt: UIButton!
    
    
    @IBAction func followBtn(sender: AnyObject) {
        let title = followBtnTxt.titleForState(.Normal)
        
        if title == "Follow" {
            
            var followObj = PFObject(className: "follow")
            
            followObj["user"] = PFUser.currentUser()?.username
            followObj["userToFollow"] = usernameTxt.text
            followObj.save()
            
            followBtnTxt.setTitle("Unfollow", forState: UIControlState.Normal)
            
            
        } else {
            
            var query = PFQuery(className: "classname")
            query.whereKey("user", equalTo: PFUser.currentUser()!.username!)
            query.whereKey("userToFollow", equalTo: usernameTxt.text!)
            
            var objects = query.findObjects()
            
            for object in objects! {
                
                object.delete()
            }
            
            followBtnTxt.setTitle("Follow", forState: UIControlState.Normal)
            
        }
        
    }
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        let theWidth = UIScreen.mainScreen().bounds.width
        contentView.frame = CGRectMake(0, 0, theWidth, 64)
        
        profilePic.center = CGPointMake(32, 32)
        profilePic.layer.cornerRadius = profilePic.frame.width / 2
        profilePic.clipsToBounds = true 
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
