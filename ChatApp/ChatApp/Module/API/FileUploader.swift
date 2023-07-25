//
//  FileUploader.swift
//  ChatApp
//
//  Created by Elizeu RS on 24/07/23.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

struct FileUploader {
  static func uploadImage(image: UIImage, completion: @escaping(String) -> Void) {
    guard let imageData = image.jpegData(compressionQuality: 0.75) else { return }
    let uid = Auth.auth().currentUser?.uid ??  "/profileImages/"
    
    let filename = NSUUID().uuidString
    let ref = Storage.storage().reference(withPath: "/\(uid)/\(filename)")
    
    ref.putData(imageData, metadata: nil) { metadata, error in
      if let error = error {
        print(error.localizedDescription)
        return
      }
      
      ref.downloadURL { url, error in
        if let error = error {
          print(error.localizedDescription)
          return
        }
        
        guard let fileURl = url?.absoluteString else { return }
        completion(fileURl)
      }
    }
  }
}
