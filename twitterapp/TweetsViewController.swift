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
  var rc: UIRefreshControl!
  @IBOutlet weak var tweetsTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    tweetsTableView.delegate = self
    tweetsTableView.dataSource = self
    tweetsTableView.estimatedRowHeight = 80
    tweetsTableView.rowHeight = 80
    
    rc = UIRefreshControl()
    rc.addTarget(self, action: "onRefresh", forControlEvents: UIControlEvents.ValueChanged)
    tweetsTableView.insertSubview(rc, atIndex: 0)

    TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
      self.tweets = tweets!
      self.tweetsTableView.reloadData()
    })
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
      detailsViewController.tweet = cell.tweet!
    }
  }
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {

  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = self.tweetsTableView.dequeueReusableCellWithIdentifier("TweetCell") as TweetCell
    cell.tweet = tweets[indexPath.row]
    return cell
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return tweets.count
  }
}