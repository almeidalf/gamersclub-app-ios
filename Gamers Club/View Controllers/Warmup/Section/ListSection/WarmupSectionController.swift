//
//  WarmupSectionController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import IGListKit

final class WarmupSectionController: ListSectionController {
  // MARK: - Variables
  
  private var item: WarmupDiffable?
  
  // MARK: - Constructor
  
  override init() {
    super.init()
    minimumInteritemSpacing = 8
    minimumLineSpacing = 8
    inset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
  }
  
  // MARK: - Overriding
  
  override func numberOfItems() -> Int {
    return item?.servers.count ?? 0
  }
  
  override func sizeForItem(at index: Int) -> CGSize {
    let widthCollection = collectionContext?.containerSize.width ?? 0
    let widthItem = floor((widthCollection - (minimumInteritemSpacing * 2) - inset.left - inset.right) / 2)
    return CGSize(width: widthItem, height: widthItem * 0.8)
  }
  
  override func cellForItem(at index: Int) -> UICollectionViewCell {
    guard let cell = collectionContext.dequeueReusableCell(of: WarmupCell.self, for: self, at: index) as? WarmupCell else {
      fatalError("reuse cell not found")
    }
    
    cell.serverInfo = item?.servers[safe: index]
    cell.delegate = self
    
    return cell
  }
  
  override func didUpdate(to object: Any) {
    item = object as? WarmupDiffable
  }
  
  override func didSelectItem(at index: Int) {
  }
}

extension WarmupSectionController: WarmupDelegate {
  func sharedIPServer(_ ip: String) {
    guard let viewController = viewController as? WarmupViewController else { return }
    viewController.sharedIP(ip: ip)
  }
}
