//
//  CustomInputView.swift
//  ChatApp
//
//  Created by Elizeu RS on 01/08/23.
//

import Foundation
import UIKit

class CustomInputView: UIView {
  // MARK: - Properties
  let inputTextView = InputTextView()
  
  // MARK: - Lifecycle
  override init(frame: CGRect) {
    super.init(frame: frame)
    backgroundColor = .white
    autoresizingMask = .flexibleHeight
    
    addSubview(inputTextView)
    inputTextView.anchor(top: topAnchor, left: leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: rightAnchor, paddingTop: 12, paddingLeft: 8, paddingBottom: 5, paddingRight: 8)
    
    let dividerView = UIView()
    dividerView.backgroundColor = .lightGray
    addSubview(dividerView)
    dividerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor, height: 0.5)
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override var intrinsicContentSize: CGSize {
    return .zero
  }
  
  // MARK: - Helpers
}
