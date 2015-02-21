//
//  TweetCell.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/20/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
  
  @IBOutlet weak var profilePicImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var twitterHandleLabel: UILabel!
  @IBOutlet weak var timeLabel: UILabel!
  @IBOutlet weak var tweetTextLabel: UILabel!
  
  var tweet: Tweet {
    get {
      return self.tweet
    }
    set (tweet) {
      nameLabel.text = tweet.user?.name
      twitterHandleLabel.text = tweet.user?.screenName
//      timeLabel.text = tweet.createdAtStr
      tweetTextLabel.text = tweet.text
    }
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
