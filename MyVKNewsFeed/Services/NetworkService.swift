//
//  NetworkService.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation

protocol Networking {
  func request(path: String, params: [String: String], completion: @escaping (Data?, Error?) -> Void)
}

final class NetworkService: Networking {

  private let authService: AuthService
  init(authService: AuthService = AppDelegate.shared().authService) {
    self.authService = authService
  }
  
  func request(path: String, params: [String : String], completion: @escaping (Data?, Error?) -> Void) {
    
    guard let token = authService.token else { return }
    var allParams = params
    allParams["access_token"] = token
    allParams["v"] = Api.version
    let url = self.createURL(from: path, params: allParams)
    
    let request = URLRequest(url: url)
    let task = createDataTask(from: request, completion: completion)
    task.resume()
    print(url)
  }
  
  private func createDataTask(from request: URLRequest, completion: @escaping (Data?, Error?) -> Void) -> URLSessionDataTask {
    
    return URLSession.shared.dataTask(with: request, completionHandler: { (data, respons, error) in
      DispatchQueue.main.async {
        completion(data, error)
      }
    })
  }
  
  
  private func createURL(from path: String, params: [String: String]) -> URL {
    var componetns = URLComponents()
    
    componetns.scheme = Api.scheme
    componetns.host = Api.host
    componetns.path = path
    componetns.queryItems = params.map { URLQueryItem(name: $0, value: $1) }
    
    return componetns.url!
  }
  
}
