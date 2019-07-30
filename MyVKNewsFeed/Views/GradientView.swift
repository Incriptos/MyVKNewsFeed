//
//  GradientView.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/31/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit

class GradientView: UIView {
  
  @IBInspectable private var startColor: UIColor? {
    didSet {
      setupGradientColors()
    }
  }
  @IBInspectable private var endColor: UIColor? {
    didSet {
      setupGradientColors()
    }
  }
  
  private let gradientLayer = CAGradientLayer()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
  }
  
  
  required init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    
    setupGradient()
    
    
    fatalError("init(coder:) has not been implemented")
  }
  
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
    gradientLayer.frame = bounds
    
  }
  
  private func setupGradient() {
    
    self.layer.addSublayer(gradientLayer)
    setupGradientColors()
    gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.0)
    gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
  }
  
  private func setupGradientColors() {
    if let startColor = startColor, let endColor = endColor {
      gradientLayer.colors = [startColor.cgColor, endColor.cgColor]
    }
  }
  
}
