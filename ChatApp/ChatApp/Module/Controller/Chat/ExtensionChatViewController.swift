//
//  ExtensionChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 18/08/23.
//

import UIKit
import SDWebImage
import ImageSlideshow
import SwiftAudioPlayer

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
  
  @objc func handleCurrentLocation() {
    FLocationManager.shared.start { info in
      guard let lat = info.latitude else { return }
      guard let lng = info.longitude else { return }
      
      self.uploadLocation(lat: "\(lat)", lng: "\(lng)")
      FLocationManager.shared.stop()

//      print("Lat \(info.latitude)")
//      print("Lng \(info.longitude)")
    }
  }
  
  @objc func handleGoogleMap() {
    let controller = ChatMapVC()
    controller.delegate = self
    navigationController?.pushViewController(controller, animated: true)
  }
  
  func uploadLocation(lat: String, lng: String) {
    let locationURL = "https://www.google.com/maps/dir/?api=1&destination=\(lat),\(lng)"
    
    self.showLoader(true)
    MessageServices.FetchSingleRecentMsg(otherUser: otherUser) { unReadCount in
      MessageServices.uploadMessage(locationURL: locationURL, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadCount + 1) { error in
        self.showLoader(false)
        
        if let error = error {
          print("error \(error.localizedDescription)")
          return
        }
      }
    }
  }
}

// MARK: - ChatMapVCDelegate
extension ChatViewController: ChatMapVCDelegate {
  func didTapLocation(lat: String, lng: String) {
    navigationController?.popViewController(animated: true)
    uploadLocation(lat: lat, lng: lng)
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
        MessageServices.uploadMessage(imageURL: imageURL, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unreadMsgCount + 1) { error in
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
        MessageServices.uploadMessage(videoURL: videoURL, currentUser: self.currentUser, otherUser: self.otherUser, unReadCount: unReadMsgCount + 1) { error in
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

// MARK: - Chat Delegate

extension ChatViewController: ChatCellDelegate {
  
  func cell(wantToPlayVideo cell: ChatCell, videoURL: URL?) {
    guard let videoURL = videoURL else { return }
    let controller = VideoPlayerVC(videoURL: videoURL)
    navigationController?.pushViewController(controller, animated: true)
  }
  
  func cell(wantToShowImage cell: ChatCell, imageURL: URL?) {
    let slideShow = ImageSlideshow()
    
    guard let imageURL = imageURL else { return }
    
    SDWebImageManager.shared.loadImage(with: imageURL, progress: nil) {image,_,_,_,_,_ in
      guard let image = image else { return }
      
      slideShow.setImageInputs([
        ImageSource(image: image),
        //        if you want a slideShow:
        //        ImageSource(image: image),
        //        ImageSource(image: image),
        //        ImageSource(image: image),
        //        ImageSource(image: image),
      ])
      
      slideShow.delegate = self as? ImageSlideshowDelegate
      
      let controller = slideShow.presentFullScreenController(from: self)
      controller.slideshow.activityIndicator = DefaultActivityIndicator()
    }
  }
  
  func cell(wantToPlayAudio cell: ChatCell, audioURL: URL?, isPlaying: Bool) {
    if isPlaying {
      guard let audioURL = audioURL else { return }
      
      SAPlayer.shared.startRemoteAudio(withRemoteUrl: audioURL)
      SAPlayer.shared.play()
      
      let _ = SAPlayer.Updates.PlayingStatus.subscribe { playingStatus in
        print("playingStatus \(playingStatus)")
        if playingStatus == .ended {
          cell.resetAudioSettings()
        }
      }
    } else {
      SAPlayer.shared.stopStreamingRemoteAudio()
    }
  }
  
  func cell(wantToOpenGoogleMap cell: ChatCell, locationURL: URL?) {
    guard let googleURLApp = URL(string: "comgooglemaps://") else { return }
    guard let locationURL = locationURL else { return }
    
    if UIApplication.shared.canOpenURL(googleURLApp) {
      // here we have the app
      UIApplication.shared.open(locationURL)
    } else {
      // we don't have the app
      UIApplication.shared.open(locationURL, options: [:])
    }
  }
}
