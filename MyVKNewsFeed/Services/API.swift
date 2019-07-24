//
//  API.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation

struct Api {
  
  static let scheme = "https"
  static let host = "api.vk.com"
  static let version = "5.100"
  
  static let newsFeed = "/method/newsfeed.get"
  
  static let user = "/method/users.get"
}
