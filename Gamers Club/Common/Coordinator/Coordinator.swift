//
//  Coordinator.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

protocol CoordinatorProtocol: AnyObject {
  var childCoordinators: [Coordinator] { get set }
  var navigationController: UINavigationController { get set }
}

class Coordinator: CoordinatorProtocol {
  var childCoordinators = [Coordinator]()
  weak var parentCoordinator: Coordinator?
  var navigationController: UINavigationController

  init(navigationController: UINavigationController) {
    self.navigationController = navigationController
  }

  func childDidFinish(_ child: Coordinator?) {
    for (index, coordinator) in childCoordinators.enumerated() where coordinator === child {
      childCoordinators.remove(at: index)
    }
  }

  func didFinish() {
    parentCoordinator?.childDidFinish(self)
  }
}
