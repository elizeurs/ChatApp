//
//  ConversationViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 25/07/23.
//

import UIKit
import Firebase

class ConversationViewController: UIViewController {
  // MARK: - Properties
  private var user: User
  
  // MARK: - Lifecycle
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Helpers
  private func configureUI() {
    title = user.fullname
//    title = "Conversation"
    view.backgroundColor = .white
    
    let logoutBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    
    navigationItem.leftBarButtonItem = logoutBarButton
  }
  
  @objc func handleLogout() {
    do {
      try Auth.auth().signOut()
      
      dismiss(animated: true, completion: nil)
    } catch {
      print("Error sign out")
    }
  }
}
