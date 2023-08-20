//
//  ChatCell.swift
//  ChatApp
//
//  Created by Elizeu RS on 31/07/23.
//

import UIKit

class ChatCell: UICollectionViewCell {
  
  // MARK: - Properties
  
  var viewModel: MessageViewModel? {
    didSet {
      configure()
    }
  }
  
  private let profileImageView = CustomImageView(width: 30, height: 30, backgroundColor: .lightGray, cornerRadius: 15)
  
  private let dateLabel = CustomLabel(text: "10/10/2020", labelFont: .systemFont(ofSize: 12), labelColor: .lightGray)
  
  private let bubbleContainer: UIView = {
    let view = UIView()
    view.backgroundColor = #colorLiteral(red: 0.9245408177, green: 0.9278380275, blue: 0.9309870005, alpha: 1)
    return view
  }()
  
  var bubbleRightAnchor: NSLayoutConstraint!
  var bubbleLeftAnchor: NSLayoutConstraint!
  
  var dateRightAnchor: NSLayoutConstraint!
  var dateLeftAnchor: NSLayoutConstraint!
  
  private let textView: UITextView = {
    let tf = UITextView()
    tf.backgroundColor = .clear
    tf.isEditable = false
    tf.isScrollEnabled = false
//    tf.text = "Sample Data"
    tf.font = .systemFont(ofSize: 16)
    return tf
  }()
  
  private let postImage: CustomImageView = {
    let iv = CustomImageView()
    iv.isHidden = true
    return iv
  }()
  
  private lazy var postVideo: UIButton = {
    let button = UIButton(type: .system)
    button.setBackgroundImage(UIImage(systemName: "play.circle.fill"), for: .normal)
    button.tintColor = .white
    button.isHidden = true
    button.setTitle(" Play Video", for: .normal)
    button.addTarget(self, action: #selector(handleVideoButton), for: .touchUpInside)
    button.setDimensions(height: 28, width: 28)
    button.isHidden = true
    return button
  }()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    addSubview(profileImageView)
    profileImageView.anchor(left: leftAnchor, bottom: bottomAnchor, paddingLeft: 10)
    
    addSubview(bubbleContainer)
    bubbleContainer.layer.cornerRadius = 12
    bubbleContainer.anchor(top: topAnchor, bottom: bottomAnchor)
    bubbleContainer.widthAnchor.constraint(lessThanOrEqualToConstant: 250).isActive = true
    
    bubbleContainer.addSubview(textView)
    textView.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    
    bubbleLeftAnchor = bubbleContainer.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 12)
    bubbleLeftAnchor.isActive = false
    
    bubbleRightAnchor = bubbleContainer.rightAnchor.constraint(equalTo: rightAnchor, constant: -12)
    bubbleRightAnchor.isActive = false
    
    addSubview(dateLabel)
    dateLeftAnchor = dateLabel.leftAnchor.constraint(equalTo: bubbleContainer.rightAnchor, constant: 12)
    dateLeftAnchor.isActive = false
    
    dateRightAnchor = dateLabel.rightAnchor.constraint(equalTo: bubbleContainer.leftAnchor, constant: -12)
    dateRightAnchor.isActive = false
    
    dateLabel.anchor(bottom: bottomAnchor)
    
    addSubview(postImage)
    postImage.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
    
    addSubview(postVideo)
    postImage.anchor(top: bubbleContainer.topAnchor, left: bubbleContainer.leftAnchor, bottom: bubbleContainer.bottomAnchor, right: bubbleContainer.rightAnchor, paddingTop: 4, paddingLeft: 12, paddingBottom: 4, paddingRight: 12)
  }
  
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - Helpers
  func configure() {
    guard let viewModel = viewModel else { return }
    bubbleContainer.backgroundColor = viewModel.messageBackgroundColor
    textView.text  = viewModel.messageText
    textView.textColor = viewModel.messageColor
    
    bubbleRightAnchor.isActive = viewModel.rightAnchorActive
    dateRightAnchor.isActive = viewModel.rightAnchorActive
    
    bubbleLeftAnchor.isActive = viewModel.leftAnchorActive
    dateLeftAnchor.isActive = viewModel.leftAnchorActive
    
    profileImageView.sd_setImage(with: viewModel.profileImageURL)
    profileImageView.isHidden = viewModel.shouldHideProfileImage
    
    guard let timestampString = viewModel.timestampString else { return }
    dateLabel.text = timestampString
    
    postImage.sd_setImage(with: viewModel.imageURL)
    textView.isHidden = viewModel.isTextHidden
    postImage.isHidden = viewModel.isImageHidden
    postVideo.isHidden = viewModel.isVideoHidden
    
    if !viewModel.isImageHidden {
      postImage.setHeight(200)
    }
    
//    bubbleLeftAnchor.isActive = true
//    dateLeftAnchor.isActive = true
//
//    textView.text = text
  }
  
  @objc func handleVideoButton() {
    
  }
}
