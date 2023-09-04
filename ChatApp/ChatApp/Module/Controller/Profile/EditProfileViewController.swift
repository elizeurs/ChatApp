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
  
  private lazy var profileImageView: CustomImageView = {
    let tap = UITapGestureRecognizer(target: self, action: #selector(handleImageTap))
    let iv = CustomImageView(width: 125, height: 125, backgroundColor: .lightGray, cornerRadius: 125 / 2)
    iv.addGestureRecognizer(tap)
    iv.contentMode = .scaleAspectFill
    iv.isUserInteractionEnabled = true
    return iv
  }()
  
  private let fullnamelbl = CustomLabel(text: "Fullname", labelColor: .red)
  private let fullnametxt = CustomTextField(placelolder: "fullname")

  private let usernamelbl = CustomLabel(text: "Username", labelColor: .red)
  private let usernametxt = CustomTextField(placelolder: "username")
  
  private lazy var imagePicker: UIImagePickerController = {
    let picker = UIImagePickerController()
    picker.delegate = self
    picker.allowsEditing = true
    return picker
  }()
  
  var selectImage: UIImage?
  
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
    configureProfileData()
  }
  
  // MARK: - Helpers
  private func configureUI() {
    view.backgroundColor = .white
    
    title = "Edit Profile"
    
    view.addSubview(editButton)
    editButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingRight: 12)
    
    view.addSubview(profileImageView)
    profileImageView.anchor(top: editButton.bottomAnchor, paddingTop: 20)
    profileImageView.centerX(inView: view)
    
    let stackView = UIStackView(arrangedSubviews: [fullnamelbl, fullnametxt, usernamelbl, usernametxt])
    stackView.axis = .vertical
    stackView.spacing = 8
    stackView.alignment = .leading
    
    view.addSubview(stackView)
    stackView.anchor(top: profileImageView.bottomAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 20, paddingLeft: 30, paddingRight: 30)
    
    fullnametxt.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
    
    usernametxt.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
  }
  
  private func configureProfileData() {
    fullnametxt.text = user.fullname
    usernametxt.text = user.username
    
    profileImageView.sd_setImage(with: URL(string: user.profileImageURL))

  }
  
  @objc func handleSubmitProfile() {
    if selectImage == nil {
      // update the data without image
    } else {
      // update with the image
    }
  }
  
  @objc func handleImageTap() {
    present(imagePicker, animated: true)
  }
}

// MARK: - UIImagePickerControllerDelegate
extension EditProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    guard let image = info[.editedImage] as? UIImage else { return }
    
    self.selectImage = image
    self.profileImageView.image = image
    
    dismiss(animated: true)
  }
}
