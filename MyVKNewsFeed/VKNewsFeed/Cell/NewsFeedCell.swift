//
//  NewsFeedCell.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/2/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

protocol FeedCellViewModel {
  var iconUrlString: String  { get }
  var name:          String  { get }
  var date:          String  { get }
  var text:          String? { get }
  var likes:         String? { get }
  var comments:      String? { get }
  var reposts:       String? { get }
  var views:         String? { get }
}

class NewsFeedCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: WebImageView!
  @IBOutlet weak var nameLabel:     UILabel!
  @IBOutlet weak var dateLabel:     UILabel!
  @IBOutlet weak var postLabel:     UILabel!
  @IBOutlet weak var likesLabel:    UILabel!
  @IBOutlet weak var repostsLabel:  UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var viewsLabel:    UILabel!
  
  static let reuseId = "NewsFeedCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
  func set(viewModel: FeedCellViewModel) {
    iconImageView.setImageFromURL(imageURL: viewModel.iconUrlString)
    nameLabel.text     = viewModel.name
    dateLabel.text     = viewModel.date
    postLabel.text     = viewModel.text
    likesLabel.text    = viewModel.likes
    commentsLabel.text = viewModel.comments
    repostsLabel.text  = viewModel.reposts
    viewsLabel.text    = viewModel.views
    
  }
  
}
