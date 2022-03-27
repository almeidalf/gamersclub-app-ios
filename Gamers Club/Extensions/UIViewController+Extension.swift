//
//  UIViewController+Extension.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

extension UIViewController {
  // MARK: - Functions
  
  func hideNavigationBar() {
    navigationController?.setNavigationBarHidden(true, animated: true)
    navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    navigationController?.interactivePopGestureRecognizer?.delegate = self
  }
  
  func showModal(view: UIView) {
    view.endEditing(true)
    view.alpha = 0
    UIApplication.shared.keyWindow?.addSubview(view)
    
    UIView.animate(withDuration: 0.3) {
      view.alpha = 1
    }
  }
  
  func setupNavigationBar(withBackButton: Bool, withShadow: Bool = true) {
    if withBackButton {
      navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "arrow-back"),
                                                         style: .plain, target: self,
                                                         action: #selector(backViewController))
      navigationItem.leftBarButtonItem?.accessibilityLabel = "Voltar"
      navigationItem.leftBarButtonItem?.accessibilityTraits = .button
      navigationController?.interactivePopGestureRecognizer?.delegate = self
      navigationController?.interactivePopGestureRecognizer?.isEnabled = true
    }
    
    let titleTextAttributes: [NSAttributedString.Key: Any] = [.foregroundColor: UIColor.black,
                                                              .font: UIFont.systemFont(ofSize: 14)]
    
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithOpaqueBackground()
      appearance.backgroundColor = .white
      appearance.titleTextAttributes = titleTextAttributes
      appearance.shadowImage = UIImage()
      appearance.backgroundImage = UIImage()
      appearance.shadowColor = .clear
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
    }
    
    navigationController?.navigationBar.isTranslucent = false
    navigationController?.setNavigationBarHidden(false, animated: true)
    navigationController?.navigationBar.titleTextAttributes = titleTextAttributes
    navigationController?.navigationBar.backgroundColor = .white
    navigationController?.navigationBar.barTintColor = .white
    navigationController?.navigationBar.tintColor = UIColor.lightGray
    navigationItem.hidesBackButton = true
    
    if withShadow {
      navigationController?.navigationBar.layer.masksToBounds = false
      navigationController?.navigationBar.layer.shadowOpacity = 0.2
      navigationController?.navigationBar.layer.shadowOffset = .zero
      navigationController?.navigationBar.layer.shadowRadius = 3
    }
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.layoutIfNeeded()
  }
  
  @objc func backViewController() {
    navigationController?.popViewController(animated: true)
  }
  
  func toast(text: String) {
    let alert = UIAlertController(title: "", message: text, preferredStyle: .alert)
    present(alert, animated: true, completion: nil)
    
    Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
      alert.dismiss(animated: true, completion: nil)
    }
  }
  
  @objc func dismiss() {
    view.endEditing(true)
    dismiss(nil)
  }
  
  func dismiss(_ completion: (() -> Void)?) {
    DispatchQueue.main.async {
      self.dismiss(animated: true, completion: completion)
    }
  }
}

// MARK: - UIGestureRecognizerDelegate

extension UIViewController: UIGestureRecognizerDelegate {
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    if let count = navigationController?.viewControllers.count, count > 1 {
      return true
    }
    
    return false
  }
}
