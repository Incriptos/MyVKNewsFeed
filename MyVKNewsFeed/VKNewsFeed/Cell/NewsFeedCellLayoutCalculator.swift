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
  var postLabelFrame: CGRect
  var attachmentFrame: CGRect
}

final class FeedCellLayoutCalculator: FeedCellLayoutCalculatorProtocol {
  
  private let screenWidth: CGFloat
  
  init(screenWidth: CGFloat = min(UIScreen.main.bounds.width, UIScreen.main.bounds.height)) {
    self.screenWidth = screenWidth
  }
  
  func sizesForCell(postText: String?, photoAttachment: FeedCellPhotoAttachmentViewModel?) -> FeedCellSizes {
    
    
    return Sizes(postLabelFrame: CGRect.zero, attachmentFrame: CGRect.zero)
  }
  
}
