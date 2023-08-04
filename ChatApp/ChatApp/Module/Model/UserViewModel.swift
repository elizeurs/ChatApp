//
//  UserViewModel.swift
//  ChatApp
//
//  Created by Elizeu RS on 04/08/23.
//

import Foundation

struct UserViewModel {
  let user: User
  
  var fullname: String { return user.fullname }
  var username: String { return user.username }
  
  var profileImageView: URL? {
    return URL(string: user.profileImageURL)
  }
  
  init(user: User) {
    self.user = user
  }
}
