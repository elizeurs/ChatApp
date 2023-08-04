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
  private let tableView = UITableView()
  private let reuseIdentifier = "ConversationCell"
  
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
    configureTableView()
  }
  
  // MARK: - Helpers
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 80
    tableView.backgroundColor = .systemBackground
    tableView.register(ConversationCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView() // Empty space add nothing.
  }
  
  private func configureUI() {
    title = user.fullname
//    title = "Conversation"
    view.backgroundColor = .white
    
    let logoutBarButton = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(handleLogout))
    let newConversationBarButton = UIBarButtonItem(barButtonSystemItem: .compose, target: self, action: #selector(handleNewChat))
    
    navigationItem.leftBarButtonItem = logoutBarButton
    navigationItem.rightBarButtonItem = newConversationBarButton
    
    view.addSubview(tableView)
    tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 15, paddingRight: 15)

  }
  
  @objc func handleLogout() {
    do {
      try Auth.auth().signOut()
      
      dismiss(animated: true, completion: nil)
    } catch {
      print("Error sign out")
    }
  }
  
  @objc func handleNewChat() {
    let controller = NewChatViewController()
    controller.delegate = self
    let nav = UINavigationController(rootViewController: controller)
    present(nav, animated: true, completion: nil)
  }
  
  private func openChat(user: User) {
    let controller = ChatViewController(otherUser: user)
    navigationController?.pushViewController(controller, animated: true)
  }
}

// MARK: - TableView
extension ConversationViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ConversationCell
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

  }
}

// MARK: - NewChatViewControllerDelegate

extension ConversationViewController: NewChatViewControllerDelegate {
  func controller(_ vc: NewChatViewController, wantToChatWithUser otherUser: User) {
    vc.dismiss(animated: true, completion: nil)
    print(otherUser.fullname)
    openChat(user: otherUser)
  }
}
