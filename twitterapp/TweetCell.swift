//
//  TweetCell.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/20/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

protocol TweetCellDelegate {
  func userDidReplyToTweet(tweet: Tweet)
  func userDidFavoriteTweet(tweet: Tweet)
  func userDidRetweetTweet(tweet: Tweet)
}

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var profilePicImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var twitterHandleLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  @IBOutlet weak var retweetCountLabel: UILabel!
  @IBOutlet weak var favoriteCountLabel: UILabel!
  @IBOutlet weak var retweetButton: UIButton!
  @IBOutlet weak var favoriteButton: UIButton!
  
  var tweet: Tweet? {
    didSet {
      profilePicImageView.setImageWithURL(tweet!.user?.profileImgURL)
      profilePicImageView.layer.cornerRadius = 5.0
      profilePicImageView.clipsToBounds = true
      
      nameLabel.text = tweet!.user?.name
      twitterHandleLabel.text = tweet!.user?.screenName
      tweetTextLabel.text = tweet!.text
      retweetCountLabel.text = "\(tweet!.retweetCount)"
      favoriteCountLabel.text = "\(tweet!.favoritesCount)"
      
      favoriteButton.setImage(UIImage(named: "favorite_yellow"), forState: UIControlState.Selected)
      if tweet!.favorited! {
        favoriteButton.selected = true
        favoriteCountLabel.textColor = UIColor(red: 1.0, green: 172/255.0, blue: 51/255.0, alpha: 1.0)
      }
      
      
      retweetButton.setImage(UIImage(named: "retweet_green"), forState: UIControlState.Selected)
      if tweet!.retweetedByUser {
        retweetButton.selected = true
        retweetCountLabel.textColor = UIColor(red: 92.0/255.0, green: 145/255.0, blue: 59/255.0, alpha: 1.0)
      }
      
      self.layoutIfNeeded()
    }
  }
  
  func setData(newTweet: Tweet) {
    retweetCountLabel.text = "\(newTweet.retweetCount)"
    favoriteCountLabel.text = "\(newTweet.favoritesCount)"
  }
  
  var delegate: TweetCellDelegate?
  
  @IBAction func onReply(sender: AnyObject) {
    delegate?.userDidReplyToTweet(tweet!)
  }
  
  @IBAction func onRetweet(sender: AnyObject) {
    delegate?.userDidRetweetTweet(tweet!)
    
    retweetCountLabel.text = "\(tweet!.retweetCount + 1)"
    retweetButton.selected = true
  }
  
  @IBAction func onFavorite(sender: AnyObject) {
    delegate?.userDidFavoriteTweet(tweet!)
    
    favoriteCountLabel.text = "\(tweet!.favoritesCount + 1)"
    favoriteButton.selected = true
    favoriteCountLabel.textColor = UIColor(red: 1.0, green: 172/255.0, blue: 51/255.0, alpha: 1.0)
  }
  
  override func awakeFromNib() {
    super.awakeFromNib()
    // Initialization code
  }
  
  override func setSelected(selected: Bool, animated: Bool) {
    super.setSelected(selected, animated: animated)
    
    // Configure the view for the selected state
  }
}
