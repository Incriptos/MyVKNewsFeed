//
//  NewsFeedPresenter.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright (c) 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
    case .presentNewsFeed(let feed):
      
      let cells = feed.items.map { (feedItem) in
        cellViewModel(from: feedItem)
      }
      
      let feedViewModel = FeedViewModel.init(cells: cells)

      viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
  
  private func cellViewModel(from feedItem: FeedItem) -> FeedViewModel.Cell {
    return FeedViewModel.Cell.init(iconUrlString: "",
                                   name: "Future name",
                                   date: "Future Date",
                                   text: String(feedItem.text!),
                                   likes: String(feedItem.likes?.count ?? 0),
                                   comments: String(feedItem.comments?.count ?? 0),
                                   reposts: String(feedItem.reposts?.count ?? 0),
                                   views: String(feedItem.views?.count ?? 0))
  }
  
}
