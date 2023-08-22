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
}
