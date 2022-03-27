//
//  PlayNowViewController.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 26/03/22.
//

import UIKit

final class PlayNowViewController: UIViewController {
  // MARK: - Variables
  
  weak var coordinator: HomeCoordinator?
  
  private(set) lazy var playNow: PlayNowView = {
    let view = PlayNowView()
    view.warmupButton.addTarget(self, action: #selector(warmupTapped), for: .touchUpInside)
    view.forFunButton.addTarget(self, action: #selector(forFunTapped), for: .touchUpInside)
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
    hideNavigationBar()
  }
  
  // MARK: - SetupViews and Constraints
  
  private func setupViews() {
    view.backgroundColor = .white
    view.addSubview(playNow)
    view.addSubview(logoutView)
    
    playNow.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(50)
      make.leading.trailing.equalToSuperview()
      make.height.equalTo(150)
    }
    
    logoutView.snp.makeConstraints { make in
      make.leading.trailing.bottom.equalToSuperview()
      make.height.equalTo(150)
    }
  }
  
  
  // MARK: - Actions
  
  @objc private func warmupTapped() {
    print("Ir para warmup")
  }
  
  @objc private func forFunTapped() {
    print("Ir para forFun")
  }
  
  @objc private func logoutTapped() {
    Cache.gclubsess = nil
    Cache.profileSession = nil
    coordinator?.goToWebViewSteam()
  }
}
