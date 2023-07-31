//
//  ChatCell.swift
//  ChatApp
//
//  Created by Elizeu RS on 31/07/23.
//

import UIKit

class ChatCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  private let profileImageView = CustomImageView(width: 30, height: 30, backgroundColor: .lightGray, cornerRadius: 15)
  
  private let dateLabel = CustomLabel(text: "10/10/2020")
  
  private let bubbleContainer: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9245408177, green: 0.9278380275, blue: 0.9309870005, alpha: 1)
    return view
  }()
  
  var bubbleRightAnchor: NSLayoutConstraint!
  var bubbleLeftAnchor: NSLayoutConstraint!
  
  private let textView: UITextView = {
    let tf = UITextView()
    tf.backgroundColor = .clear
    tf.isEditable = false
    tf.isScrollEnabled = false
    tf.font = .systemFont(ofSize: 16)
    return tf
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(profileImageView)
    profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 10)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
