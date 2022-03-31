//
//  WarmupService.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

protocol WarmupServiceProtocol {
  func getWarmupData(page: Int, limit: Int, completionHandler: @escaping (Result<Warmup, Error>) -> Void)
}

final class WarmupService: WarmupServiceProtocol {
  private let apiClient = APIClient(baseURL: Constants.getBaseApiUrl)
  
  func getWarmupData(page: Int, limit: Int, completionHandler: @escaping (Result<Warmup, Error>) -> Void) {
    apiClient.execute(endpoint: WarmupEndpoint(page: page, limit: limit), completionHandler: completionHandler)
  }
}
