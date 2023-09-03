//
//  ProfileViewModel.swift
//  ChatApp
//
//  Created by Elizeu RS on 03/09/23.
//

import Foundation

// int: to add the count and caseIterable: to add all the cases.
enum ProfileField: Int, CaseIterable {
  case fullname
  case username
  case email
  
  var description: String {
    switch self {
      
    case .fullname:
      return "Fullname"
    case .username:
      return "Username"
    case .email:
      return "Email Address"
    }
  }
}

struct ProfileViewModel {
  let user: User
  
  let field: ProfileField
  
  var fieldTitle: String {
    return field.description
  }
  
  var optionType: String? {
    switch field {
      
    case .fullname:
      return user.fullname
    case .username:
      return user.username
    case .email:
      return user.email
    }
  }
  
  init(user: User, field: ProfileField) {
    self.user = user
    self.field = field
  }
}
