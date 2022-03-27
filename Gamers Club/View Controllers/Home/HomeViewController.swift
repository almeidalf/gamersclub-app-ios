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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    hideNavigationBar()
    getProfile()
    addObservers()
  }
  
  // MARK: - Observers
  
  private func addObservers() {
    let notification = NotificationCenter.default
    notification.addObserver(self, selector: #selector(refreshProfile), name: .refresh, object: nil)
  }
  
  // MARK: - API
  
  private func getProfile(completionHandler: ((_ success: Bool) -> Void)? = nil) {
    guard let playerNumber = Cache.profileSession?.id.description else {
      coordinator?.goToWebViewSteam()
      return
    }
    
    ProfileService().getProfileStats(number: playerNumber) { response in
      
      switch response {
      case .success(let profile):
        if profile.loggedUser?.id == 0 || Cache.gclubsess == nil {
          self.coordinator?.goToWebViewSteam()
        } else {
          self.coordinator?.goToPlayNow()
        }
        
        completionHandler?(true)
      case .failure(_):
        completionHandler?(false)
        self.coordinator?.goToWebViewSteam()
      }
    }
  }
  
  @objc private func refreshProfile() {
    getProfile()
  }
}
