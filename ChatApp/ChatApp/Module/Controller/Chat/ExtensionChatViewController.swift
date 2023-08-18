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
    //
    dismiss(animated: true)
  }
}
