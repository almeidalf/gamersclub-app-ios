//
//  APIClient.swift
//  Skeelo
//
//  Created by Igor Soares on 09/02/19.
//  Copyright © 2019 Gold360. All rights reserved.
//

import Alamofire
import Foundation

public final class APIClient {
  private var baseURL: String
  private var retryCount: Int = 0
  private let timeDelay: Double = 3.0
  private let notification = NotificationCenter.default
  
  public init(baseURL: String) {
    self.baseURL = baseURL
  }
  
  private let manager: Session = {
    let configuration = URLSessionConfiguration.default
    configuration.timeoutIntervalForRequest = 15
    return Session(configuration: configuration)
  }()
  
  public func executeFormData<Element: Codable>(endpoint: APIEndpoint, completionHandler: @escaping (Element?, Int?) -> Void) {
    manager.upload(multipartFormData: { multipartFormData in
      if let params = endpoint.params {
        params.forEach { key, value in
          if let url = value as? URL {
            multipartFormData.append(url, withName: key)
          } else if let string = value as? String {
            multipartFormData.append(Data(string.utf8), withName: key)
          } else if let int = value as? Int64 {
            multipartFormData.append(Data(String(int).utf8), withName: key)
          }
        }
      }
    }, to: baseURL + endpoint.path, method: endpoint.method, headers: HTTPHeaders(endpoint.headers))
    .response { response in
      guard let statusCode = response.response?.statusCode else {
        return completionHandler(nil, nil)
      }
      
      if self.retryConnect(statusCode: statusCode) {
        return self.delay {
          self.executeFormData(endpoint: endpoint, completionHandler: completionHandler)
        }
      }
      
      if self.isSessionExpired(statusCode: statusCode, endpoint: endpoint) {
        return self.notification.post(name: .sessionExpired, object: nil)
      }
      
      if let element = JSONParser<Element>().parse(data: response.data) {
        return completionHandler(element, statusCode)
      }
      
      return completionHandler(nil, statusCode)
    }
  }
  
  public func executeRequestWithArray(endpoint: Endpoint, completionHandler: @escaping (_ success: Bool) -> Void) {
    guard let endpoint = endpoint as? APIEndpointWithArray else {
      return completionHandler(false)
    }
    
    manager.request(baseURL + endpoint.path,
                    method: endpoint.method,
                    parameters: endpoint.params?.asParameters(),
                    encoding: endpoint.encoding,
                    headers: HTTPHeaders(endpoint.headers))
    .validate(statusCode: 200..<400)
    .response(completionHandler: { response in
      switch response.result {
      case .success:
        return completionHandler(true)
        
      case .failure:
        guard let statusCode = response.response?.statusCode else {
          return completionHandler(false)
        }
        
        if self.retryConnect(statusCode: statusCode) {
          return self.delay {
            self.executeRequestWithArray(endpoint: endpoint, completionHandler: completionHandler)
          }
        }
        
        if self.isSessionExpired(statusCode: statusCode, endpoint: endpoint) {
          return self.notification.post(name: .sessionExpired, object: nil)
        }
        
        return completionHandler(false)
      }
    })
  }
  
  public func execute(endpoint: APIEndpoint, completionHandler: @escaping (_ success: Bool) -> Void) {
    manager.request(baseURL + endpoint.path,
                    method: endpoint.method,
                    parameters: endpoint.params,
                    encoding: endpoint.encoding,
                    headers: HTTPHeaders(endpoint.headers))
    .validate(statusCode: 200..<400)
    .response(completionHandler: { response in
      switch response.result {
      case .success:
        return completionHandler(true)
        
      case .failure:
        guard let statusCode = response.response?.statusCode else {
          return completionHandler(false)
        }
        
        if self.retryConnect(statusCode: statusCode) {
          return self.delay {
            self.execute(endpoint: endpoint, completionHandler: completionHandler)
          }
        }
        
        if self.isSessionExpired(statusCode: statusCode, endpoint: endpoint) {
          return self.notification.post(name: .sessionExpired, object: nil)
        }
        
        return completionHandler(false)
      }
    })
  }
  
