//
//  FeedResponse.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/1/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation

struct FeedResponseWrapped: Decodable {
  let response: FeedResponse
}

struct FeedResponse: Decodable {
  var items: [FeedItem]
  var profiles: [Profile]
  var groups: [Group]
  
}

struct FeedItem: Decodable {
  let sourceId: Int
  let postId: Int
  let text: String?
  let date: Double
  let comments: CountableItem?
  let likes: CountableItem?
  let reposts: CountableItem?
  let views: CountableItem?
  let attachments: [Attachment]?
}

struct CountableItem: Decodable {
  let count: Int
}

protocol ProfileRepresentable {
  var id:    Int    { get }
  var name:  String { get }
  var photo: String { get }
}

struct Profile: Decodable, ProfileRepresentable {
  let id: Int
  let firstName: String
  let lastName: String
  let photo100: String
  
  var name: String  { return firstName + " " + lastName}
  var photo: String { return photo100 }
}

struct Group: Decodable, ProfileRepresentable {
  let id: Int
  let name: String
  let photo100: String
  
  var photo: String { return photo100 }
}

// post Photos
struct Attachment: Decodable {
  let photo: Photo?
}

// post photos id's and Sizes
struct Photo: Decodable {
  let id: Int
  let sizes: [PhotoSize]
  
  var height: Int {
    return getPropperSizes().height
  }
  var width: Int {
    return getPropperSizes().width
  }
  
  var urlBIG: String {
    return getPropperSizes().url
  }
  
  private func getPropperSizes() -> PhotoSize {
    if let sizeX = sizes.first(where: { $0.type == "x" }) {
      return sizeX
    } else if let fallBackSize = sizes.last {
      return fallBackSize
    } else {
      return PhotoSize(type: "wrong image", url: "wrong image", width: 0, height: 0)
    }
  }
}

// Post photos sizes
struct PhotoSize: Decodable {
  let type: String
  let url: String
  let width: Int
  let height: Int
}
