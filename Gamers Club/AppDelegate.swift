//
//  AppDelegate.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 08/03/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  // MARK: - Variables
  
  var window: UIWindow?
  var coordinator: AppCoordinator?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    let rootNavigationController = UINavigationController()
    rootNavigationController.setNavigationBarHidden(true, animated: true)
    coordinator = AppCoordinator(navigationController: rootNavigationController)
    
    // create a basic UIWindow and activate it
    window = UIWindow(frame: UIScreen.main.bounds)
    window?.makeKeyAndVisible()
    window?.rootViewController = rootNavigationController
    coordinator?.goToTabBar()
    
    return true
  }
}

