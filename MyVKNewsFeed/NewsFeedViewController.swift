//
//  NewsFeedViewController.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

class NewsFeedViewController: UIViewController {

  private let networkService = NetworkService()
  
    override func viewDidLoad() {
        super.viewDidLoad()
      
      networkService.getFeed()
      
      
    }
    


}
