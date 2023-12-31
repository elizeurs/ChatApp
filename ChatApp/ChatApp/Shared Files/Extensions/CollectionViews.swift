//
//  CollectionViews.swift
//  ChatApp
//
//  Created by Elizeu RS on 14/08/23.
//

import UIKit

extension UICollectionView {
  func scrollToLastItem(at scrollPosition: UICollectionView.ScrollPosition = .bottom, animated: Bool = true) {
    let lastSection = numberOfSections - 1
    guard lastSection >= 0 else { return }
    let lastItem = numberOfItems(inSection: lastSection) - 1
    guard lastItem  >= 0 else { return }
    let lastItemIndexPath =  IndexPath(item: lastItem, section: lastSection)
    scrollToItem(at: lastItemIndexPath, at: scrollPosition, animated: true)
  }
}
