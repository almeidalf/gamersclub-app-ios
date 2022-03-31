//
//  WarmupEndpoint.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import Alamofire

public struct WarmupEndpoint: APIEndpoint {
  public var path: String
  public var headers: [String: String] = APIHeaders.headers()
  public var params: [String: Any]?
  public var method: HTTPMethod  = .post
  public var encoding: ParameterEncoding = URLEncoding.default

  public init(page: Int, limit: Int) {
    path = "/servers?server-type=Warmup&page=\(page)&items=\(limit)"
    
    params?["id"] = 0
    params?["region"] = 0
  }
}
