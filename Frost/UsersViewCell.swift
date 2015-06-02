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
