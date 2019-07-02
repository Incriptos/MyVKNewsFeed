//
//  NewsFeedCell.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/2/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

class NewsFeedCell: UITableViewCell {
  
  @IBOutlet weak var iconImageView: UIImageView!
  @IBOutlet weak var nameLabel: UILabel!
  @IBOutlet weak var dateLabel: UILabel!
  @IBOutlet weak var postLabel: UILabel!
  @IBOutlet weak var likesLabel: UILabel!
  @IBOutlet weak var repostsLabel: UILabel!
  @IBOutlet weak var commentsLabel: UILabel!
  @IBOutlet weak var viewsLabel: UILabel!
  
  static let reuseId = "NewsFeedCell"
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
  }
  
}
