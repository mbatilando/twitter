//
//  ViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/17/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func onLogin(sender: AnyObject) {
    
    TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
    
    TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "maritwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
      let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
      UIApplication.sharedApplication().openURL(authURL!)
      
      }, failure: { (error: NSError!) -> Void in println("Failed") })
  }

}

