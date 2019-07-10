//
//  NewsFeedCodeCell.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/10/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

final class NewsFeedCodeCell: UITableViewCell {
  
  static let reuseId = "NewsFeedCodeCell"
  
  // First layer element
  let cardView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  // Secont layer element
  let topView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let postLabel: UILabel = {
    let label = UILabel()
    //label.translatesAutoresizingMaskIntoConstraints = false
    label.numberOfLines = 0
    label.font = Constants.postLabelFont
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    return label
  }()
  
  let postImageView: WebImageView = {
    let imageView = WebImageView()
    //imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return imageView
  }()
  
  let bottomView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    addFirstLayer()
    addSecondLayer()
  }
  
  func set(viewModel: FeedCellViewModel) {
    
    postLabel.frame     = viewModel.sizes.postLabelFrame
    postImageView.frame = viewModel.sizes.attachmentFrame
    bottomView.frame    = viewModel.sizes.bottomView
    
    if let photoAttachment = viewModel.photoAttachment {
      //postImageView.setImageFromURL(imageURL: photoAttachment.photoSrcString)
      postImageView.isHidden = false
    } else {
      postImageView.isHidden = true
    }
    
  }
  
  
  
  func addFirstLayer() {
    
    addSubview(cardView)
    
    // Card View Constraints
    cardView.fillSuperview(padding: Constants.cardInserts)
    
  }
  
  func addSecondLayer() {
    
    cardView.addSubview(topView)
    cardView.addSubview(postLabel)
    cardView.addSubview(postImageView)
    cardView.addSubview(bottomView)
    
    // Top View Constraints
    topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
    topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
    topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
    topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    
    // Post Label Constraints
    
    
    
    
    // Post Image View Label Constraints
    
    // Bottom View Constraints
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
