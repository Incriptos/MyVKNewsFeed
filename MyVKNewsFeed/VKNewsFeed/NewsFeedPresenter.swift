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
  
  var cellLayoutCalculator: FeedCellLayoutCalculatorProtocol = FeedCellLayoutCalculator()

  let dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ua_UA")
    dateFormatter.dateFormat = "d MM 'в' HH:mm:"
    return dateFormatter
  }()
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
    case .presentNewsFeed(let feed, let openPostIds):
      
      let cells = feed.items.map { (feedItem) in
        cellViewModel(from: feedItem, profiles: feed.profiles, groups: feed.groups, openPostIds: openPostIds)
      }
      
      let feedViewModel = FeedViewModel.init(cells: cells)

      viewController?.displayData(viewModel: NewsFeed.Model.ViewModel.ViewModelData.displayNewsFeed(feedViewModel: feedViewModel))
    }
  }
  
  private func cellViewModel(from feedItem: FeedItem, profiles: [Profile], groups: [Group], openPostIds: [Int]) -> FeedViewModel.Cell {
    
    let profile = self.profile(for: feedItem.sourceId, profiles: profiles, groups: groups)
    
   // let photoAttachment = self.photoAttachment(feedItem: feedItem)
    
    let photoAttachments = self.photoAttachments(feedItem: feedItem)
    
    let date = Date(timeIntervalSince1970: feedItem.date)
    let dateTitle = dateFormatter.string(from: date)
    
   
    let isFullSized = openPostIds.contains { (postId)  in
      return postId == feedItem.postId
    }
    
    let sizes = cellLayoutCalculator.sizesForCell(postText: feedItem.text, photoAttachments: photoAttachments, isFullSizedPost: isFullSized)
    
    
    return FeedViewModel.Cell.init( postId: feedItem.postId,
                                    photoAttachments: photoAttachments,
                                    iconUrlString: profile.photo,
                                    name: profile.name,
                                    date: dateTitle,
                                    text: String(feedItem.text!),
                                    likes: String(feedItem.likes?.count ?? 0),
                                    comments: String(feedItem.comments?.count ?? 0),
                                    reposts: String(feedItem.reposts?.count ?? 0),
                                    views: String(feedItem.views?.count ?? 0),
                                    sizes: sizes)
  }
  
  private func profile(for sourceId: Int, profiles: [Profile], groups: [Group]) -> ProfileRepresentable {
    
    let profilesOrGroups: [ProfileRepresentable] = sourceId >= 0 ? profiles : groups
    let normalSourceId = sourceId >= 0 ? sourceId : -sourceId
    let profileRepresentable = profilesOrGroups.first { (mypPofileRepresentable) -> Bool in
      mypPofileRepresentable.id == normalSourceId
    }
    return profileRepresentable!
  }
  
  private func photoAttachment(feedItem: FeedItem) -> FeedViewModel.FeedCellPhotoAttachment? {
    guard let photos = feedItem.attachments?.compactMap({ (attachment) in
      attachment.photo
    }), let firstPhoto = photos.first else {
      return nil
    }
    return FeedViewModel.FeedCellPhotoAttachment.init(photoSrcString: firstPhoto.urlBIG,
                                                      photoHeight: firstPhoto.height,
                                                      photoWidth: firstPhoto.width)
  }
  
  private func photoAttachments(feedItem: FeedItem) -> [FeedViewModel.FeedCellPhotoAttachment] {
    guard let attachments = feedItem.attachments else { return [] }
    
    return attachments.compactMap({ (attachment) -> FeedViewModel.FeedCellPhotoAttachment? in
      guard let photo = attachment.photo else { return nil }
      return FeedViewModel.FeedCellPhotoAttachment.init(photoSrcString: photo.urlBIG, photoHeight: photo.height, photoWidth: photo.width)
    })
  }
  
  
}
