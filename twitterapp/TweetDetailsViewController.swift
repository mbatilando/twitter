//
//  TweetDetailsViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/20/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class TweetDetailsViewController: UIViewController {

  @IBOutlet weak var userRealNameLabel: UILabel!
  
  @IBOutlet weak var userTwitterHandleLabel: UILabel!
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var tweetContentLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  @IBOutlet weak var numRetweetsLabel: UILabel!
  @IBOutlet weak var numFavoritesLabel: UILabel!
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onRetweet(sender: AnyObject) {
  }
  
  @IBAction func onReply(sender: AnyObject) {
  }
  
  @IBAction func onFavorite(sender: AnyObject) {
  }
}
