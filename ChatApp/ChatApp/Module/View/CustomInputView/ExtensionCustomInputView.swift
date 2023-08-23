//
//  ExtensionCustomInputView.swift
//  ChatApp
//
//  Created by Elizeu RS on 22/08/23.
//

import Foundation

extension CustomInputView {
  @objc func handleCancelButton() {
    recordStackView.isHidden = true
    stackView.isHidden = false
  }
  
  @objc func handleSendRecordButton() {
    recorder.stopRecording()
    
    // TODO: - take the record audio file to upload
    
    recordStackView.isHidden = true
    stackView.isHidden = false
  }
  
  func setTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc func updateTimer() {
    if recorder.isRecording && !recorder.isPlaying {
      duration += 1
      self.timerLabel.text = duration.timeStringFormatter
    } else {
      timer.invalidate()
      duration = 0
      self.timerLabel.text = "00:00"
    }

    
//    self.timerLabel.text = "\(duration)"
  }
}
