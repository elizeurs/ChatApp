//
//  MessageServices.swift
//  ChatApp
//
//  Created by Elizeu RS on 05/08/23.
//

import Foundation
import Firebase

struct MessageServices {
  static func fetchMessages() {
    
  }
  
  static func fetchRecentMessages() {
    
  }
  
  static func uploadMessage(message: String, currentUser: User, otherUser: User, completion: ((Error?) -> Void)?) {
    let dataFrom: [String: Any] = [
      "text": message,
      "fromID": currentUser.uid,
      "toID": otherUser.uid,
      "timestamp": Timestamp(date: Date()),
      
      "username": otherUser.username,
      "fullname": otherUser.fullname,
      "profileImageURL": otherUser.profileImageURL
    ]
    
    let dataTo: [String: Any] = [
      "text": message,
      "fromID": currentUser.uid,
      "toID": otherUser.uid,
      "timestamp": Timestamp(date: Date()),
      
      "username": currentUser.username,
      "fullname": currentUser.fullname,
      "profileImageURL": currentUser.profileImageURL
    ]
    
    Collection_Message.document(currentUser.uid).collection(otherUser.uid).addDocument(data: dataFrom) { _ in
      Collection_Message.document(otherUser.uid).collection(currentUser.uid).addDocument(data: dataTo, completion: completion)
      Collection_Message.document(currentUser.uid).collection("recent-message").document(otherUser.uid).setData(dataFrom)
      Collection_Message.document(otherUser.uid).collection("recent-message").document(currentUser.uid).setData(dataTo)
    }
  }
}
