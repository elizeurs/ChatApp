//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 31/07/23.
//

import Foundation
import UIKit
import SwiftAudioPlayer

class ChatViewController: UICollectionViewController {
  // MARK: - Properties
  private let reuseIdentifier = "ChatCell"
  private let chatHeaderIdentifier = "ChatHeader"
  private var messages = [[Message]]()
//  private var messages: [Message] = []
  
//  private var messages: [String] = [
//    "Here's some sample data",
//    "This is the second line with more than one line",
//    "Just want to add more text for testing or whatever and that's it for this lesson."
//  ]
  
  private lazy var customInputView: CustomInputView = {
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    let iv = CustomInputView(frame: frame)
    iv.delegate = self
    return iv
  }()
  
  lazy var imagePicker: UIImagePickerController = {
    let picker = UIImagePickerController()
    picker.allowsEditing = true
    picker.delegate = self
    return picker
  }()
  
  private lazy var attachAlert: UIAlertController = {
    let alert = UIAlertController(title: "Attach File", message: "Select the button you want to attach from", preferredStyle: .actionSheet)
    alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
      self.handleCamera()
    }))
    
    alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
      self.handleGallery()
    }))
    
    alert.addAction(UIAlertAction(title: "Location", style: .default, handler: { _ in
      print("location")
    }))
    
    alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
    return alert
  }()
  
  var currentUser: User
  var otherUser: User
  
  // MARK: - Lifecycle
  
  init(currentUser: User, otherUser: User) {
    self.currentUser = currentUser
    self.otherUser = otherUser
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
    
    collectionView.register(ChatHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: chatHeaderIdentifier)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  // MARK: - View did load
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
    fetchMessages()
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
      self.markReadAllMsg()
    }
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)
    markReadAllMsg()
  }
  
  override var inputAccessoryView: UIView? {
    get { return customInputView }
  }
  
  override var canBecomeFirstResponder: Bool {
    return true
  }
  
  // MARK: - Helpers
  
  private func configureUI() {
    title = otherUser.fullname
    collectionView.backgroundColor = .white
    
    collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
    
    // hide keyboard, when scrolling.
    collectionView.alwaysBounceVertical = true
    collectionView.keyboardDismissMode = .onDrag
    
    // pin date header on top of the screen.
    let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
    layout?.sectionHeadersPinToVisibleBounds = true
  }
  
  private func fetchMessages() {
    MessageServices.fetchMessages(otherUser: otherUser) { messages in
//      self.messages = messages
      
      let groupMessages = Dictionary(grouping: messages) { (element) -> String in
        let dateValue = element.timestamp.dateValue()
        let stringDateValue = self.stringValue(forDate: dateValue)
        return stringDateValue ?? ""
      }
      
      // to avoid duplicate
      self.messages.removeAll()
      
      let sortedKeys = groupMessages.keys.sorted(by: {$0 < $1})
      sortedKeys.forEach { key in
        let values = groupMessages[key]
        self.messages.append(values ?? [])
      }
      
      self.collectionView.reloadData()
      //scroll to the bottom
      self.collectionView.scrollToLastItem()
//      print(messages)
    }
  }
  
  private func markReadAllMsg() {
    MessageServices.markReadAllMsg(otherUser: otherUser)
  }
}

extension ChatViewController {
  override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    if kind == UICollectionView.elementKindSectionHeader {
      guard let firstMessage = messages[indexPath.section].first else { return UICollectionReusableView() }
      
      let dateValue = firstMessage.timestamp.dateValue()
      let stringValue = stringValue(forDate: dateValue)
      
      let cell = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: chatHeaderIdentifier, for: indexPath) as! ChatHeader
      cell.dateValue = stringValue
      return cell
    }
    
    return UICollectionReusableView()
  }
  
  override func numberOfSections(in collectionView: UICollectionView) -> Int {
    return messages.count
  }
  
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return messages[section].count
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
    let message = messages[indexPath.section][indexPath.row]
    cell.viewModel = MessageViewModel(message: message)
    cell.delegate = self
//    let text = messages[indexPath.row]
//    cell.configure(text: text)
    return cell
    
//    return UICollectionViewCell()
  }
}

// MARK: - Delegate Flow Layout

extension ChatViewController: UICollectionViewDelegateFlowLayout {
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
    return .init(top: 15, left: 0, bottom: 15, right: 0)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 50)
    let cell = ChatCell(frame: frame)
    let message = messages[indexPath.section][indexPath.row]
    cell.viewModel = MessageViewModel(message: message)
    
//    let text = messages[indexPath.row]
//    cell.configure(text: text)
    cell.layoutIfNeeded()
    
    let targetSize = CGSize(width: view.frame.width, height: 1000)
    let estimateSize = cell.systemLayoutSizeFitting(targetSize)
    
    return .init(width: view.frame.width, height: estimateSize.height)
  }
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
    return CGSize(width: view.frame.width, height: 50)
  }
}

// MARK: - CustomInputViewDelegate

extension ChatViewController: CustomInputViewDelegate {
  
  func inputViewForAttach(_ view: CustomInputView) {
    present(attachAlert, animated: true)
  }
  
  func inputView(_ view: CustomInputView, wantToUploadMessage message: String) {
    MessageServices.FetchSingleRecentMsg(otherUser: otherUser) { [self] unReadCount in
      //      print(message)
      MessageServices.uploadMessage(message: message, currentUser: currentUser, otherUser: otherUser, unReadCount: unReadCount + 1) { _ in
        
        self.collectionView.reloadData()
      }
    }
    
    view.clearTextView()
  }
  
  func inputViewForAudio(_ view: CustomInputView, audioURL: URL) {
    self.showLoader(true)
    FileUploader.uploadAudio(audioURL: audioURL) { audioString in
      MessageServices.FetchSingleRecentMsg(otherUser: self.otherUser) { unReadCount in
        MessageServices.uploadMessage(audioURL: audioString, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadCount + 1) { error in
          self.showLoader(false)
          if let error = error {
            print("\(error.localizedDescription)")
            return
          }
        }
      }
    }
  }
}
