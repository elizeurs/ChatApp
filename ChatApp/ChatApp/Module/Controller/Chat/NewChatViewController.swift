//
//  NewChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 29/07/23.
//

import UIKit

class NewChatViewController: UIViewController {
  // MARK: - Properties
  
  // MARK: - Lifescycle
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Helpers
  private func configureUI() {
    view.backgroundColor = .white
    title = "Search"
  }
}
