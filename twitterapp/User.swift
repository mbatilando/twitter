//
//  User.swift
//  twitterapp
//
//  Created by Mari Batilando on 2/19/15.
//  Copyright (c) 2015 Mari Batilando. All rights reserved.
//

import UIKit

class User: NSObject {
  var name: String?
  var screenName: String?
  var profileImgURL: NSURL?
  var tagline: String?
  var dictionary: NSDictionary
  
  init(dictionary: NSDictionary) {
    self.dictionary = dictionary
    name = dictionary["name"] as? String
    screenName = dictionary["screen_name"] as? String
    profileImgURL = dictionary["profile_image_url"] as? NSURL
    tagline = dictionary["description"] as? String 
  }
}
