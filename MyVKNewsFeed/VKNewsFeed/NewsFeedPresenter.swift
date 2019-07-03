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
  
  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ua_UA")
    dateFormatter.dateFormat = "d MM 'в' HH:mm:"
    return dateFormatter
  }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
    case .presentNewsFeed(let feed):
      
      let cells = feed.items.map { (feedItem) in
        cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups)
      }
      
      let feedViewModel = FeedViewModel.init(cells: cells)

      viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
  
  private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group]) -> FeedViewModel.Cell {
    
    let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
    
    let date = Date(timeIntervalSince1970: feedItem.date)
    let dateTitle = dateFormatter.string(from: date)
    
    return FeedViewModel.Cell.init(iconUrlString: profile.photo,
                                   name: profile.name,
                                   date: dateTitle,
                                   text: String(feedItem.text!),
                                   likes: String(feedItem.likes?.count ?? 0),
                                   comments: String(feedItem.comments?.count ?? 0),
                                   reposts: String(feedItem.reposts?.count ?? 0),
                                   views: String(feedItem.views?.count ?? 0))
  }
  
  private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
    
    let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
    let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
    let profileRepresentable = profilesOrGroups.first { (mypPofileRepresentable) -> Bool in
      mypPofileRepresentable.id == normalSourceId
    }
    return profileRepresentable!
  }
  
}
