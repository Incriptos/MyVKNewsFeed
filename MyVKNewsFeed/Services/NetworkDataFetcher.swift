//
//  NetworkDataFetcher.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation

protocol DataFetcher {
  func getFeed(response: @escaping (FeedResponse?) -> Void)
}

struct NetworkDataFetcher: DataFetcher {
  
  let networking: Networking
  
  init(networking: Networking) {
    self.networking = networking
  }
  
  func getFeed(response: @escaping (FeedResponse?) -> Void) {
    
    let params = ["filters": "post, photo"]
    networking.request(path: Api.newsFeed, params: params) { (data, error) in
      
      if let error = error {
        print("Error received requesting data: \(error.localizedDescription)")
        response(nil)
      }
      let decoded = self.decodeJSON(type: FeedResponseWrapped.self, from: data)
      response(decoded?.respons)
      
    }
  }
  
  private func decodeJSON<T: Decodable>(type: T.Type, from: Data?) -> T? {
    
    let decoder = JSONDecoder()
    decoder.keyDecodingStrategy = .convertFromSnakeCase
    guard let data = from, let response = try? decoder.decode(type.self, from: data) else { return nil }
    return response
  }
  
}
