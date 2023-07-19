//
//  LoginViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 18/07/23.
//

import Foundation
import UIKit

class LoginViewController: UIViewController {
  //MARK: - Properties
  private let welcomeLabel: UILabel = {
    let label = UILabel()
    label.text = "HEY, WELCOME"
    label.font = .boldSystemFont(ofSize: 20)
    label.tintColor = .black
    return label
  }()
  
  private let profileImageView: UIImageView = {
    let iv = UIImageView()
    iv.image = #imageLiteral(resourceName: "profile")
    iv.contentMode = .scaleAspectFit
    iv.setDimensions(height: 50, width: 50)
    return iv
  }()
  
  private let emailTF: UITextField = {
    let tf = UITextField()
    tf.tintColor = .black
    tf.setHeight(50)
    tf.placeholder = "Email"
    tf.backgroundColor = .lightGray
    tf.keyboardType = .emailAddress
    return tf
  }()
  
  private let passwordlTF: UITextField = {
    let tf = UITextField()
    tf.tintColor = .black
    tf.setHeight(50)
    tf.placeholder = "Password"
    tf.backgroundColor = .lightGray
    tf.isSecureTextEntry = true
    return tf
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  //MARK: - Helpers
  private func configureUI() {
    view.backgroundColor = .white
    
    view.addSubview(welcomeLabel)
    welcomeLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor)
    welcomeLabel.centerX(inView: view)
    
    view.addSubview(profileImageView)
    profileImageView.anchor(top: welcomeLabel.bottomAnchor, paddingTop: 20)
    profileImageView.centerX(inView: view)
    
    let stackView = UIStackView(arrangedSubviews: [emailTF, passwordlTF])
    stackView.axis = .vertical
    stackView.spacing = 20
    
    view.addSubview(stackView)
    stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
  }
}
