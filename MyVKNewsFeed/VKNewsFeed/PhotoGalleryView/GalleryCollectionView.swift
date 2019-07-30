//
//  GalleryCollectionView.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/15/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

class GalleryCollectionView: UICollectionView {
  
  var photos = [FeedCellPhotoAttachmentViewModel]()
  
  init() {
//    let layout = UICollectionViewFlowLayout()
//    layout.scrollDirection = .horizontal
    let rowLayout = RowLayout()
    super.init(frame: .zero, collectionViewLayout: rowLayout)
    
    delegate = self
    dataSource = self
    
    backgroundColor = UIColor.white
    
    showsHorizontalScrollIndicator = false
    showsVerticalScrollIndicator = false
    
    register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
    
    if let rowLayout = collectionViewLayout as? RowLayout {
      rowLayout.delegate = self
    }
  }
  
  func set(photos: [FeedCellPhotoAttachmentViewModel]) {
    self.photos = photos
    contentOffset = CGPoint.zero
    reloadData()
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

// MARK: - UICollectionViewDelegate

extension GalleryCollectionView: UICollectionViewDelegate {
  
}

// MARK: - UICollectionViewDataSource

extension GalleryCollectionView: UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return photos.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = dequeueReusableCell(withReuseIdentifier: GalleryCollectionViewCell.reuseId, for: indexPath) as! GalleryCollectionViewCell
    
    cell.set(imageUrl: photos[indexPath.row].photoSrcString)
    
    return cell
  }
  
}

// MARK: - UICollectionViewDelegateFlowLayout

extension GalleryCollectionView: UICollectionViewDelegateFlowLayout {
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: frame.width, height: frame.height)
  }
  
}

// MARK: - RowLayoutDelegate

extension GalleryCollectionView: RowLayoutDelegate {
  
  
  func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize {
    
    let width = photos[indexPath.row].photoWidth
    let height = photos[indexPath.row].photoWidth
    
    return CGSize(width: width, height: height)
    
  }

}
