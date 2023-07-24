//
//  AuthServices.swift
//  ChatApp
//
//  Created by Elizeu RS on 24/07/23.
//

import UIKit
import Firebase

struct AuthCredential {
  let email: String
  let password: String
  let username: String
  let fullname: String
  let profileImage: UIImage
}

struct AuthServices {
  static func loginUser() {
    
  }
  
  static func registerUser(credential: AuthCredential) {
    Collection_User
}
