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
    imageView.contentMode = .scaleAspectFit
    imageView.backgroundColor = #colorLiteral(red: 0.5843137503, green: 0.8235294223, blue: 0.4196078479, alpha: 1)
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(imageView)
    
    backgroundColor = #colorLiteral(red: 0.9411764741, green: 0.4980392158, blue: 0.3529411852, alpha: 1)
  
    // Constr
    imageView.fillSuperview()
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
