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
    view.layer.cornerRadius = 10
    view.clipsToBounds = true
    view.translatesAutoresizingMaskIntoConstraints = false
    view.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
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
  
  // Third layer elements
  let iconImageView: WebImageView = {
    let iconView = WebImageView()
    iconView.translatesAutoresizingMaskIntoConstraints = false
    iconView.layer.cornerRadius = Constants.topViewHeight / 2
    iconView.clipsToBounds = true
    return iconView
  }()
  
  let nameLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 15)
    label.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
    
    return label
  }()
  
  let dateLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.font = UIFont.systemFont(ofSize: 12)
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    return label
  }()
  
  // Third elements BottomView
  
  let likesView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let commentsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let repostsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  let viewsView: UIView = {
    let view = UIView()
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    addFirstLayer()  // First Layer
    addSecondLayer() // Second Layer
    addThirdLayerOnTopView() // Third Layer on TopView
  }
  
  func set(viewModel: FeedCellViewModel) {
    
//    iconImageView.setImageFromURL(imageURL: viewModel.iconUrlString)
//
//    nameLabel.text      = viewModel.name
//    dateLabel.text      = viewModel.date
//    postLabel.text      = viewModel.text
    
    postLabel.frame     = viewModel.sizes.postLabelFrame
    postImageView.frame = viewModel.sizes.attachmentFrame
    bottomView.frame    = viewModel.sizes.bottomView
    
    if let photoAttachment = viewModel.photoAttachment {
     // postImageView.setImageFromURL(imageURL: photoAttachment.photoSrcString)
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
  
  private func addSecondLayer() {
    
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
  
 private func addThirdLayerOnTopView() {
    
    topView.addSubview(iconImageView)
    topView.addSubview(nameLabel)
    topView.addSubview(dateLabel)
    
    // Icon Image View Constraints
    iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
    iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
    iconImageView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    iconImageView.widthAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    
    // Name Label Constraints
    nameLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
    nameLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
    nameLabel.topAnchor.constraint(equalTo: topView.topAnchor, constant: 4).isActive = true
    nameLabel.heightAnchor.constraint(equalToConstant: Constants.topViewHeight / 2 - 2).isActive = true
    
    // Date Label Constraints
    dateLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 10).isActive = true
    dateLabel.trailingAnchor.constraint(equalTo: topView.trailingAnchor, constant: -10).isActive = true
    dateLabel.bottomAnchor.constraint(equalTo: topView.bottomAnchor, constant: -12).isActive = true
    dateLabel.heightAnchor.constraint(equalToConstant: 14).isActive = true
    
  }
  
 private func addThirdLayerOnBottomView() {
  
  bottomView.addSubview(likesView)
  bottomView.addSubview(commentsView)
  bottomView.addSubview(repostsView)
  bottomView.addSubview(viewsView)
  
  
  
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
