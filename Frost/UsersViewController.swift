//
//  UsersViewController.swift
//  Frost
//
//  Created by Denzel Carter on 5/29/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class UsersViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var usersTable: UITableView!
    var usersNameArray = [String]()
    var usersUserNameArray = [String]()
    var usersImageFiles = [PFFile]()
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewWillAppear(animated: Bool) {
        usersNameArray.removeAll(keepCapacity: false)
        usersUserNameArray.removeAll(keepCapacity: false)
        usersImageFiles.removeAll(keepCapacity: false)
        
        var query = PFUser.query()
        query?.whereKey("username", notEqualTo: PFUser.currentUser()!.username!)
        query?.findObjectsInBackgroundWithBlock({
            (objects:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    self.usersNameArray.append(object.objectForKey("username") as! String)
                    self.usersImageFiles.append(object.objectForKey("profilePic") as! PFFile)
                    self.usersTable.reloadData()
                }
                
            }
        })
        

    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return usersNameArray.count
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 64
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell:UsersViewCell = tableView.dequeueReusableCellWithIdentifier("userCell") as! UsersViewCell
        
        cell.usernameTxt.text = self.usersNameArray[indexPath.row]
        
        var query = PFQuery(className: "follow")
        
        query.whereKey("user", equalTo: PFUser.currentUser()!.username!)
        query.whereKey("userToFollow", equalTo: cell.usernameTxt.text!)
        query.countObjectsInBackgroundWithBlock { (count:Int32, error:NSError?) -> Void in
            
            if error == nil {
                
                if count == 0 {
                    
                    cell.followBtnTxt.setTitle("Follow", forState: UIControlState.Normal)
                } else {
                    
                    cell.followBtnTxt.setTitle("following", forState: UIControlState.Normal)
                }
            }
        }
        
        self.usersImageFiles[indexPath.row].getDataInBackgroundWithBlock { (imagedata:NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imagedata!)
                cell.profilePic.image = image
            }
        }
        
        return cell
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
