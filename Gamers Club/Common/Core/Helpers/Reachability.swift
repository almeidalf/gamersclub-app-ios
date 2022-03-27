//
//  Consts.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//

import SystemConfiguration
import UIKit

enum ReachabilityType: CustomStringConvertible {
  case wwan
  case wifi
  
  var description: String {
    switch self {
    case .wwan: return "WWAN"
    case .wifi: return "WiFi"
    }
  }
}

enum ReachabilityStatus: CustomStringConvertible {
  case offline
  case online(ReachabilityType)
  case unknown
  
  var description: String {
    switch self {
    case .offline: return "Offline"
    case .online(let type): return "Online (\(type))"
    case .unknown: return "Unknown"
    }
  }
}

public final class Reachability {
  public class func isConnectedToNetwork() -> Bool {
    let networkStatus = Reachability().connectionStatus()
    
    switch networkStatus {
    case .unknown, .offline:
      return false
    case .online(.wwan):
      return true
    case .online(.wifi):
      return true
    }
  }
  
  private func connectionStatus() -> ReachabilityStatus {
    var zeroAddress = sockaddr_in()
    zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
    zeroAddress.sin_family = sa_family_t(AF_INET)
    
    guard let defaultRouteReachability = (withUnsafePointer(to: &zeroAddress) {
      $0.withMemoryRebound(to: sockaddr.self, capacity: 1) { zeroSockAddress in
        SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
      }
    }) else {
      return .unknown
    }
    
    var flags: SCNetworkReachabilityFlags = []
    if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
      return .unknown
    }
    
    return ReachabilityStatus(reachabilityFlags: flags)
  }
}

extension ReachabilityStatus {
  init(reachabilityFlags flags: SCNetworkReachabilityFlags) {
    let connectionRequired = flags.contains(.connectionRequired)
    let isReachable = flags.contains(.reachable)
    let isWWAN = flags.contains(.isWWAN)
    
    if !connectionRequired && isReachable {
      if isWWAN {
        self = .online(.wwan)
      } else {
        self = .online(.wifi)
      }
    } else {
      self = .offline
    }
  }
}
