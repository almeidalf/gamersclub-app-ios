//
//  WebViewSteamCoordinator.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 28/03/22.
//

import UIKit

final class WebViewSteamCoordinator: Coordinator {
  deinit { print("deinit WebViewSteamCoordinator") }
  
  func start() {
    let viewController = HomeWebview()
    viewController.coordinator = self
    viewController.modalPresentationStyle = .overCurrentContext
    navigationController.setViewControllers([viewController], animated: true)
  }
  
  func goToHome() {
    let child = TabBarCoordinator(navigationController: navigationController)
    child.parentCoordinator = self
    childCoordinators.append(child)
    child.start()
  }
}
