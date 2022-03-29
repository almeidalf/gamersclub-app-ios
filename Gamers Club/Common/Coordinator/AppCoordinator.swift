//
//  AppCordinator.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

final class AppCoordinator: Coordinator {
  deinit { print("deinit AppCoordinator") }

  func goToTabBar(selectedIndex: Int = 0) {
    let child = TabBarCoordinator(navigationController: navigationController)
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start(selectedIndex: selectedIndex)
  }
  
  func goToWebViewSteam() {
    let child = WebViewSteamCoordinator(navigationController: navigationController)
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
  }
}
