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
  
  func goToPlayNow() {
    let viewController = PlayNowViewController()
    viewController.hidesBottomBarWhenPushed = false
    viewController.coordinator = self
    navigationController.pushViewController(viewController, animated: true)
  }
  
  func goToWebViewSteam() {
    let viewController = HomeWebview()
    viewController.hidesBottomBarWhenPushed = true
    viewController.coordinator = self
    navigationController.present(viewController, animated: true)
  }
}
