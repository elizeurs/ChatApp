//
//  VC.swift
//  ChatApp
//
//  Created by Elizeu RS on 26/07/23.
//

import UIKit
import JGProgressHUD

extension UIViewController {
  static let hud = JGProgressHUD(style: .dark)
  
  func showLoader(_ show: Bool) {
    view.endEditing(true)
    
    if show {
      UIViewController.hud.show(in: view)
    } else {
      UIViewController.hud.dismiss()
    }
  }
  
  func showMessage(title: String, message: String, completion: (() -> Void)? = nil ) {
    let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { _ in
      completion?()
    }))
    
    present(alert, animated: true, completion: nil)
  }
}
