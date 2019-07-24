//
//  TitleView.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/24/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

protocol TitleViewViewModel {
  var photoUrlString: String? { get }
}

class TitleView: UIView {
  
  private var avatarImageView: WebImageView = {
    let imageView = WebImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.backgroundColor = #colorLiteral(red: 1, green: 0.5212053061, blue: 1, alpha: 1)
    imageView.clipsToBounds = true
    return imageView
  }()
  
 private var searchTextField = InsertableTextField()
  
 override init(frame: CGRect) {
  super.init(frame: frame)
  
  translatesAutoresizingMaskIntoConstraints = false
  
  addSubview(searchTextField)
  addSubview(avatarImageView)
//  makeConstraints()
  
  }
  
  func set(userViewModel: TitleViewViewModel) {
    avatarImageView.setImageFromURL(imageURL: userViewModel.photoUrlString)
  }
  
  private func makeConstraints() {
    
    avatarImageView.anchor(top: topAnchor,
                           leading: nil,
                           bottom: nil,
                           trailing: trailingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 7777, bottom: 7777, right: 4))
    
    avatarImageView.heightAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
    avatarImageView.widthAnchor.constraint(equalTo: searchTextField.heightAnchor, multiplier: 1).isActive = true
    
    
    searchTextField.anchor(top: topAnchor,
                           leading: leftAnchor,
                           bottom: bottomAnchor,
                           trailing: avatarImageView.leadingAnchor,
                           padding: UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 12))
    
  }
  
  override var intrinsicContentSize: CGSize {
    return UIView.layoutFittingExpandedSize
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    avatarImageView.layer.masksToBounds = true
    avatarImageView.layer.cornerRadius = avatarImageView.frame.width / 2
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
