//
//  WebImageView.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/3/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation
import UIKit


class WebImageView: UIImageView {
  
  private var currentUrlString: String?
  
  func setImageFromURL(imageURL: String?) {
    
    currentUrlString = imageURL
    
    guard let imageURL = imageURL, let url = URL(string: imageURL) else {
      self.image = nil
      return }
    
    // take images from cache.
    if let cachedRespons = URLCache.shared.cachedResponse(for: URLRequest(url: url)) {
      self.image = UIImage(data: cachedRespons.data)
      return
    }
    
    let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, respons, error) in
      
      DispatchQueue.main.async {
        if let data = data, let respons = respons {
          self?.handleLoadedImage(data: data, respons: respons)
        }
      }
    }
    dataTask.resume()
  }
  
  // func for cache images.
  private func handleLoadedImage(data: Data, respons: URLResponse) {
    guard let responsURL = respons.url else { return }
    let cachedRespons = CachedURLResponse(response: respons, data: data)
    URLCache.shared.storeCachedResponse(cachedRespons, for: URLRequest(url: responsURL))
    
    if responsURL.absoluteString == currentUrlString {
      self.image = UIImage(data: data)
    }
    
  }
}
