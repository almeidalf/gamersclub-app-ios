//
//  HomeTabBarController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

final class HomeTabBarController: UITabBarController {
  // MARK: - Variables
  
  weak var coordinator: TabBarCoordinator? {
    didSet {
      guard let coordinator = coordinator else { return }
      viewControllers = [coordinator.goToHome(), coordinator.goToProfile()]
      updateSelection()
    }
  }
  
  override var selectedIndex: Int {
    didSet {
      updateSelection()
    }
  }
  
  // MARK: - Destructor
  
  deinit {
    coordinator?.didFinish()
  }
  
  // MARK: - View Lifecycle
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    navigationController?.setNavigationBarHidden(true, animated: true)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    delegate = self
    tabBar.tintColor = .black
    tabBar.unselectedItemTintColor = .lightGray
    tabBar.backgroundColor = .white
    tabBar.barTintColor = .white
    tabBar.isTranslucent = false
    
    // Adjusts iOS 13.2
    tabBar.layer.borderColor = UIColor.lightGray.cgColor
    tabBar.layer.borderWidth = 0.5
    tabBar.clipsToBounds = true
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
  }
}

// MARK: - UITabBarControllerDelegate

extension HomeTabBarController: UITabBarControllerDelegate {
  func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
    updateSelection()
  }
  
  func updateSelection() {
    viewControllers?.forEach {
      $0.tabBarItem.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 14)], for: .normal)
    }
  }
}
