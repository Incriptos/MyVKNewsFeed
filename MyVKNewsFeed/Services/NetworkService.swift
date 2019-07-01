//
//  NetworkService.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation

protocol Networking {
  func request(path: String, params: [String: String], completion: (Data?, Error?) -> Void)
}

final class NetworkService {
  
  private let authService: AuthService
  init(authService: AuthService = AppDelegate.shared().authService) {
    self.authService = authService
  }
  
  
  func getFeed() {

    
    guard let token = authService.token else { return }
    let params = ["filters": "post,photo"]
    var allParams = params
    allParams["access_token"] = token
    allParams["v"] = Api.version

    let url = self.createURL(from: Api.newsFeed, params: allParams)
    
    print(url)
    
  }
  
  private func createURL(from path: String, params: [String: String]) -> URL {
    var componetns = URLComponents()
    
    componetns.scheme = Api.scheme
    componetns.host = Api.host
    componetns.path = Api.newsFeed
    componetns.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    
    return componetns.url!
  }
  
  
}
