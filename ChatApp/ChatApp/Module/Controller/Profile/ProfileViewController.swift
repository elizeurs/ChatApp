//
//  ProfileViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 02/09/23.
//

import UIKit

class ProfileViewController: UIViewController {
  
  // MARK: - Properties
  
  private let user: User
  
  private let profileImageView = CustomImageView(backgroundColor: .lightGray, cornerRadius: 20)
  
  private let tableView = UITableView()
  private let reuseIdentifier = "ProfileCell"
  
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
    configureData()
  }
  
  // MARK: - Helpers
  
  private func configureUI() {
    title = "My Profile"
    view.backgroundColor = .white
    
    view.addSubview(profileImageView)
    profileImageView.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
    profileImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.4).isActive = true
    profileImageView.heightAnchor.constraint(equalTo: profileImageView.widthAnchor, multiplier: 1).isActive = true
    
    view.addSubview(tableView)
    tableView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingTop: 25, paddingLeft: 20, paddingBottom: 25, paddingRight: 20)
  }
  
  private func configureTableView() {
    tableView.delegate = self
    tableView.dataSource = self
    tableView.register(ProfileCell.self, forCellReuseIdentifier: reuseIdentifier)
    tableView.tableFooterView = UIView()
    tableView.rowHeight = 70
    tableView.showsVerticalScrollIndicator = false
  }
  
  private func configureData() {
    tableView.reloadData()
    guard let imageURL = URL(string: user.profileImageURL) else { return }
    profileImageView.sd_setImage(with: imageURL)
    profileImageView.contentMode = .scaleAspectFill
  }
}

// MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return ProfileField.allCases.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! ProfileCell
    
    guard let field = ProfileField(rawValue: indexPath.row) else { return cell }
    cell.viewModel = ProfileViewModel(user: user, field: field)
    
    return cell
  }
}
