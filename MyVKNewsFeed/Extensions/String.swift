//
//  String.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/5/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import  UIKit


extension String {
  
  func height(width: CGFloat, font: UIFont) -> CGFloat {
    
    let textSize = CGSize(width: width, height: .greatestFiniteMagnitude)
    let size = self.boundingRect(with: textSize,
                                 options: .usesLineFragmentOrigin,
                                 attributes: [NSAttributedString.Key.font : font],
                                 context: nil)
    return ceil(size.height)
  }
  
  
  
}
