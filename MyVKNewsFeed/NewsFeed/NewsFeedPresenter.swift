//
//  NewsFeedPresenter.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright (c) 2019 Andrew Vashulenko. All rights reserved.
//

import UIKit

protocol NewsFeedPresentationLogic {
  func presentData(response: NewsFeed.Model.Response.ResponseType)
}

class NewsFeedPresenter: NewsFeedPresentationLogic {
  weak var viewController: NewsFeedDisplayLogic?
  
  func presentData(response: NewsFeed.Model.Response.ResponseType) {
  
    switch response {
   
   
    case .some:
      print(".some Presenter")
    case .presentNewsFeed:
      print(".newsFeed Presentoor")
      viewController?.displayData(viewModel: .displayNewsFeed)
    }
    
    
  }
  
}
