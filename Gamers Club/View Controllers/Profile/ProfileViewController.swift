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
  
  private(set) lazy var profileTopView: ProfileTopView = {
    let view = ProfileTopView()
//    view.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    return view
  }()
  
  private(set) lazy var logoutView: LogoutView = {
    let view = LogoutView()
    view.logoutButton.addTarget(self, action: #selector(logoutTapped), for: .touchUpInside)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupViews()
    setupNavigationBar(withBackButton: false)
    getProfileData()
  }
  
  // MARK: - SetupViews and Constraints
  
  private func setupViews() {
    title = "Perfil"
    view.backgroundColor = .white
    view.addSubview(profileTopView)
    view.addSubview(logoutView)
    
    profileTopView.snp.makeConstraints { make in
      make.leading.top.trailing.equalToSuperview()
      make.bottom.equalTo(logoutView.snp.top)
    }
    
    logoutView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(150)
    }
  }
  
  // MARK: - API
  
  private func getProfileData(completionHandler: ((_ success: Bool) -> Void)? = nil) {
    ProfileService().getProfileUserMe { response in
      
      switch response {
      case .success(let data):
        self.profileTopView.profileData = data
        completionHandler?(true)
      case .failure(let error):
        print("ERRO", error.localizedDescription)
        completionHandler?(false)
      }
    }
  }
  
  
  // MARK: - Actions
  
  @objc private func logoutTapped() {
    Cache.gclubsess = nil
    Cache.profileSession = nil
    coordinator?.goToSessionExpired()
  }
}
