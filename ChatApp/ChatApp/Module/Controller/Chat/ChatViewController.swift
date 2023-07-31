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
  
  // MARK: - Lifecycle
  override func viewDidLoad() {
    super.viewDidLoad()
  }
  
  // MARK: - Helpers
}

extension ChatViewController {
  override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 5
  }
  
  override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    return UICollectionViewCell()
  }
}