  public func execute(endpoint: APIEndpoint, completionHandler: @escaping (_ success: Bool, _ code: Int?) -> Void) {
    manager.request(baseURL + endpoint.path,
                    method: endpoint.method,
                    parameters: endpoint.params,
                    encoding: endpoint.encoding,
                    headers: HTTPHeaders(endpoint.headers))
    .validate(statusCode: 200..<400)
    .response(completionHandler: { response in
      guard let statusCode = response.response?.statusCode else { return }
      switch response.result {
      case .success:
        return completionHandler(true, statusCode)
        
      case .failure:
        guard let statusCode = response.response?.statusCode else {
          return completionHandler(false, statusCode)
        }
        
        if self.retryConnect(statusCode: statusCode) {
          return self.delay {
            self.execute(endpoint: endpoint, completionHandler: completionHandler)
          }
        }
        
        if self.isSessionExpired(statusCode: statusCode, endpoint: endpoint) {
          return self.notification.post(name: .sessionExpired, object: nil)
        }
        
        return completionHandler(false, statusCode)
      }
    })
  }
  
  public func executeStatusCode<Element: Codable>(endpoint: APIEndpoint, completionHandler: @escaping (Element?, Int?) -> Void) {
    manager.request(baseURL + endpoint.path,
                    method: endpoint.method,
                    parameters: endpoint.params,
                    encoding: endpoint.encoding,
                    headers: HTTPHeaders(endpoint.headers))
    .response { response in
      guard let statusCode = response.response?.statusCode else {
        return completionHandler(nil, nil)
      }
      
      if self.retryConnect(statusCode: statusCode) {
        return self.delay {
          self.executeStatusCode(endpoint: endpoint, completionHandler: completionHandler)
        }
      }
      
      if self.isSessionExpired(statusCode: statusCode, endpoint: endpoint) {
        return self.notification.post(name: .sessionExpired, object: nil)
      }
      
      let element = JSONParser<Element>().parse(data: response.data)

      return completionHandler(element, statusCode)
    }
  }
  
  public func execute<Element: Codable>(endpoint: APIEndpoint, completionHandler: @escaping (Result<Element, Error>) -> Void) {
    manager.request(baseURL + endpoint.path,
                    method: endpoint.method,
                    parameters: endpoint.params,
                    encoding: endpoint.encoding,
                    headers: HTTPHeaders(endpoint.headers))
    .validate(statusCode: 200..<400)
    .response { response in
      guard let statusCode = response.response?.statusCode else {
        return completionHandler(.failure(APIClientError.endpointInvalid))
      }
      
      if self.retryConnect(statusCode: statusCode) {
        return self.delay {
          self.execute(endpoint: endpoint, completionHandler: completionHandler)
        }
      }
      
      if self.isSessionExpired(statusCode: statusCode, endpoint: endpoint) {
        return self.notification.post(name: .sessionExpired, object: nil)
      }
      
      if case .failure(let error) = response.result {
        return completionHandler(.failure(error))
      }
      
      if let element = JSONParser<Element>().parse(data: response.data) {
        return completionHandler(.success(element))
      }
      
      return completionHandler(.failure(APIClientError.endpointInvalid))
    }
  }
  
  // MARK: - Helpers
  
  private func isSessionExpired(statusCode: Int, endpoint: Endpoint) -> Bool {
    guard statusCode == 401, endpoint.headers["Authorization"] != nil else { return false }
    return true
  }
  
  private func retryConnect(statusCode: Int) -> Bool {
    guard [502, 503, 504, 521].contains(statusCode) && retryCount < 5 else { return false }
    retryCount += 1
    return true
  }
  
  private func delay(completionHandler: @escaping () -> Void) {
    Timer.scheduledTimer(withTimeInterval: timeDelay, repeats: false) { _ in
      completionHandler()
    }
  }
}

extension Notification.Name {
  static let sessionExpired = Notification.Name("session_expired")
}
