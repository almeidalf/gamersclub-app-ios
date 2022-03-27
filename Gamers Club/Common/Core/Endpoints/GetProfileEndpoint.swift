//
//  Consts.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//

import Alamofire

public struct GetProfileEndpoint: APIEndpoint {
  public var path: String
  public var headers: [String: String] = APIHeaders.headers()
  public var params: [String: Any]?
  public var method: HTTPMethod  = .get
  public var encoding: ParameterEncoding = URLEncoding.default

  public init(profileNumber: String) {
    path = "/box/init/\(profileNumber)"
  }
}
