//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 18/07/23.
//

import Foundation
import UIKit

class RegisterViewController: UIViewController {
  
  //MARK: - Properties
  var viewModel = RegViewModel()
  
  private lazy var alreadyHaveAccountButton: UIButton = {
    let button = UIButton(type: .system)
    button.attributedText(firstString: "Already have an account?", secondString: "Login")
    button.setHeight(50)
    button.addTarget(self, action: #selector(handleAlreadyHaveAccountButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var plusPhotoButton: UIButton = {
    let button = UIButton(type: .system)
    button.setImage(UIImage(named: "plus_photo"), for: .normal)
    button.setDimensions(height: 140, width: 140)
    button.tintColor = .lightGray
    button.addTarget(self, action: #selector(handlePlusPhotoButton), for: .touchUpInside)
    return button
  }()
  
  private let emailTF = CustomTextField(placelolder: "Email", keyboardType: .emailAddress)
  
  private let passwordTF = CustomTextField(placelolder: "Password", isSecure: true)
  
  private let fullnameTF = CustomTextField(placelolder: "Fullname")
  
  private let usernameTF = CustomTextField(placelolder: "Username")
  
  private lazy var signUpButton: UIButton = {
    let button = UIButton(type: .system)
    button.blackButton(buttonText: "Sign up")
    button.addTarget(self, action: #selector(handleSignUpButton), for: .touchUpInside)
    return button
  }()
  
  
  //MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    configureTextField()
  }
  
  //MARK: - Helpers
  private func configureUI() {
    view.backgroundColor = .white
    
    view.addSubview(alreadyHaveAccountButton)
    alreadyHaveAccountButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
    alreadyHaveAccountButton.centerX(inView: view)
    
    view.addSubview(plusPhotoButton)
    plusPhotoButton.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 30)
    
    let stackView = UIStackView(arrangedSubviews: [emailTF, passwordTF, fullnameTF, usernameTF, signUpButton])
    stackView.axis = .vertical
    stackView.spacing = 20
    
    view.addSubview(stackView)
    stackView.anchor(top: plusPhotoButton.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 30, paddingLeft: 30, paddingRight: 30)
  }
  
  private func configureTextField() {
    emailTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
    passwordTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
    fullnameTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
    usernameTF.addTarget(self, action: #selector(handleTextField(sender:)), for: .editingChanged)
  }
  
  @objc func handleAlreadyHaveAccountButton() {
    navigationController?.popViewController(animated: true)
  }
  
  @objc func handlePlusPhotoButton() {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    present(picker, animated: true, completion: nil)
  }
  
  @objc func handleSignUpButton() {
    print("Signup Signup")
  }
  
  @objc func handleTextField(sender: UITextField) {
    if sender == emailTF {
      viewModel.email = sender.text
    } else if sender == passwordTF {
      viewModel.password = sender.text
    } else if sender == fullnameTF {
      viewModel.fullname = sender.text
    } else {
      viewModel.username = sender.text
    }
    
    updateForm()
  }
  
  private func updateForm() {
    signUpButton.isEnabled = viewModel.formIsValid
    signUpButton.backgroundColor = viewModel.backgroundColor
    signUpButton.setTitleColor(viewModel.buttonTitleColor, for: .normal)
  }
}
extension RegisterViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    
    guard let selectedImage = info[.editedImage] as? UIImage else { return }
    
    plusPhotoButton.layer.cornerRadius = plusPhotoButton.frame.width / 2
    plusPhotoButton.layer.masksToBounds = true
    plusPhotoButton.layer.borderColor = UIColor.black.cgColor
    plusPhotoButton.layer.borderWidth = 2
    plusPhotoButton.setImage(selectedImage.withRenderingMode(.alwaysOriginal), for: .normal)
    
//    print("Captured")
    
    dismiss(animated: true, completion: nil)
  }
}
