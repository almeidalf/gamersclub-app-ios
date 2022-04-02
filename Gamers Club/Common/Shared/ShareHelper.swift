//
//  SharedFile.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 01/04/22.
//

import UIKit

public final class ShareHelper {
  // MARK: - Public Function

  public class func share(viewController: UIViewController, ip: String) {
    let items = [ip]
    let activityViewController = UIActivityViewController(activityItems: items, applicationActivities: nil)
    
    if let popoverController = activityViewController.popoverPresentationController {
      popoverController.sourceView = viewController.view
      popoverController.sourceRect = CGRect(x: viewController.view.bounds.midX, y: viewController.view.bounds.midY, width: 0, height: 0)
      popoverController.permittedArrowDirections = []
    }
    
    viewController.present(activityViewController, animated: true, completion: nil)
  }
}
