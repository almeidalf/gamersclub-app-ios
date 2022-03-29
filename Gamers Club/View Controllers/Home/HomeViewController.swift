//
//  HomeLoggedViewController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 22/03/22.
//

import UIKit

final class HomeViewController: UIViewController {
  // MARK: - Variables
  
  weak var coordinator: HomeCoordinator?
  
  private(set) lazy var playNow: HomeView = {
    let view = HomeView()
    view.warmupButton.addTarget(self, action: #selector(warmupTapped), for: .touchUpInside)
    view.forFunButton.addTarget(self, action: #selector(forFunTapped), for: .touchUpInside)
    return view
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    getProfile()
    addObservers()
    setupViews()
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    hideNavigationBar()
  }
  
  // MARK: - SetupViews and Constraints
  
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(playNow)
    
    playNow.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(50)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(150)
    }
  }
  
  // MARK: - Observers
  
  private func addObservers() {
    let notification = NotificationCenter.default
    notification.addObserver(self, selector: #selector(refreshProfile), name: .refresh, object: nil)
  }
  
  // MARK: - API
  
  private func getProfile(completionHandler: ((_ success: Bool) -> Void)? = nil) {
    guard let playerNumber = Cache.profileSession?.id.description,
          let appDelegate = UIApplication.shared.delegate as? AppDelegate,
          let appCoordinator = appDelegate.coordinator else {
      return
    }
    
    ProfileService().getProfileStats(number: playerNumber) { response in
      
      switch response {
      case .success(let profile):
        if profile.loggedUser?.id == 0 || Cache.gclubsess == nil {
          appCoordinator.goToWebViewSteam()
        }
        
        completionHandler?(true)
      case .failure(_):
        completionHandler?(false)
        appCoordinator.goToWebViewSteam()
      }
    }
  }
  
  @objc private func warmupTapped() {
    coordinator?.goToWarmup()
  }
  
  @objc private func forFunTapped() {
    print("Ir para forFun!")
  }
  
  @objc private func refreshProfile() {
    getProfile()
  }
}
