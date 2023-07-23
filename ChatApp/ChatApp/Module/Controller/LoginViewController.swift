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
  
  var viewModel = LoginViewModel()
  
  private let welcomeLabel = CustomLabel(text: "HEY, WELCOME", labelFont: .boldSystemFont(ofSize: 20))
  
//  private let welcomeLabel: UILabel = {
//    let label = UILabel()
//    label.text = "HEY, WELCOME"
//    label.font = .boldSystemFont(ofSize: 20)
//    label.tintColor = .black
//    return label
//  }()
  
  private let profileImageView = CustomImageView(image: #imageLiteral(resourceName: "profile"), width: 50, height: 50)
  
//  private let profileImageView: UIImageView = {
//    let iv = UIImageView()
//    iv.image = #imageLiteral(resourceName: "profile")
//    iv.contentMode = .scaleAspectFit
//    iv.setDimensions(height: 50, width: 50)
//    return iv
//  }()
  
  private let emailTF = CustomTextField(placelolder: "Email", keyboardType: .emailAddress)
  
//  private let emailTF: UITextField = {
//    let tf = UITextField()
//    tf.tintColor = .black
//    tf.setHeight(50)
//    tf.placeholder = "Email"
//    tf.backgroundColor = .lightGray
//    tf.keyboardType = .emailAddress
//    return tf
//  }()
  
  private let passwordTF = CustomTextField(placelolder: "Password", isSecure: true)
  
//  private let passwordlTF: UITextField = {
//    let tf = UITextField()
//    tf.tintColor = .black
//    tf.setHeight(50)
//    tf.placeholder = "Password"
//    tf.backgroundColor = .lightGray
//    tf.isSecureTextEntry = true
//    return tf
//  }()
  
  // lazy var - if you add any target.
  private lazy var loginButton: UIButton = {
    let button = UIButton(type: .system)
    button.addTarget(self, action: #selector(handleLoginVC), for: .touchUpInside)
    button.blackButton(buttonText: "Login")
    return button
  }()
  
  private lazy var forgetPasswordButton: UIButton = {
    let button = UIButton(type: .system)
    button.attributedText(firstString: "Forgot your password?", secondString: "Get Help Signing in")
    button.setHeight(50)
    button.addTarget(self, action: #selector(handleForgetPassword), for: .touchUpInside)
    return button
  }()
  
  private lazy var signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.attributedText(firstString: "Don't have an account?", secondString: "Sign up")
    button.setHeight(50)
    button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
    return button
  }()
  
  private let contLabel = CustomLabel(text: "or continue with Gooble", labelFont: .systemFont(ofSize: 14))
  
//  private let contLabel: UILabel = {
//    let label = UILabel()
//    label.text = "or continue with Gooble"
//    label.textColor = .lightGray
//    label.font = .systemFont(ofSize: 14)
//    return label
//  }()
  
  private lazy var googleButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Google", for: .normal)
    button.tintColor = .white
    button.backgroundColor = .black
    button.setDimensions(height: 50, width: 150)
    button.layer.cornerRadius = 5
    button.titleLabel?.font = .boldSystemFont(ofSize: 19)
    button.addTarget(self, action: #selector(handleGoogleSignInVC), for: .touchUpInside)
    return button
  }()
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureForTextField()
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
    
    let stackView = UIStackView(arrangedSubviews: [emailTF, passwordTF, loginButton, forgetPasswordButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    
    view.addSubview(stackView)
    stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
    
    view.addSubview(signUpButton)
    signUpButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    signUpButton.centerX(inView: view)
    
    view.addSubview(contLabel)
    contLabel.centerX(inView: view, topAnchor: forgetPasswordButton.bottomAnchor, paddingTop: 30)
    
    view.addSubview(googleButton)
    googleButton.centerX(inView: view, topAnchor: contLabel.bottomAnchor, paddingTop: 12)
  }
  
  private func configureForTextField() {
    emailTF.addTarget(self, action: #selector(handleTextChanged(sender:)), for: .editingChanged)
    passwordTF.addTarget(self, action: #selector(handleTextChanged(sender:)), for: .editingChanged)
  }
  
  @objc func handleLoginVC() {
    print("Login Login")
  }
  
  @objc func handleForgetPassword() {
  }
  
  @objc func handleSignUpButton() {
    let controller = RegisterViewController()
    navigationController?.pushViewController(controller, animated: true)
  }
  
  @objc func handleGoogleSignInVC() {
  }
  
  @objc func handleTextChanged(sender: UITextField) {
    sender == emailTF ? (viewModel.email = sender.text) : (viewModel.password = sender.text)
    updateForm()
//    print(sender.text)
  }
  
  private func updateForm() {
    loginButton.isEnabled = viewModel.formIsValid
    loginButton.backgroundColor = viewModel.backgroundColor
    loginButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}
