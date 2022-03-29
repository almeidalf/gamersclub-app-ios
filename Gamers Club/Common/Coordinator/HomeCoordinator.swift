//
//  HomeCoordinator.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

final class HomeCoordinator: Coordinator {
  deinit { print("deinit HomeCoordinator") }
  
  override init(navigationController: UINavigationController = UINavigationController()) {
    super.init(navigationController: navigationController)
    let viewController = HomeViewController()
    let homeIcon = UIImage(named: "home")
    let homeSelected = UIImage(named: "home")
    viewController.tabBarItem = UITabBarItem(title: "Inicio", image: homeIcon, selectedImage: homeSelected)
    viewController.coordinator = self
    viewController.hidesBottomBarWhenPushed = false
    navigationController.viewControllers = [viewController]
  }
  
  func goToWarmup() {
    let viewController = WarmupViewController()
    viewController.hidesBottomBarWhenPushed = false
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func goToSessionExpired() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    appDelegate.coordinator?.goToWebViewSteam()
  }
}
