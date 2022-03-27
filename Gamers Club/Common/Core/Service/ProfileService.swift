//
//  ProfileService.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 25/03/22.
//

import Alamofire
import SwiftUI

protocol ProfileServiceProtocol {
  func getProfileStats(number: String, completionHandler: @escaping (Result<InitResponse, Error>) -> Void)
}

final class ProfileService: ProfileServiceProtocol {
  private let apiClient = APIClient(baseURL: Constants.getBaseApiUrl)
  
  func getProfileStats(number: String, completionHandler: @escaping (Result<InitResponse, Error>) -> Void) {
    apiClient.execute(endpoint: GetProfileEndpoint(profileNumber: number), completionHandler: completionHandler)
  }
}
