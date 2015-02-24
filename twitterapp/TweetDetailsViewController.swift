//
//  TweetDetailsViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/20/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

protocol TweetsFeedDelegate {
  func userDidFavoriteTweet(tweet: Tweet, index: Int)
  func userDidRetweetTweet(tweet: Tweet, index: Int)
}

class TweetDetailsViewController: UIViewController {

  @IBOutlet weak var userRealNameLabel: UILabel!
  @IBOutlet weak var userTwitterHandleLabel: UILabel!
  @IBOutlet weak var userProfileImageView: UIImageView!
  @IBOutlet weak var tweetContentLabel: UILabel!
  @IBOutlet weak var dateTimeLabel: UILabel!
  @IBOutlet weak var numRetweetsLabel: UILabel!
  @IBOutlet weak var numFavoritesLabel: UILabel!
  @IBOutlet weak var favoriteButton: UIButton!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var replyButton: NSLayoutConstraint!
  @IBOutlet weak var favoriteDescLabel: UILabel!
  @IBOutlet weak var retweetsDescLabel: UILabel!
  
  var tweet: Tweet?
  var delegate: TweetsFeedDelegate?
  var index = 0
  
  override func viewDidLoad() {
    super.viewDidLoad()
    userRealNameLabel.text = tweet!.user!.name
    userTwitterHandleLabel.text = tweet!.user!.screenName
    userProfileImageView.setImageWithURL(tweet!.user!.profileImgURL)
    userProfileImageView.layer.cornerRadius = 5.0
    userProfileImageView.clipsToBounds = true
    tweetContentLabel.text = tweet!.text
    tweetContentLabel.sizeToFit()
    dateTimeLabel.text = tweet!.createdAtStr
    numRetweetsLabel.text = String(tweet!.retweetCount)
    numFavoritesLabel.text = String(tweet!.favoritesCount)
    
    favoriteButton.setImage(UIImage(named: "favorite_yellow"), forState: UIControlState.Selected)
    if tweet!.favorited! {
      activateFavorite()
    }
    
    retweetButton.setImage(UIImage(named: "retweet_green"), forState: UIControlState.Selected)
    if tweet!.retweetedByUser {
      activateRetweet()
    }
  }
  
  func activateFavorite() {
    favoriteButton.selected = true
    numFavoritesLabel.textColor = UIColor(red: 1.0, green: 172/255.0, blue: 51/255.0, alpha: 1.0)
    numFavoritesLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 13.0)
    favoriteDescLabel.textColor = UIColor(red: 1.0, green: 172/255.0, blue: 51/255.0, alpha: 1.0)
  }
  
  func activateRetweet() {
    retweetButton.selected = true
    numRetweetsLabel.textColor = UIColor(red: 92.0/255.0, green: 145/255.0, blue: 59/255.0, alpha: 1.0)
    numRetweetsLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 13.0)
    retweetsDescLabel.textColor = UIColor(red: 92.0/255.0, green: 145/255.0, blue: 59/255.0, alpha: 1.0)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onRetweet(sender: AnyObject) {
    TwitterClient.sharedInstance.retweetWithCompletion(tweet!.id, completion: { (newTweet, error) -> () in
      if error == nil {
        self.tweet!.retweetedByUser = true
        self.numRetweetsLabel.text = "\(self.tweet!.retweetCount + 1)"
        self.activateRetweet()
        self.delegate?.userDidRetweetTweet(newTweet!, index: self.index)
      }
    })
  }
  
  @IBAction func onReply(sender: AnyObject) {
  }
  
  @IBAction func onFavorite(sender: AnyObject) {
    TwitterClient.sharedInstance.favoriteWithCompletion(tweet!.id, completion: { (newTweet, error) -> () in
      if error == nil {
        self.tweet!.favorited = true
        self.numFavoritesLabel.text = "\(self.tweet!.favoritesCount + 1)"
        self.activateFavorite()
        self.delegate?.userDidFavoriteTweet(newTweet!, index: self.index)
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
