//
//  NewChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 29/07/23.
//

import UIKit

class NewChatViewController: UIViewController {
  // MARK: - Properties
  private var user: User
  private let tableView = UITableView()
  private let reuseIdentifier = "UserCell"
  
  // MARK: - Lifecycle
  init(user: User) {
    self.user = user
    super.init(nibName: nil, bundle: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Lifescycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureTableView()
  }
  
  // MARK: - Helpers
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.rowHeight = 64
    tableView.backgroundColor = .systemBackground
    tableView.register(UserCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView() // Empty space add nothing.
    tableView.backgroundColor = .white
  }
  
  private func configureUI() {
    view.backgroundColor = .white
    title = "Search"
    
    view.addSubview(tableView)
    tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 15, paddingRight: 15)
  }
}

// MARK: - TableView
extension NewChatViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 10
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! UserCell
    return cell
  }
}
