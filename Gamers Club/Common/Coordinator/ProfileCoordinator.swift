//
//  ProfileCoordinator.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 27/03/22.
//

import UIKit

final class ProfileCoordinator: Coordinator {
  deinit { print("deinit ProfileCoordinator") }
  
  override init(navigationController: UINavigationController = UINavigationController()) {
    super.init(navigationController: navigationController)
    let viewController = ProfileViewController()
    let homeIcon = UIImage(named: "profile")
    let homeSelected = UIImage(named: "profile")
    viewController.tabBarItem = UITabBarItem(title: "Perfil", image: homeIcon, selectedImage: homeSelected)
    viewController.coordinator = self
    viewController.hidesBottomBarWhenPushed = false
    navigationController.viewControllers = [viewController]
  }
  
  func goToSessionExpired() {
    guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
    appDelegate.coordinator?.goToWebViewSteam()
  }
}
