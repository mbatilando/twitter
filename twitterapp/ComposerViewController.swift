//
//  ComposerViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/21/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class ComposerViewController: UIViewController {

  @IBOutlet weak var profileImageView: UIImageView!
  @IBOutlet weak var userRealNameLabel: UILabel!
  @IBOutlet weak var twitterHandleLabel: UILabel!
  @IBOutlet weak var tweetTextView: UITextView!
  @IBOutlet weak var charCountLabel: UILabel!
  
  
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  @IBAction func onTweet(sender: AnyObject) {
    TwitterClient.sharedInstance.tweetWithCompletion(tweetTextView.text, completion: { (success, error) -> () in
      if success != nil {
        self.dismissViewControllerAnimated(true, completion: nil)
      } else {
        println("An error happened while posting a tweet")
      }
    })
  }
  
  @IBAction func onCancel(sender: AnyObject) {
    self.dismissViewControllerAnimated(true, completion: nil)
  }
  

}
