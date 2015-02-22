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
  
  var loginCompletion: ((user: User?, error: NSError?) -> ())?
  
  class var sharedInstance: TwitterClient {
    struct Static {
      static let instance = TwitterClient(baseURL: twitterBaseURL, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
    }
    return Static.instance
  }
  
  func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()) {
    loginCompletion = completion
    
    requestSerializer.removeAccessToken()

    fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "maritwitterdemo://oauth"), scope: nil,
      success: { (requestToken: BDBOAuth1Credential!) -> Void in
        println("Got my request token")
        var authUrl = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
        UIApplication.sharedApplication().openURL(authUrl!)
      },
      failure: { (error: NSError!) -> Void in
        println("Something happened \(error.description)")
        self.loginCompletion?(user: nil, error: error)
      }
    )
    
  }
  
  func homeTimelineWithParams(params: NSDictionary?, completion: (tweets: [Tweet]?, error: NSError?) -> ()) {
    // Fetch timeline
    self.GET("1.1/statuses/home_timeline.json", parameters: params,
      success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
        let tweets = Tweet.tweetsWithArray(response as [NSDictionary])
        completion(tweets: tweets, error: nil)
        
      },
      failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
        completion(tweets: nil, error: error)
      }
    )
  }
  
  func openURL(url: NSURL) {
    fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query),
      success: { (accessToken: BDBOAuth1Credential!) -> Void in
        println("Got my access token")
        TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
        
        // Verify credentials
        self.GET("1.1/account/verify_credentials.json", parameters: nil,
          success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
            let user = User(dictionary: response as NSDictionary)
            User.currentUser = user
            println("user: \(user.name)")
            self.loginCompletion?(user: user, error: nil)
          },
          failure: { (operation: AFHTTPRequestOperation!, error: NSError!) -> Void in
            println("Failed to get user \(error.description)")
            self.loginCompletion?(user: nil, error: error)
          }
        )
      },
      failure: { (error: NSError!) -> Void in
        println("Failed to receive access token")
        self.loginCompletion?(user: nil, error: error)
    })
  }
  
  func tweetWithCompletion(tweet: String, completion: (tweet: Tweet?, error: NSError?) -> ()) {
    var params = ["status": tweet]

    POST("/1.1/statuses/update.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
      var tweet = Tweet(dictionary: response as NSDictionary)
      completion(tweet: tweet, error: nil)
      
      }) { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
        println(error)
        completion(tweet: nil, error: error)
    }
  }
  
  func retweetWithCompletion(tweetId: Int, completion: (tweet: Tweet?, error: NSError?) -> ()) {
    POST("/1.1/statuses/retweet/\(tweetId).json", parameters: nil, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
      var tweet = Tweet(dictionary: response as NSDictionary)
      completion(tweet: tweet, error: nil)
      
      }) { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
        println(error)
        completion(tweet: nil, error: error)
    }
  }
  
  func favoriteWithCompletion(tweetId: Int, completion: (tweet: Tweet?, error: NSError?) -> ()) {
    var params = ["id": tweetId]
    
    POST("/1.1/favorites/create.json", parameters: params, success: { (operation: AFHTTPRequestOperation!, response: AnyObject!) -> Void in
      var tweet = Tweet(dictionary: response as NSDictionary)
      completion(tweet: tweet, error: nil)
      
      }) { (operation:AFHTTPRequestOperation!, error: NSError!) -> Void in
        println(error)
        completion(tweet: nil, error: error)
    }
  }
}
