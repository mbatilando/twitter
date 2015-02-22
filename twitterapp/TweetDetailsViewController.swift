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
  
  var tweet: Tweet?  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userRealNameLabel.text = tweet!.user!.name
    userTwitterHandleLabel.text = tweet!.user!.screenName
    userProfileImageView.setImageWithURL(tweet!.user!.profileImgURL)
    userProfileImageView.layer.cornerRadius = 5.0
    userProfileImageView.clipsToBounds = true
    tweetContentLabel.text = tweet!.text
    tweetContentLabel.sizeToFit()
    // TODO: ADD DATETIME LABEL
    numRetweetsLabel.text = String(tweet!.retweetCount)
    numFavoritesLabel.text = String(tweet!.favoritesCount)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onRetweet(sender: AnyObject) {
    TwitterClient.sharedInstance.retweetWithCompletion(tweet!.id, completion: { (tweet, error) -> () in
      if error == nil {
        println("Retweet Success")
        self.navigationController?.popViewControllerAnimated(true)
      }
    })
  }
  
  @IBAction func onReply(sender: AnyObject) {
  }
  
  @IBAction func onFavorite(sender: AnyObject) {
    TwitterClient.sharedInstance.favoriteWithCompletion(tweet!.id, completion: { (tweet, error) -> () in
      if error == nil {
        println("Favorite Success")
        self.navigationController?.popViewControllerAnimated(true)
      }
    })
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var id = segue.identifier
    if id == "replySegue" {
      var composerViewController = segue.destinationViewController as ComposerViewController
      composerViewController.tweet = tweet?
    }
  }
}
