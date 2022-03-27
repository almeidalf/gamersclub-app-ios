//
//  Consts.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//

import Foundation

public enum APIClientError: Error {
  case noInternetError
  case parseError
  case serverIsOffline
  case endpointInvalid
  case sessionExpired
  
  var localizedDescription: String {
    switch self {
    case .noInternetError:
      return "Sem conexão"
    case .parseError:
      return "Erro na conversão do objeto"
    case .serverIsOffline:
      return "Servidor Offline"
    case .endpointInvalid:
      return "Endpoint inválido"
    case .sessionExpired:
      return "Sessão expirada"
    }
  }
}
