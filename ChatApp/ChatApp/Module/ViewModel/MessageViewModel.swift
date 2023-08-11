//
//  MessageViewModel.swift
//  ChatApp
//
//  Created by Elizeu RS on 07/08/23.
//

import Foundation
import UIKit

struct MessageViewModel {
  let message: Message
  
  var messageText: String { return message.text }
  var messageBackgroundColor: UIColor { return message.isFromCurrentUser ? #colorLiteral(red: 0.4800121784, green: 0.8494915962, blue: 0.5058159828, alpha: 1) : #colorLiteral(red: 0.9245408177, green: 0.9278380275, blue: 0.9309870005, alpha: 1) }
  var messageColor: UIColor { return message.isFromCurrentUser ? .white : .black }
  
  var unReadCount: Int { return message.new_msg }
  var shouldHideUnreadLabel: Bool { return message.new_msg == 0 }
  
  var fullname: String { return message.fullname }
  var username: String { return message.username }
  
  var rightAnchorActive: Bool { return message.isFromCurrentUser }
  var leftAnchorActive: Bool { return !message.isFromCurrentUser }
  var shouldHideProfileImage: Bool { return message.isFromCurrentUser }
  
  var  profileImageURL: URL? { return URL(string: message.profileImageURL) }
  
  var timestampString: String? {
    let date = message.timestamp.dateValue()
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "hh:mm a"
    return dateFormatter.string(from: date)
  }
  
  init(message: Message) {
    self.message = message
  }
}
