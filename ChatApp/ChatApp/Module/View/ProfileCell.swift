//
//  ProfileCell.swift
//  ChatApp
//
//  Created by Elizeu RS on 02/09/23.
//

import UIKit

class ProfileCell: UITableViewCell {
  
  // MARK: - Properties
  
  private let titleLabel = CustomLabel(text: "Name", labelColor: .red)
  private let userLabel = CustomLabel(text: "Oprah")
  
  // MARK: - Lifecycle

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let stackView = UIStackView(arrangedSubviews: [titleLabel, userLabel])
    stackView.axis = .vertical
    stackView.spacing = 10
    stackView.alignment = .leading
    
    addSubview(stackView)
    stackView.centerY(inView: self, leftAnchor: leftAnchor, paddingLeft: 20)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  
  // MARK: - Helpers

}
