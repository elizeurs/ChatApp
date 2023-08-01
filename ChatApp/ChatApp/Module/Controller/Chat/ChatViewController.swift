//
//  ChatViewController.swift
//  ChatApp
//
//  Created by Elizeu RS on 31/07/23.
//

import Foundation
import UIKit

class ChatViewController: UICollectionViewController {
  // MARK: - Properties
  private let reuseIdentifier = "ChatCell"
  
  // MARK: - Lifecycle
  
  init() {
    super.init(collectionViewLayout: UICollectionViewFlowLayout())
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureUI()
  }
  
  // MARK: - Helpers
  
  private func configureUI() {
    collectionView.backgroundColor = .white
    
    collectionView.register(ChatCell.self, forCellWithReuseIdentifier: reuseIdentifier)
  }
}

extension ChatViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! ChatCell
    cell.configure()
    return cell
    
//    return UICollectionViewCell()
  }
}
