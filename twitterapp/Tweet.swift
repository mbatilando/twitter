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
  var id: Int
  var text: String?
  var createdAtStr: String?
  var createdAt: NSDate?
  var retweetCount: Int
  var retweetedByUser: Bool
  var retweetedByPublic: Bool = false
  var favoritesCount: Int
  var favorited: Bool?
  
  
  
  init(dictionary: NSDictionary) {
    id = dictionary["id"] as Int
    user = User(dictionary: dictionary["user"] as NSDictionary)
    text = dictionary["text"] as? String
    createdAtStr = dictionary["created_at"] as? String
    let formatter = NSDateFormatter()
    formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
    createdAt = formatter.dateFromString(createdAtStr!)
    favoritesCount = dictionary["favorite_count"] as Int!
    favorited = dictionary["favorited"] as Bool
    retweetCount = dictionary["retweet_count"] as Int!
    retweetedByUser = dictionary["retweeted"] as Bool
    if (dictionary["retweeted_status"] != nil) {
      retweetedByPublic = true
    }
    super.init()
  }
  
  class func tweetsWithArray(array: [NSDictionary]) -> [Tweet] {
    var tweets = [Tweet]()
    
    for dictionary in array {
      tweets.append(Tweet(dictionary: dictionary))
    }
    
    return tweets
  }
}
