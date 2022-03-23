//
//  UIViewController+App.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 08/03/22.
//

import UIKit

extension UIViewController {
  // MARK: - Functions
  
  func setupNavigationBar(withBackButton: Bool) {
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .white
      appearance.shadowImage = UIImage()
      appearance.backgroundImage = UIImage()
      appearance.shadowColor = .clear
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = .gray
    navigationItem.hidesBackButton = true
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.layoutIfNeeded()
  }
}
