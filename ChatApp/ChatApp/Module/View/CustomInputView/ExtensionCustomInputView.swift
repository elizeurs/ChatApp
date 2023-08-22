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
    
  }
  
  func setTimer() {
    timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
  }
  
  @objc func updateTimer() {
    duration += 1
    self.timerLabel.text = "\(duration)"
  }
}
