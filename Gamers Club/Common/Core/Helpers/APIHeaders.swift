//
//  Consts.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//

import Alamofire

public final class APIHeaders {
  // MARK: - Functions
  
  class func headers(mustPassUuid: Bool = false) -> [String: String] {
    var headers = [String: String]()
    if let token = Cache.gclubsess {
      headers["cookie"] = "gclubsess=\(token)"
    }

    return headers
  }

  public class func authorizationHeader() -> [String: String] {
    var headers = [String: String]()
    
    if let token = Cache.gclubsess {
      headers["cookie"] = "gclubsess=\(token)"
    }

    return headers
  }
}
