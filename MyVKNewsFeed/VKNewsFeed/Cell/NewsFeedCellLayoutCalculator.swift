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
  func sizesForCell(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes
}

struct Sizes: FeedCellSizes {
  var postLabelFrame:  CGRect
  var attachmentFrame: CGRect
  var bottomView:      CGRect
  var totalHeight:     CGFloat
}

struct Constants {
  static let cardInserts = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
  static let topViewHeight: CGFloat = 50
  static let postLabelInserts = UIEdgeInsets(top: 5 + Constants.topViewHeight + 5, left: 10, bottom: 7, right: 10)
  static let postLabelFont = UIFont.systemFont(ofSize: 15)
  static let bottomViewHeight: CGFloat = 50
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
  
  private let screenWidth: CGFloat
  
  init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
    self.screenWidth = screenWidth
  }
  
  func sizesForCell(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
    
    let cardViewWidth = screenWidth - Constants.cardInserts.left - Constants.cardInserts.right
    
    // Work with post label frame
    var postLabelFrame = CGRect(origin: CGPoint(x: Constants.postLabelInserts.left,
                                                y: Constants.postLabelInserts.top),
                                size: .zero)
    
    if let text = postText, !text.isEmpty {
      let width = cardViewWidth - Constants.postLabelInserts.left - Constants.postLabelInserts.right
      let height = text.height(width: width, font: Constants.postLabelFont)
      postLabelFrame.size = CGSize(width: width, height: height)
    }
    
    
    // Work with attachment frame
    let attachmentTop = postLabelFrame.size == CGSize.zero ? Constants.postLabelInserts.top : postLabelFrame.maxY + Constants.postLabelInserts.bottom
    
    var attachmentFrame = CGRect(origin: CGPoint(x: 0, y: attachmentTop),
                                 size: .zero)
    
    if let attachment = photoAttachment {
      let floatPhotoHieght: Float = Float(attachment.photoHeight)
      let floatPhotoWidth:  Float = Float(attachment.photoWidth)
      let ration = CGFloat(floatPhotoHieght / floatPhotoWidth)
      
      attachmentFrame.size = CGSize(width: cardViewWidth, height: cardViewWidth * ration)
    }
    
    // work with botton view frame
    let bottomViewTop = max(postLabelFrame.maxY, attachmentFrame.maxY)
    
    let bottomViewFrame = CGRect(origin: CGPoint(x: 0, y: bottomViewTop),
                                 size: CGSize(width: cardViewWidth, height: Constants.bottomViewHeight))
    
    // total cell frame
    let totalHeight = bottomViewFrame.maxY + Constants.cardInserts.bottom
    
    return Sizes(postLabelFrame: postLabelFrame,
                 attachmentFrame: attachmentFrame,
                 bottomView: bottomViewFrame,
                 totalHeight: totalHeight)
  }
  
}
