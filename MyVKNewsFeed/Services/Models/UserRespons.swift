//
//  UserRespons.swift
//  MyVKNewsFeed
//
//  Created by Andrew Vashulenko on 7/24/19.
//  Copyright © 2019 Andrew Vashulenko. All rights reserved.
//

import Foundation


struct UserResponseWrapped: Decodable {
  let response: [UserResponse]
}

struct UserResponse: Decodable {
  let photo100: String?
}
