//
//  WarmupDiffable.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import IGListKit

final class WarmupDiffable: ListDiffable {
  // MARK: - Variables
  
  var sectionId: Int
  var servers: [Server]
  
  // MARK: - Constructor

  init(sectionId: Int, servers: [Server]) {
    self.sectionId = sectionId
    self.servers = servers
  }

  // MARK: - ListDiffable

  func diffIdentifier() -> NSObjectProtocol {
    return sectionId as NSObjectProtocol
  }

  func isEqual(toDiffableObject object: ListDiffable?) -> Bool {
    guard object !== self else { return true }
    guard let object = object as? WarmupDiffable else { return false }
    return sectionId == object.sectionId && servers == object.servers
  }
}

