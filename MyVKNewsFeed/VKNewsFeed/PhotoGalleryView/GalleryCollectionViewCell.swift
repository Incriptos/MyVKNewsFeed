//
//  GalleryCollectionViewCell.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/15/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
  
 static let reuseId = "GalleryCollectionViewCell"
  
  let imageView: WebImageView = {
    let imageView = WebImageView()
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFill
    imageView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(imageView)
    
    // Constr
    imageView.fillSuperview()
  }

  override func layoutSubviews() {
    super.layoutSubviews()
    
    imageView.layer.masksToBounds = true
    imageView.layer.cornerRadius = 10
    self.layer.shadowRadius = 3
    layer.shadowOpacity = 0.4
    layer.shadowOffset = CGSize(width: 2.5, height: 4)
    
  }
  
  override func prepareForReuse() {
    imageView.image = nil
  }
  
  func set(imageUrl: String?) {
    imageView.setImageFromURL(imageURL: imageUrl)
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
