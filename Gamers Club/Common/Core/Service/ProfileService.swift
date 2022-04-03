//
//  ProfileService.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 25/03/22.
//

import Alamofire

protocol ProfileServiceProtocol {
  func getProfileBoxInit(number: String, completionHandler: @escaping (Result<InitResponse, Error>) -> Void)
  func getProfileUserMe(completionHandler: @escaping (Result<UserMe, Error>) -> Void)
}

final class ProfileService: ProfileServiceProtocol {
  private let apiClient = APIClient(baseURL: Constants.getBaseApiUrl)
  
  func getProfileBoxInit(number: String, completionHandler: @escaping (Result<InitResponse, Error>) -> Void) {
    apiClient.execute(endpoint: GetProfileEndpoint(profileNumber: number), completionHandler: completionHandler)
  }
  
  func getProfileUserMe(completionHandler: @escaping (Result<UserMe, Error>) -> Void) {
    apiClient.execute(endpoint: GetProfileUserMe(), completionHandler: completionHandler)
  }
}
