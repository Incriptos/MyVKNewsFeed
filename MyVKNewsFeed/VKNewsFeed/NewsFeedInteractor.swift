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
 
  func makeRequest(request: NewsFeed.Model.Request.RequestType) {
    if service == nil {
      service = NewsFeedService()
      
      switch request {
        
      case .getNewsFeed:
        service?.getFeed(completion: { [weak self] (openPostIds, feed) in
          self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, openPostIds: openPostIds))
        })
        
      case .getUser:
        service?.getUser(completion: { [weak self] (user) in
          self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentUserInfo(user: user))
        })
        
      case .openPostIds(let postId):
        service?.openPostIds(forPostId: postId, completion: { [weak self] (openPostIds, feed) in
          self?.presenter?.presentData(response: NewsFeed.Model.Response.ResponseType.presentNewsFeed(feed: feed, openPostIds: openPostIds))
        })
      }
    }
  }
  
}
