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
    
    TwitterClient.sharedInstance.loginWithCompletion { (user, error) -> () in
      if user != nil {
        self.performSegueWithIdentifier("loginSegue", sender: self)
      } else {
        println("Error happened")
      }
    }
  }

}

