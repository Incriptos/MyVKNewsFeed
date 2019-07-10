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
  
  let cardView: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9995340705, green: 0.988355577, blue: 0.4726552367, alpha: 1)
    view.translatesAutoresizingMaskIntoConstraints = false
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    addSubview(cardView)
    
    
    backgroundColor = #colorLiteral(red: 0.6000000238, green: 0.6000000238, blue: 0.6000000238, alpha: 1)
    
    // cardView Constraints
    cardView.anchor(top: topAnchor,
                    leading: leadingAnchor,
                    bottom: nil,
                    trailing: nil,
                    padding: UIEdgeInsets(top: 8, left: 8, bottom: 777, right: 777),
                    size: CGSize(width: 40, height: 40))
    
    
  }
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
