//
//  HomeViewCell.swift
//  Frost
//
//  Created by Denzel Carter on 5/29/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit

class HomeViewCell: UITableViewCell {
    
    @IBOutlet var profilePic: UIImageView!
    
    @IBOutlet var usernameTxt: UILabel!
    
    @IBOutlet var messageTxt: UITextView!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        profilePic.center = CGPointMake(35, 35)
        profilePic.layer.cornerRadius = profilePic.frame.size.width / 2
        profilePic.clipsToBounds = true
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
