//
//  UIViewController.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit


extension UIViewController {
  
  class func loadFromStoryboard<T: UIViewController>() -> T {
    let name = String(describing: T.self)
    let storyboard = UIStoryboard(name: name, bundle: nil)
    if let viewController = storyboard.instantiateInitialViewController() as? T {
      return viewController
    } else {
      fatalError("ERROR: NO INITIAL VIEW CONTROLLER IN \(name) STORYBOARD!")
    }
  }
  
  
}
