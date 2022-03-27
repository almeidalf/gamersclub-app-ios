//
//  ProfileViewController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 27/03/22.
//

import UIKit

final class ProfileViewController: UIViewController {
  // MARK: - Variables
  
  weak var coordinator: ProfileCoordinator?
  
  private(set) lazy var logoutView: LogoutView = {
    let view = LogoutView()
    view.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupNavigationBar(withBackButton: true)
  }
  
  // MARK: - SetupViews and Constraints
  
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(logoutView)
    
    logoutView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(150)
    }
  }
  
  
  // MARK: - Actions
  
  @objc private func logoutTapped() {
    Cache.gclubsess = nil
    Cache.profileSession = nil
    navigationController?.popToRootViewController(animated: true)
  }
}
