//
//  TweetsViewController.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/20/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {
  
  var tweets: [Tweet]?
  @IBOutlet weak var tweetsTableView: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    self.tweetsTableView.delegate = self
    self.tweetsTableView.dataSource = self

    TwitterClient.sharedInstance.homeTimelineWithParams(nil, completion: { (tweets, error) -> () in
      self.tweets = tweets
    })
    
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
//  @IBAction func onLogout(sender: AnyObject) {
//    User.currentUser?.logout()
//  }
  
  @IBAction func onLogout(sender: AnyObject) {
    User.currentUser?.logout()
  }
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}

extension TweetsViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    <#code#>
  }
  
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if tweets != nil {
      return tweets!.count
    }
    return 0
  }
}