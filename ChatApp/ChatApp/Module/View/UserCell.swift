//
//  UserCell.swift
//  ChatApp
//
//  Created by Elizeu RS on 30/07/23.
//

import UIKit

class UserCell: UITableViewCell {
  
  // MARK: - Properties
  
  private let profileImageView = CustomImageView(image: #imageLiteral(resourceName: "Google_Contacts_logo copy"), width: 48, height: 48, backgroundColor: .lightGray, cornerRadius: 24)
  
  private let username = CustomLabel(text: "Username", labelFont: .boldSystemFont(ofSize: 17))
  private let fullname = CustomLabel(text: "Fullname", labelColor: .lightGray)
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    selectionStyle = .none
    
    addSubview(profileImageView)
    profileImageView.centerY(inView: self, leftAnchor: leftAnchor)
    
    let stackView = UIStackView(arrangedSubviews: [username, fullname])
    stackView.axis = .vertical
    stackView.spacing = 7
    stackView.alignment = .leading
    
    addSubview(stackView)
    stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 12)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  
}
