//
//  CustomInputView.swift
//  ChatApp
//
//  Created by Elizeu RS on 01/08/23.
//

import Foundation
import UIKit

protocol CustomInputViewDelegate: AnyObject {
  func inputView(_ view: CustomInputView, wantToUploadMessage message: String)
  func inputViewForAttach(_ view: CustomInputView)
}

class CustomInputView: UIView {
  
  // MARK: - Properties
  
  weak var delegate: CustomInputViewDelegate?
  
  lazy var inputTextView = InputTextView()
  
  private let postBackgroundColor: CustomImageView = {
    let tap = UITapGestureRecognizer(target: self, action: #selector(handlePostButton))
    let iv = CustomImageView(width: 40, height: 40, backgroundColor: .systemRed, cornerRadius: 20)
    iv.isUserInteractionEnabled = true
    iv.addGestureRecognizer(tap)
    iv.isHidden = true
    return iv
  }()
  
  private lazy var postButton: UIButton = {
    let button = UIButton(type: .system)
    button.setBackgroundImage(UIImage(systemName: "paperplane.fill"), for: .normal)
    button.tintColor = .white
    button.addTarget(self, action: #selector(handlePostButton), for: .touchUpInside)
    button.setDimensions(height: 28, width: 28)
    button.isHidden = true
    return button
  }()
  
  private lazy var attachButton: UIButton = {
    let button = UIButton(type: .system)
    button.setBackgroundImage(UIImage(systemName: "paperclip.circle"), for: .normal)
    button.setDimensions(height: 40, width: 40)
    button.tintColor = .red
    button.addTarget(self, action: #selector(handleAttachButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var recordButton: UIButton = {
    let button = UIButton(type: .system)
    button.setBackgroundImage(UIImage(systemName: "mic.circle"), for: .normal)
    button.setDimensions(height: 40, width: 40)
    button.tintColor = .red
    button.addTarget(self, action: #selector(handleRecordButton), for: .touchUpInside)
    return button
  }()
  
  lazy var stackView: UIStackView = {
    let stackView = UIStackView(arrangedSubviews: [inputTextView, postBackgroundColor, attachButton, recordButton])
    stackView.axis = .horizontal
    stackView.spacing = 8
    stackView.alignment = .center
    stackView.distribution = .fillProportionally
    return stackView
  }()
  
  // TODO: - Record View
  
  private lazy var cancelButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Cancel", for: .normal)
    button.setDimensions(height: 40, width: 100)
    button.addTarget(self, action: #selector(handleCancelButton), for: .touchUpInside)
    return button
  }()
  
  private lazy var sendRecordButton: UIButton = {
    let button = UIButton(type: .system)
    button.setTitle("Send", for: .normal)
    button.titleLabel?.font = .boldSystemFont(ofSize: 16)
    button.tintColor = .white
    button.backgroundColor = .systemRed
    button.setDimensions(height: 40, width: 100)
    button.layer.cornerRadius = 12
    button.clipsToBounds = true
    button.addTarget(self, action: #selector(handleSendRecordButton), for: .touchUpInside)
    return button
  }()
  
  let timerLabel = CustomLabel(text: "00:00")
  
  lazy var recordStackView: UIStackView = {
    let sv = UIStackView(arrangedSubviews: [cancelButton, timerLabel, sendRecordButton])
    sv.axis = .horizontal
    sv.alignment = .center
    sv.isHidden = true
    return sv
  }()
  
  var duration: CGFloat = 0.0
  var timer: Timer!
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    autoresizingMask = .flexibleHeight
    
    addSubview(stackView)
    stackView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, paddingLeft: 5, paddingRight: 5)
    
    addSubview(postButton)
    postButton.center(inView: postBackgroundColor)
    
    inputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: postBackgroundColor.leftAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 5, paddingRight: 8)
    
    let dividerView = UIView()
    dividerView.backgroundColor = .lightGray
    addSubview(dividerView)
    dividerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
    
    addSubview(recordStackView)
    recordStackView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 15, paddingLeft: 12, paddingRight: 12)
    
    NotificationCenter.default.addObserver(self, selector: #selector(handleTextDidChange), name: InputTextView.textDidChangeNotification, object: nil)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  // MARK: - Helpers
  @objc func handlePostButton() {
    delegate?.inputView(self, wantToUploadMessage: inputTextView.text)
  }
  
  func clearTextView() {
    inputTextView.text = ""
    inputTextView.placeHolderLabel.isHidden = false
  }
  
  @objc func handleAttachButton() {
    delegate?.inputViewForAttach(self)
  }
  
  @objc func handleRecordButton() {
    stackView.isHidden = true
    recordStackView.isHidden = false
    
    setTimer()
  }
  
  @objc func handleTextDidChange() {
    let isTextEmpty = inputTextView.text.isEmpty || inputTextView.text == ""
    postButton.isHidden = isTextEmpty
    postBackgroundColor.isHidden = isTextEmpty
    
    attachButton.isHidden = !isTextEmpty
    recordButton.isHidden = !isTextEmpty
//    print(inputTextView.text)
  }
}
