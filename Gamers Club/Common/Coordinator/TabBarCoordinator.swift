//
//  TabBarCoordinator.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

final class TabBarCoordinator: Coordinator {
  deinit { print("deinit TabBarCoordinator") }

  func start(selectedIndex: Int = 0) {
    let tabBar = HomeTabBarController()
    tabBar.coordinator = self
    tabBar.selectedIndex = selectedIndex
    navigationController.setViewControllers([tabBar], animated: true)
  }

  func goToHome() -> UINavigationController {
    let child = HomeCoordinator()
    child.parentCoordinator = self
    childCoordinators.append(child)
    return child.navigationController
  }

  func goToProfile() -> UINavigationController {
    let child = ProfileCoordinator()
    child.parentCoordinator = self
    childCoordinators.append(child)
    return child.navigationController
  }
}
