//
//  HomeViewController.swift
//  Frost
//
//  Created by Denzel Carter on 5/29/15.
//  Copyright (c) 2015 BearBrosDevelopment. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet var resultsTable: UITableView!
    
    var followArray = [String]()
    
    var resultsNameArray = [String]()
    var resultsImageFiles = [PFFile]()
    var resultsTweetArray = [String]()
    var resultsHasImageArray = [String]()
    var resultsTweetImageFiles = [PFFile]()
    
    var refresher:UIRefreshControl!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTable.frame = CGRectMake(0, 0, theWidth, theHeight)
        
        let tweetBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("tweetBtn_click"))
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchBtn_click"))
        
        
        var buttonArray = NSArray(objects: tweetBtn, searchBtn)
        self.navigationItem.rightBarButtonItems = buttonArray as [AnyObject]
        refresher = UIRefreshControl()
        refresher.tintColor = UIColor.blackColor()
        refresher.addTarget(self, action: "refresh", forControlEvents: UIControlEvents.ValueChanged)
        self.resultsTable.addSubview(refresher)
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
    }
    
    override func viewDidAppear(animated: Bool) {
        refreshResults()
    
    }
    
    func refresh() {
        
        println("refresh")
        refreshResults()
    }
    
    func refreshResults() {
        followArray.removeAll(keepCapacity: false)
        resultsNameArray.removeAll(keepCapacity: false)
        resultsImageFiles.removeAll(keepCapacity: false)
        resultsTweetArray.removeAll(keepCapacity: false)
        resultsHasImageArray.removeAll(keepCapacity: false)
        resultsTweetImageFiles.removeAll(keepCapacity: false)
        
        var followQuery = PFQuery(className: "follow")
        followQuery.whereKey("user", equalTo: PFUser.currentUser()!.username!)
        followQuery.addAscendingOrder("createdAt")
        
        var objects = followQuery.findObjects()
        
        for object in objects! {
            
            self.followArray.append(object.objectForKey("userToFollow") as! String)
        }
        
        var query = PFQuery(className: "tweets")
        query.whereKey("userName", containedIn: followArray)
        query.addAscendingOrder("createdAt")
        query.findObjectsInBackgroundWithBlock { (objects:[AnyObject]?, error:NSError?) -> Void in
            
            if error == nil {
                
                for object in objects! {
                    
                    self.resultsNameArray.append(object.objectForKey("username") as! String)
                    self.resultsImageFiles.append(object.objectForKey("photo") as! PFFile)
                    self.resultsTweetArray.append(object.objectForKey("tweet") as! String)
                    self.resultsHasImageArray.append(object.objectForKey("hasImage") as! String)
                    self.resultsTweetImageFiles.append(object.objectForKey("tweetImage") as! PFFile)
                    
                    
                    self.resultsTable.reloadData()
                    
                    
                }
                
                  self.refresher.endRefreshing()
            }
            
        }

        
    }
    
    func tweetBtn_click() {
        
        println("Tweet Something")
        self.performSegueWithIdentifier("makeTweet", sender: self)
    }
    
    func searchBtn_click(){
        println("search for something")
        self.performSegueWithIdentifier("GoUsers", sender: self)
    }
    
    @IBAction func logout_button(sender: AnyObject) {
        PFUser.logOut()
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return resultsNameArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if resultsHasImageArray[indexPath.row] == "yes" {
            
            return self.view.frame.size.width - 10
        } else {
        
           return 90
            
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:HomeViewCell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as! HomeViewCell
        cell.tweetImg.hidden = true
        
        cell.usernameTxt.text = self.resultsNameArray[indexPath.row]
        cell.messageTxt.text = self.resultsTweetArray[indexPath.row]
        resultsImageFiles[indexPath.row].getDataInBackgroundWithBlock { (imageData:NSData?, error:NSError?) -> Void in
            
            if error == nil {
                
                let image = UIImage(data: imageData!)
                cell.profilePic.image = image
            }
            
        }
        
        if resultsHasImageArray[indexPath.row] == "yes" {
            
            let theWidth = view.frame.size.width
            
            cell.tweetImg.frame = CGRectMake(70, 70, theWidth - 85, theWidth-85)
            cell.tweetImg.hidden = false
            
            resultsTweetImageFiles[indexPath.row].getDataInBackgroundWithBlock({ (imageData:NSData?, error:NSError?) -> Void in
                if error == nil {
                    
                    let image = UIImage(data: imageData!)
                    cell.tweetImg.image = image
                }
            })
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
