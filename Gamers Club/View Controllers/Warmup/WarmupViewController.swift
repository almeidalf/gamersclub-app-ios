//
//  WarmupViewController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

final class WarmupViewController: UIViewController {
  // MARK: - Variables
  
  override func viewDidLoad() {
    super.viewDidLoad()
    title = "Warmup"
    view.backgroundColor = .white
    setupNavigationBar(withBackButton: true)
  }
}
