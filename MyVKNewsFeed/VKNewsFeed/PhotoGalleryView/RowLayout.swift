//
//  RowLayout.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/17/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

protocol RowLayoutDelegate: class {
  func collectionView(_ collectionView: UICollectionView, photoAtIndexPath indexPath: IndexPath) -> CGSize
}

// Custom layout for Cells in  Gallery Collection View
class RowLayout: UICollectionViewLayout {
  
  weak var delegate: RowLayoutDelegate!
  
  static var numberOfRows = 1
  fileprivate var cellPadding: CGFloat = 8
  
  fileprivate var cache = [UICollectionViewLayoutAttributes]()
  
  fileprivate var contentWidth: CGFloat = 0
  
  // Constant
  fileprivate var contentHeight: CGFloat {
    
    guard let collectionView = collectionView else { return 0 }
    let insets = collectionView.contentInset
    return collectionView.bounds.height - (insets.left + insets.right)
  }
  
  override var collectionViewContentSize: CGSize {
    return CGSize(width: contentWidth, height: contentHeight)
  }
  
  override func prepare() {
    
    contentWidth = 0
    cache = []
    
    guard cache.isEmpty == true, let collectionView = collectionView else { return }
    
    // take photos
    var photo = [CGSize]()
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      let photoSize = delegate.collectionView(collectionView, photoAtIndexPath: indexPath)
      photo.append(photoSize)
    }
    
    let superviewWidth = collectionView.frame.width
    
    // take photo with the most lower frame
    guard var rowHeight = RowLayout.rowHeightCounter(superviewWidth: superviewWidth, photosArray: photo) else { return }
    
    rowHeight = rowHeight / CGFloat(RowLayout.numberOfRows)
    
    let photosRatios = photo.map { $0.height / $0.width }
    
    var YOffset = [CGFloat]()
    
    for row in 0 ..< RowLayout.numberOfRows {
      YOffset.append(CGFloat(row) * rowHeight)
    }
    
    var XOffset = [CGFloat](repeating: 0, count: RowLayout.numberOfRows)
    
    var row = 0
    
    // add for cell frames
    for item in 0 ..< collectionView.numberOfItems(inSection: 0) {
      let indexPath = IndexPath(item: item, section: 0)
      
      let ratio = photosRatios[indexPath.row]
      let width = (rowHeight / ratio)
      
      let frame = CGRect(x: XOffset[row], y: YOffset[row], width: width, height: rowHeight)
      let insetFrame = frame.insetBy(dx: cellPadding, dy: cellPadding)
      
      
      let atribute = UICollectionViewLayoutAttributes(forCellWith: indexPath)
      atribute.frame = insetFrame
      cache.append(atribute)
      contentWidth = max(contentWidth, frame.maxX)
      
      XOffset[row] = XOffset[row] + width
      row = row < (RowLayout.numberOfRows - 1) ? (row + 1) : 0
      
    }
    
  }
  
  static func rowHeightCounter(superviewWidth: CGFloat, photosArray: [CGSize]) -> CGFloat? {
    
    var rowHeight: CGFloat
    
    let photoWidthMinRatio = photosArray.min { (first, second) -> Bool in
      (first.height / first.width) < (second.height / second.width)
    }
    
    guard let currentPhotoWidthMinRatio = photoWidthMinRatio else { return nil }
    
    let difference = superviewWidth / currentPhotoWidthMinRatio.width
    rowHeight = currentPhotoWidthMinRatio.height * difference
    
    rowHeight = rowHeight * CGFloat(numberOfRows)
    return rowHeight
  }
  
  
  override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
    
    var visibleLayoutAttributes = [UICollectionViewLayoutAttributes]()
    
    for attribute in cache {
      if attribute.frame.intersects(rect) {
        visibleLayoutAttributes.append(attribute)
      }
    }
    
    return visibleLayoutAttributes
  }
  
  override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
    return cache[indexPath.row]
  }
  
}
