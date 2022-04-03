//
//  GetProfileUserMe.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 02/04/22.
//

import Alamofire

public struct GetProfileUserMe: APIEndpoint {
  public var path: String = "/v1/user/me"
  public var headers: [String: String] = APIHeaders.headers()
  public var params: [String: Any]?
  public var method: HTTPMethod  = .get
  public var encoding: ParameterEncoding = URLEncoding.default
}
