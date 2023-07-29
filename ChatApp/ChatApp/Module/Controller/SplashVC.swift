//
//  SplashVC.swift
//  ChatApp
//
//  Created by Elizeu RS on 28/07/23.
//

import UIKit
import Firebase

class SplashVC: UIViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
  }
  
  override func viewDidAppear(_ animated: Bool) {
    super.viewDidAppear(animated)
    if Auth.auth().currentUser?.uid == nil {
      let controller = LoginViewController()
      let nav = UINavigationController(rootViewController: controller)
      nav.modalPresentationStyle = .fullScreen
      present(nav, animated: true)
    } else {
      guard let uid = Auth.auth().currentUser?.uid else { return }
      showLoader(true)
      UserServices.fetchUser(uid: uid) { [self] user in
        let controller = ConversationViewController(user: user)
        let nav = UINavigationController(rootViewController: controller)
        nav.modalPresentationStyle = .fullScreen
        present(nav, animated: true, completion: nil)
      }
    }
  }
}

