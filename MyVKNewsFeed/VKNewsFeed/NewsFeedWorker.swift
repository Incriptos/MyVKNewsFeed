//
//  NewsFeedWorker.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright (c) 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

class NewsFeedService {

  var authService: AuthService
  var networking:  Networking
  var fetcher:     DataFetcher
  
  private var openPostsIds = [Int]()
  private var feedResponse: FeedResponse?
  
  init() {
    self.authService = AppDelegate.shared().authService
    self.networking = NetworkService(authService: authService)
    self.fetcher = NetworkDataFetcher(networking: networking)
  }
  
  func getUser(completion: @escaping (UserResponse?) -> Void) {
    fetcher.getUser {  (userResponse) in
      completion(userResponse)
    }
  }
  
  func getFeed(completion: @escaping ([Int], FeedResponse) -> Void) {
    fetcher.getFeed { [weak self] (feed) in
      self?.feedResponse = feed
      guard let feedResponse = self?.feedResponse else { return }
      completion(self!.openPostsIds, feedResponse)
    }
  }
  
  func openPostIds(forPostId postId: Int, completion: @escaping ([Int], FeedResponse) -> Void) {
    openPostsIds.append(postId)
    guard let feedResponse = self.feedResponse else { return }
    completion(openPostsIds, feedResponse)
  }
  
}
