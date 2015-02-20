//
//  Tweet.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/19/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class Tweet: NSObject {
  var user: User?
  var text: String?
  var createdAtStr: String?
  var createdAt: NSDate?
  
  init(dictionary: NSDictionary) {
    user = User(dictionary: dictionary["user"] as NSDictionary)
    text = dictionary["text"] as? String
    createdAtStr = dictionary["created_at"] as? String
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    createdAt = formatter.dateFromString(createdAtStr!)
  }
  
  class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in array {
      tweets.append(Tweet(dictionary: dictionary))
    }
    
    return tweets
  }
}
