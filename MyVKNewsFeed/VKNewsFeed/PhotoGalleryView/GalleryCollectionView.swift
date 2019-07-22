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
    let layout = UICollectionViewFlowLayout()
    layout.scrollDirection = .horizontal
    let rowLayout = RowLayout()
    super.init(frame: .zero, collectionViewLayout: rowLayout)
    
    delegate = self
    dataSource = self
    
    backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
    register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: GalleryCollectionViewCell.reuseId)
  }
  
  func set(photos: [FeedCellPhotoAttachmentViewModel]) {
    self.photos = photos
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
