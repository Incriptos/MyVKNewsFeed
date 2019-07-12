//
//  NewsFeedModels.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright (c) 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

enum NewsFeed {
   
  enum Model {
    struct Request {
      enum RequestType {
        case getNewsFeed
        case openPostIds(postId: Int)
      }
    }
    struct Response {
      enum ResponseType {
        case presentNewsFeed(feed: FeedResponse, openPostIds: [Int])
      }
    }
    struct ViewModel {
      enum ViewModelData {
        case displayNewsFeed(feedViewModel: FeedViewModel)
      }
    }
  }
  
}

struct FeedViewModel {
  struct Cell: FeedCellViewModel {
    
    var postId: Int
    
    var photoAttachment: FeedCellPhotoAttachmentViewModel?
    var iconUrlString: String
    var name: String
    var date: String
    var text: String?
    var likes: String?
    var comments: String?
    var reposts: String?
    var views: String?
    var sizes: FeedCellSizes
  }
  
  struct FeedCellPhotoAttachment: FeedCellPhotoAttachmentViewModel {
    var photoSrcString: String?
    var photoHeight: Int
    var photoWidth: Int
  }
  
  let cells: [Cell]
}
