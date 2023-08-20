//
//  ExtensionChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 18/08/23.
//

import UIKit

extension ChatViewController {
  @objc func handleCamera() {
    imagePicker.sourceType = .camera
    imagePicker.mediaTypes = ["public.image", "public.movie"]
    present(imagePicker, animated: true)
    print("Camera")
  }
  
  @objc func handleGallery() {
    imagePicker.sourceType = .savedPhotosAlbum
    imagePicker.mediaTypes = ["public.image", "public.movie"]
    present(imagePicker, animated: true)
    print("Gallery")
  }
}

// MARK: - UIImagePickerControllerDelegate
extension ChatViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    // Media type
    dismiss(animated: true) {
      guard let mediaType = info[UIImagePickerController.InfoKey(rawValue: UIImagePickerController.InfoKey.mediaType.rawValue)] as? String else { return }
      
      if mediaType == "public.image" {
        // upload image
        guard let image = info[.editedImage] as? UIImage else { return }
        self.uploadImage(withImage: image)
      } else {
        guard let videoURL = info[UIImagePickerController.InfoKey.mediaURL] as? URL else { return }
        self.uploadVideo(withVideoURL: videoURL)
      }
      
//      print("mediaType \(mediaType)")
    }
  }
}

// MARK: - Upload Media

extension ChatViewController {
  func uploadImage(withImage image: UIImage) {
    showLoader(true)
    FileUploader.uploadImage(image: image) { imageURL in
      MessageServices.FetchSingleRecentMsg(otherUser: self.otherUser) { unreadMsgCount in
        MessageServices.uploadMessage(imageURL: imageURL, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unreadMsgCount) { error in
          self.showLoader(false)
          if let error = error {
            print("error \(error.localizedDescription)")
            return
          }
        }
      }
    }
  }
  
  func uploadVideo(withVideoURL url: URL) {
    showLoader(true)
    FileUploader.uploadVideo(url: url) { videoURL in
      MessageServices.FetchSingleRecentMsg(otherUser: self.otherUser) { unReadMsgCount in
        MessageServices.uploadMessage(videoURL: videoURL, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadMsgCount) { error in
          self.showLoader(false)
          if let error = error {
            print("error \(error.localizedDescription)")
            return
          }
        }
      }
    } failure: { error in
      print("error \(error.localizedDescription)")
      return
    }
  }
}
