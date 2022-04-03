//
//  UIImage+Extension.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import Kingfisher
import UIKit

public extension UIImageView {
  // MARK: - Functions

  func setImage(url: String?,
                completeURL: Bool? = false,
                placeholder: UIImage? = nil,
                isCacheEnable: Bool = true,
                completionHandler: (() -> Void)? = nil) {
    DispatchQueue.main.async {
      guard let urlImageString = url, let urlImage = URL(string: urlImageString) else { return }
        
      let api = Constants.gamersClubURL
      
      guard var urlDownloadImage = URL(string: "\(api)/\(urlImage).png") else { return }
      
      if let completed = completeURL, completed {
        urlDownloadImage = urlImage
      }
      
      self.kf.indicatorType = .activity
      let options: KingfisherOptionsInfo = isCacheEnable ? [.transition(.fade(0.6))] : [.forceRefresh, .transition(.fade(0.6))]
      self.kf.setImage(with: urlDownloadImage, placeholder: placeholder, options: options) { _ in
        completionHandler?()
      }
    }
  }
  
  func setImage(image: String?, placeholder: String = "placeholder_image", isCacheEnable: Bool = true) {
    guard let image = image else { return }
    
    DispatchQueue.main.async {
      guard let url = URL(string: "\(Constants.gamersClubURL)/\(image).png") else { return }
      let options: KingfisherOptionsInfo = isCacheEnable ? [.transition(.fade(0.6))] : [.forceRefresh, .transition(.fade(0.6))]
      self.kf.indicatorType = .activity
      self.kf.setImage(with: url, placeholder: UIImage(named: placeholder), options: options)
    }
  }
}
