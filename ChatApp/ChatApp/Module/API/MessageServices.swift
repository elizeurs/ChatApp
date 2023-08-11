//
//  MessageServices.swift
//  ChatApp
//
//  Created by Elizeu RS on 05/08/23.
//

import Foundation
import Firebase

struct MessageServices {
  static func fetchMessages(otherUser: User, completion: @escaping([Message]) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    var messages = [Message]()
    let query = Collection_Message.document(uid).collection(otherUser.uid).order(by: "timestamp")
    
    query.addSnapshotListener { snapshot, _ in
      guard let documentChanges = snapshot?.documentChanges.filter({$0.type == .added}) else { return }
      messages.append(contentsOf: documentChanges.map({ Message(dictionary: $0.document.data())}))
      completion(messages)
    }
  }
  
  static func fetchRecentMessages(completion: @escaping([Message]) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    let query = Collection_Message.document(uid).collection("recent-message").order(by: "timestamp", descending: true)
    
    query.addSnapshotListener { snapshot, _ in
      guard let documentChanges = snapshot?.documentChanges else { return }
      let messages = documentChanges.map({Message(dictionary: $0.document.data())})
      completion(messages )
    }
  }
  
  static func uploadMessage(message: String, currentUser: User, otherUser: User, unReadCount: Int, completion: ((Error?) -> Void)?) {
    let dataFrom: [String: Any] = [
      "text": message,
      "fromID": currentUser.uid,
      "toID": otherUser.uid,
      "timestamp": Timestamp(date: Date()),
      
      "username": otherUser.username,
      "fullname": otherUser.fullname,
      "profileImageURL": otherUser.profileImageURL,
      
      "new_msg": 0
    ]
    
    let dataTo: [String: Any] = [
      "text": message,
      "fromID": currentUser.uid,
      "toID": otherUser.uid,
      "timestamp": Timestamp(date: Date()),
      
      "username": currentUser.username,
      "fullname": currentUser.fullname,
      "profileImageURL": currentUser.profileImageURL,
      
      "new_msg": unReadCount
    ]
    
    Collection_Message.document(currentUser.uid).collection(otherUser.uid).addDocument(data: dataFrom) { _ in
      Collection_Message.document(otherUser.uid).collection(currentUser.uid).addDocument(data: dataTo, completion: completion)
      Collection_Message.document(currentUser.uid).collection("recent-message").document(otherUser.uid).setData(dataFrom)
      Collection_Message.document(otherUser.uid).collection("recent-message").document(currentUser.uid).setData(dataTo)
    }
  }
  
  static func FetchSingleRecentMsg(otherUser: User, completion: @escaping(Int) -> Void) {
    guard let uid = Auth.auth().currentUser?.uid else { return }
    
    Collection_Message.document(otherUser.uid).collection("recent-message").document(uid).getDocument { snapshot, _ in
      guard let data = snapshot?.data() else {
        completion(0)
        return
      }
      
      let message = Message(dictionary: data)
      completion(message.new_msg)
    }
  }
}
