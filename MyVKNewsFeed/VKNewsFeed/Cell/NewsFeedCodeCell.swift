//
//  NewsFeedCodeCell.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/10/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

protocol NewsFeedCodeCellDelegate: class {
  func fullSizePost(for cell: NewsFeedCodeCell)
}

final class NewsFeedCodeCell: UITableViewCell {
  
  static let reuseId = "NewsFeedCodeCell"
  
  weak var delegete: NewsFeedCodeCellDelegate?
  
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
  
  let moreTextButton: UIButton = {
    let button = UIButton()
    button.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .medium)
    button.setTitleColor(#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1), for: .normal)
    button.contentHorizontalAlignment = .left
    button.contentVerticalAlignment = .center
    button.setTitle("Показать полностью...", for: .normal)
    return button
  }()
  
  let postImageView: WebImageView = {
    let imageView = WebImageView()
    //imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return imageView
  }()
  
  let bottomView: UIView = {
    let view = UIView()
    //view.translatesAutoresizingMaskIntoConstraints = false
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
  
  // Fours layer on Bottom View
  var likesImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "like")
    return imageView
  }()
  
  var commentsImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "comment")
    return imageView
  }()
  
  var repostsImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "repost")
    return imageView
  }()
  
  var viewsImage: UIImageView = {
    let imageView = UIImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.image = UIImage(named: "views")
    return imageView
  }()
  
  var likesLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.lineBreakMode = NSLineBreakMode.byClipping
    return label
  }()
  
  var commentsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.lineBreakMode = NSLineBreakMode.byClipping
    return label
  }()
  
  var repostsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.lineBreakMode = NSLineBreakMode.byClipping
    return label
  }()
  
  var viewsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.textColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
    label.lineBreakMode = NSLineBreakMode.byClipping
    return label
  }()
  
  override func prepareForReuse() {
    iconImageView.setImageFromURL(imageURL: nil)
    postImageView.setImageFromURL(imageURL: nil)
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    selectionStyle = .none
    
    moreTextButton.addTarget(self, action: #selector(moreTextButtonTapped), for: .touchUpInside)
    
    
    addAllLayers()
  }
  
  @objc private func moreTextButtonTapped() {
    delegete?.fullSizePost(for: self)
  }
  
  
  func set(viewModel: FeedCellViewModel) {
    
    iconImageView.setImageFromURL(imageURL: viewModel.iconUrlString)
    
    nameLabel.text      = viewModel.name
    dateLabel.text      = viewModel.date
    postLabel.text      = viewModel.text
    likesLabel.text     = viewModel.likes
    commentsLabel.text  = viewModel.comments
    repostsLabel.text   = viewModel.reposts
    viewsLabel.text     = viewModel.views
    
    postLabel.frame     = viewModel.sizes.postLabelFrame
    postImageView.frame = viewModel.sizes.attachmentFrame
    bottomView.frame    = viewModel.sizes.bottomView
    moreTextButton.frame = viewModel.sizes.moreTextButtonFrame
    
    if let photoAttachment = viewModel.photoAttachment {
      postImageView.setImageFromURL(imageURL: photoAttachment.photoSrcString)
      postImageView.isHidden = false
    } else {
      postImageView.isHidden = true
    }
    
  }
  
  private func addAllLayers() {
    addFirstLayer()  // First Layer
    addSecondLayer() // Second Layer
    addThirdLayerOnTopView() // Third Layer on TopView
    addThirdLayerOnBottomView() // Third layer on BottomView
    addFoursLayerOnBottomView() // Fours layer on BottomView
  }
  
 private func addFirstLayer() {
    
    addSubview(cardView)
    
    // Card View Constraints
    cardView.fillSuperview(padding: Constants.cardInserts)
    
  }
  
  private func addSecondLayer() {
    
    cardView.addSubview(topView)
    cardView.addSubview(postLabel)
    cardView.addSubview(postImageView)
    cardView.addSubview(bottomView)
    cardView.addSubview(moreTextButton)
    
    // Top View Constraints
    topView.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 10).isActive = true
    topView.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -10).isActive = true
    topView.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 10).isActive = true
    topView.heightAnchor.constraint(equalToConstant: Constants.topViewHeight).isActive = true
    
    // More Text Button Constraints
    // Не нужно, так как размер задают денамически
    
    // Post Label Constraints
    // Не нужно, так как размер задают денамически
    
    // Post Image View Label Constraints
    // Не нужно, так как размер задают денамически
    
    // Bottom View Constraints
    // Не нужно, так как размер задают денамически
  }
  
 private func addThirdLayerOnTopView() {
    
    topView.addSubview(iconImageView)
    topView.addSubview(nameLabel)
    topView.addSubview(dateLabel)
    
    // Icon Image View Constraints
    iconImageView.leadingAnchor.constraint(equalTo: topView.leadingAnchor).isActive = true
    iconImageView.topAnchor.constraint(equalTo: topView.topAnchor).isActive = true
    iconImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    iconImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
    
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
  
  // Likers View Constraints
  likesView.anchor(top: bottomView.topAnchor,
                   leading: bottomView.leadingAnchor,
                   bottom: nil,
                   trailing: nil,
                   size: CGSize(width: Constants.bottomViewViewWidth,
                                height: Constants.bottomViewViewHeight))
  
  // Comments View Constraints
  commentsView.anchor(top: bottomView.topAnchor,
                      leading: likesView.trailingAnchor,
                      bottom: nil,
                      trailing: nil,
                      size: CGSize(width: Constants.bottomViewViewWidth,
                                   height: Constants.bottomViewViewHeight))
  
  // Reposts View Constraints
  repostsView.anchor(top: bottomView.topAnchor,
                     leading: commentsView.trailingAnchor,
                     bottom: nil,
                     trailing: nil,
                     size: CGSize(width: Constants.bottomViewViewWidth,
                                  height: Constants.bottomViewViewHeight))
  
  // Views View Constraints
  viewsView.anchor(top: bottomView.topAnchor,
                   leading: nil,
                   bottom: nil,
                   trailing: bottomView.trailingAnchor,
                   size: CGSize(width: Constants.bottomViewViewWidth,
                                height: Constants.bottomViewViewHeight))
  
  }
  
  private func addFoursLayerOnBottomView() {
    likesView.addSubview(likesImage)
    likesView.addSubview(likesLabel)
    
    commentsView.addSubview(commentsImage)
    commentsView.addSubview(commentsLabel)
    
    repostsView.addSubview(repostsImage)
    repostsView.addSubview(repostsLabel)
    
    viewsView.addSubview(viewsImage)
    viewsView.addSubview(viewsLabel)
    
    helpForFoursLayerViews(view: likesView, imageView: likesImage, label: likesLabel)
    helpForFoursLayerViews(view: commentsView, imageView: commentsImage, label: commentsLabel)
    helpForFoursLayerViews(view: repostsView, imageView: repostsImage, label: repostsLabel)
    helpForFoursLayerViews(view: viewsView, imageView: viewsImage, label: viewsLabel)
  }
  
  private func helpForFoursLayerViews(view: UIView, imageView: UIImageView, label: UILabel) {
    
    // Image View Constraints
    imageView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
    imageView.widthAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
    imageView.heightAnchor.constraint(equalToConstant: Constants.bottomViewViewsIconSize).isActive = true
    
    // Label Constraints
    label.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 5).isActive = true
    label.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
