//
//  TwitterClient.swift
//  Twitter
//
//  Created by Mari Batilando on 2/17/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

let twitterConsumerKey = "Im5RRMU0UsKHwHTiKwogYqfC0"
let twitterConsumerSecret = "0eziAG0BeCK9Ge6Xppve1EtZx0sSALmmXXR0TEsu2z08uxItAq"
let twitterBaseURL = NSURL(string: "https://api.twitter.com")


class TwitterClient: BDBOAuth1RequestOperationManager {
  
  class var sharedInstance: TwitterClient {
    struct Static {
      static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    }
    return Static.instance
  }
}
