//
//  CustomLabel.swift
//  ChatApp
//
//  Created by Elizeu RS on 23/07/23.
//

import UIKit

class CustomLabel: UILabel {
  init(text: String, labelFont: UIFont = .systemFont(ofSize: 14), labelColor: UIColor = .black) {
    super.init(frame: .zero)
    self.text = text
    font = labelFont
    textColor = labelColor
    
    textAlignment = .center
    numberOfLines = 0
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
