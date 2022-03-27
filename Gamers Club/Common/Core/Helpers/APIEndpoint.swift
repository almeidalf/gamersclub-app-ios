//
//  Consts.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//

import Alamofire

public protocol Endpoint {
  var path: String { get }
  var headers: [String: String] { get }
  var method: HTTPMethod { get }
  var encoding: ParameterEncoding { get }
}

public protocol APIEndpoint: Endpoint {
  var params: [String: Any]? { get }
}

public protocol APIEndpointWithArray: Endpoint {
  var params: [Any]? { get }
}
