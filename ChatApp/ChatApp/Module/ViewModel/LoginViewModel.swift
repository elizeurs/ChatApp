//
//  LoginViewModel.swift
//  ChatApp
//
//  Created by Elizeu RS on 20/07/23.
//

import Foundation
import UIKit

struct LoginViewModel {
  var email: String?
  var password: String?
  
  var formIsValid: Bool {
    return email?.isEmpty == false && password?.isEmpty == false
  }
  
  var backgroundColor: UIColor {
    return formIsValid ? (UIColor.black) : (UIColor.black.withAlphaComponent(0.5))
  }
  
  var buttonTitleColor: UIColor {
    return formIsValid ? (UIColor.white) : (UIColor.white.withAlphaComponent(0.7))
  }
}
