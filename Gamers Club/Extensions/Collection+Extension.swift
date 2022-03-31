//
//  Collection+Extension.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import UIKit

public extension Collection {
  subscript (safe index: Index) -> Element? {
    indices.contains(index) ? self[index] : nil
  }
}

extension UICollectionView {
  func indexPath() -> IndexPath {
    let visibleRect = CGRect(origin: contentOffset, size: bounds.size)
    let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
    let indexPath = indexPathForItem(at: visiblePoint)
    return indexPath ?? IndexPath(row: 0, section: 0)
  }
}
