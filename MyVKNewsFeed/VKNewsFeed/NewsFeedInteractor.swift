//
//  NewsFeedInteractor.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright (c) 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

protocol NewsFeedBusinessLogic {
  func makeRequest(request: NewsFeed.Model.Request.RequestType)
}

class NewsFeedInteractor: NewsFeedBusinessLogic {

  var presenter: NewsFeedPresentationLogic?
  var service: NewsFeedService?
  private var fetcher: DataFetcher = NetworkDataFetcher(networking: NetworkService())
  
  private var openPostsIds = [Int]()
  private var feedRespons: FeedResponse?
  
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
    }
    
    switch request {
  
    case .getNewsFeed:
      fetcher.getFeed { [weak self] (feedRespons) in
  
        self?.feedRespons = feedRespons
        self?.presentFeed()
        
      }
      
    case .openPostIds(let postId):
      openPostsIds.append(postId)
      presentFeed()
    case .getUser:
      fetcher.getUser { (userResponse) in
        self.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: userResponse))
      }
    }
  }
  
  private func presentFeed() {
    guard let feedRespons = self.feedRespons else { return }
    presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feedRespons,
                                                                                        openPostIds: openPostsIds))
  }
}
