//
//  TweetsViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/20/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

  var tweets =  [Tweet]()
  var currTweet: Tweet?
  var rc: UIRefreshControl!
  var tweetCellDelegate: TweetCellDelegate?
  @IBOutlet weak var tweetsTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tweetsTableView.delegate = self
    tweetsTableView.dataSource = self
    tweetsTableView.rowHeight = UITableViewAutomaticDimension
    tweetsTableView.estimatedRowHeight = 80
    
    rc = UIRefreshControl()
    rc.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tweetsTableView.insertSubview(rc, atIndex: 0)

    TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
      if error == nil {
        self.tweets = tweets!
        self.tweetsTableView.reloadData()
      } else {
        println(error)
      }
    })
  }
  
  override func viewWillAppear(animated: Bool) {
    tweetsTableView.reloadData()
  }
  
  func onRefresh() {
    TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
      self.tweets = tweets!
      self.tweetsTableView.reloadData()
      self.rc.endRefreshing()
    })
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  @IBAction func onLogout(sender: AnyObject) {
    User.currentUser?.logout()
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    var id = segue.identifier
    if id == "tweetDetailsSegue" {
      var detailsViewController = segue.destinationViewController as TweetDetailsViewController
      var cell = sender as TweetCell
      let index = self.tweetsTableView.indexPathForCell(cell)!.row
      detailsViewController.index = index
      detailsViewController.tweet = cell.tweet!
      detailsViewController.delegate = self
    } else if id == "tweetReplySegue" {
      var composerViewController = segue.destinationViewController as ComposerViewController
      composerViewController.tweet = currTweet?
    }
  }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
    cell.tweet = tweets[indexPath.row]
    cell.delegate = self
    cell.selectionStyle = UITableViewCellSelectionStyle.None
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
}

extension TweetsViewController: TweetCellDelegate {
  func userDidReplyToTweet(tweet: Tweet) {
    currTweet = tweet
  }
  
  func userDidFavoriteTweet(tweet: Tweet) {
    TwitterClient.sharedInstance.favoriteWithCompletion(tweet.id, completion: { (tweet, error) -> () in
      if error == nil {
        println("Favorite success")
      }
    })
  }
  
  func userDidRetweetTweet(tweet: Tweet) {
    TwitterClient.sharedInstance.retweetWithCompletion(tweet.id, completion: { (tweet, error) -> () in
      if error == nil {
        println("Retweet Success")
      }
    })
  }
}


extension TweetsViewController: TweetsFeedDelegate {
  func userDidFavoriteTweet(newTweet: Tweet, index: Int) {
   let cell = self.tweetsTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as TweetCell
    cell.tweet = newTweet
    cell.tweet!.favoritesCount = newTweet.favoritesCount
    cell.setData(newTweet)
//    self.tweetsTableView.reloadData()
    tweetsTableView.reloadRowsAtIndexPaths([NSIndexPath(forRow: index, inSection: 0)], withRowAnimation: UITableViewRowAnimation.None)
  }
  
  func userDidRetweetTweet(newTweet: Tweet, index: Int) {
    let cell = self.tweetsTableView.cellForRowAtIndexPath(NSIndexPath(forRow: index, inSection: 0)) as TweetCell
    cell.tweet = newTweet
    cell.tweet!.retweetCount = newTweet.retweetCount
    self.tweetsTableView.reloadData()
  }
}



