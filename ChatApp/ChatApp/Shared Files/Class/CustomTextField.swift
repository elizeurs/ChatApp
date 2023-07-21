//
//  CustomTextField.swift
//  ChatApp
//
//  Created by Elizeu RS on 21/07/23.
//

import UIKit

class CustomTextField: UITextField {
  init(placelolder: String, keyboardType: UIKeyboardType = .default, isSecure: Bool = false) {
    super.init(frame: .zero)
    let spacer = UIView()
    spacer.setDimensions(height: 50, width: 12)
    leftView = spacer
    leftViewMode = .always
    
    borderStyle = .none
    textColor = .black
    keyboardAppearance = .light
    clearButtonMode = .whileEditing
    backgroundColor = #colorLiteral(red: 0.9656803012, green: 0.965680182, blue: 0.965680182, alpha: 1)
    setHeight(50)
    
    self.keyboardType = keyboardType
    isSecureTextEntry = isSecure
    
    attributedPlaceholder = NSAttributedString(string: placelolder, attributes: [.foregroundColor: UIColor.black.withAlphaComponent(0.7)])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
