//
//  ConversationCell.swift
//  ChatApp
//
//  Created by Elizeu RS on 30/07/23.
//

import UIKit

class ConversationCell: UITableViewCell {
  
  // MARK: - Properties
  
  private let profileImageView = CustomImageView(image: #imageLiteral(resourceName: "Google_Contacts_logo copy"), width: 60, height: 60, backgroundColor: .lightGray, cornerRadius: 30)
  
  private let fullname = CustomLabel(text: "Fullname")
  private let recentMessage = CustomLabel(text: "recent message", labelColor: .lightGray)
  private let dateLabel = CustomLabel(text: "10/10/2020", labelColor: .lightGray)
  
  // MARK: - Lifecycle
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    backgroundColor = .clear
    selectionStyle = .none
    
    addSubview(profileImageView)
    profileImageView.centerY(inView: self, leftAnchor: leftAnchor)
    
    let stackView = UIStackView(arrangedSubviews: [fullname, recentMessage])
    stackView.axis = .vertical
    stackView.spacing = 7
    stackView.alignment = .leading
    
    addSubview(stackView)
    stackView.centerY(inView: profileImageView, leftAnchor: profileImageView.rightAnchor, paddingLeft: 15)
    
    addSubview(dateLabel)
    dateLabel.centerY(inView: self, rightAnchor: rightAnchor, paddingRight: 10)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
