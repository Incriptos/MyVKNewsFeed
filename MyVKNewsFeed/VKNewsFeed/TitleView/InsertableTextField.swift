//
//  InsertableTextField.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/24/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit


class InsertableTextField: UITextField {
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    translatesAutoresizingMaskIntoConstraints = false
    backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    placeholder = "Поиск"
    font = UIFont.systemFont(ofSize: 14)
    clearButtonMode = .whileEditing
    borderStyle = .none
    layer.cornerRadius = 10
    layer.masksToBounds = true
    
    let image = UIImage(named: "search")
    leftView = UIImageView(image: image)
    leftView?.frame = CGRect(x: 0, y: 0, width: 14, height: 14)
    leftViewMode = .always
    
  }
  
  override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
  
  override func textRect(forBounds bounds: CGRect) -> CGRect {
    return bounds.insetBy(dx: 36, dy: 0)
  }
  
  override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
    var rect = super.leftViewRect(forBounds: bounds)
    rect.origin.x += 12
    return rect
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
