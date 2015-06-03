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

class HomeViewController: UIViewController {
    
    @IBOutlet var resultsTable: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        let theWidth = view.frame.size.width
        let theHeight = view.frame.size.height
        
        resultsTable.frame = CGRectMake(0, 0, theWidth, theHeight)
        
        let tweetBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Compose, target: self, action: Selector("tweetBtn_click"))
        
        let searchBtn = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Search, target: self, action: Selector("searchBtn_click"))
        
        
        var buttonArray = NSArray(objects: tweetBtn, searchBtn)
        self.navigationItem.rightBarButtonItems = buttonArray as [AnyObject]
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        self.navigationItem.hidesBackButton = true
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
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
