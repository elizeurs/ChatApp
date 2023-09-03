//
//  EditProfileViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 03/09/23.
//

import UIKit

class EditProfileViewController: UIViewController {
  
  // MARK: - Properties
  
  private let user: User
  
  private lazy var editButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Edit Profile", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 18)
    button.tintColor = .white
    button.backgroundColor = .lightGray
    button.setDimensions(height: 50, width: 200)
    button.layer.cornerRadius = 12
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(handleSubmitProfile), for: .touchUpInside)
    return button
  }()
  
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
    view.backgroundColor = .white
    
    title = "Edit Profile"
    
    view.addSubview(editButton)
    editButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingRight: 12)
  }
  
  @objc func handleSubmitProfile() {
    
  }
}
