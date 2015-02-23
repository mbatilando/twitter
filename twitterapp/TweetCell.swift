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
      self.layoutIfNeeded()
    }
  }
  
  var delegate: TweetCellDelegate?
  
  @IBAction func onReply(sender: AnyObject) {
    delegate?.userDidReplyToTweet(tweet!)
  }
  
  @IBAction func onRetweet(sender: AnyObject) {
    delegate?.userDidRetweetTweet(tweet!)
  }
  
  @IBAction func onFavorite(sender: AnyObject) {
    delegate?.userDidFavoriteTweet(tweet!)
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
