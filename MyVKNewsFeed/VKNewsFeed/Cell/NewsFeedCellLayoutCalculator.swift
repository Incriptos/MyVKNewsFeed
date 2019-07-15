//
//  NewsFeedCellLayoutCalculator.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/4/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellLayoutCalculatorProtocol {
  func sizesForCell(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
  var postLabelFrame:  CGRect
  var moreTextButtonFrame: CGRect
  var attachmentFrame: CGRect
  var bottomView:      CGRect
  var totalHeight:     CGFloat
  
}


final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
  
  private let screenWidth: CGFloat
  
  init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
    self.screenWidth = screenWidth
  }
  
  func sizesForCell(postText: String?, photoAttachments: [FeedCellPhotoAttachmentViewModel], isFullSizedPost: Bool) -> FeedCellSizes {
    
    var showMoreTextButton = false
    
    let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
    
    // Work with post label frame
    var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left,
                                                y: Constants.postLabelInserts.top),
                                size: .zero)
    
    if let text = postText, !text.isEmpty {
      let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
      var height = text.height(width: width, font: Constants.postLabelFont)
      
      let limitHeight = Constants.postLabelFont.lineHeight * Constants.minimumPostLimitLines
      
      if !isFullSizedPost && height > limitHeight {
        height = Constants.postLabelFont.lineHeight * Constants.minimumPostLines
        showMoreTextButton = true
      }
      
      postLabelFrame.size = CGSize(width: width, height: height)
      
    }
    
    // Work with More Text Button Frame
    var moreTextButtonSize = CGSize.zero
    
    if showMoreTextButton == true {
      moreTextButtonSize = Constants.moreTextButtonSize
    }
    
    let moreTextButtonOrigin = CGPoint(x: Constants.moreTextButtonInserts.left,
                                       y: postLabelFrame.maxY)
    
    let moreTextButtonFrame = CGRect(origin: moreTextButtonOrigin, size: moreTextButtonSize)
    
    
    // Work with attachment frame
    let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : moreTextButtonFrame.maxY + Constants.postLabelInserts.bottom
    
    var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                 size: .zero)
    
//    if let attachment = photoAttachment {
//      let floatPhotoHieght: Float = Float(attachment.photoHeight)
//      let floatPhotoWidth:  Float = Float(attachment.photoWidth)
//      let ration = CGFloat(floatPhotoHieght / floatPhotoWidth)
//
//      attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ration)
//    }
    
    if let attachment = photoAttachments.first {
      let floatPhotoHieght: Float = Float(attachment.photoHeight)
      let floatPhotoWidth:  Float = Float(attachment.photoWidth)
      let ration = CGFloat(floatPhotoHieght / floatPhotoWidth)
      if photoAttachments.count == 1 {
        attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ration)
      } else if photoAttachments.count > 1 {
        attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ration)
      }
    }
    
    
    // work with bottom view frame
    let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
    
    let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                 size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
    
    // total cell frame
    let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
    
    return Sizes(postLabelFrame: postLabelFrame,
                 moreTextButtonFrame: moreTextButtonFrame,
                 attachmentFrame: attachmentFrame,
                 bottomView: bottomViewFrame,
                 totalHeight: totalHeight)
  }
  
}
