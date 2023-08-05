//
//  Message.swift
//  ChatApp
//
//  Created by Elizeu RS on 05/08/23.
//

import Foundation
import Firebase

struct Message {
  let text: String
  let fromID: String
  let toID: String
  let timestamp: Timestamp
  let username: String
  let fullname: String
  let profileImageURL: String
  
  var isFromCurrentUser: Bool
  
  init(dictionary: [String: Any]) {
    self.text = dictionary["text"] as? String ?? ""
    self.fromID = dictionary["fromID"] as? String ?? ""
    self.toID = dictionary["toID"] as? String ?? ""
    self.username = dictionary["username"] as? String ?? ""
    self.fullname = dictionary["fullname"] as? String ?? ""
    self.profileImageURL = dictionary["profileImageURL"] as? String ?? ""
    
    self.timestamp = dictionary["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    
    self.isFromCurrentUser = fromID == Auth.auth().currentUser?.uid
  }
}

//let dataFrom: [String: Any] = [
//  "text": message,
//  "fromID": currentUser.uid,
//  "toID": otherUser.uid,
//  "timestamp": Timestamp(date: Date()),
//
//  "username": otherUser.username,
//  "fullname": otherUser.fullname,
//  "profileImageURL": otherUser.profileImageURL
//]
