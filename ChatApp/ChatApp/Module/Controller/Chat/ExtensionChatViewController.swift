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
    imagePicker.mediaTypes = ["public.image"]
    present(imagePicker, animated: true)
    print("Camera")
  }
  
  @objc func handleGallery() {
    imagePicker.sourceType = .savedPhotosAlbum
    imagePicker.mediaTypes = ["public.image"]
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
      }
      
//      print("mediaType \(mediaType)")
    }
  }
}

// MARK: - Upload Media

extension ChatViewController {
  func uploadImage(withImage image: UIImage) {
    
  }
}
