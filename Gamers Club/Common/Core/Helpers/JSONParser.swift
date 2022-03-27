//
//  Consts.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//

import Alamofire
import Foundation

struct JSONParser<T: Codable> {
  // MARK: - Variables
  
  func parse(data: Data?) -> T? {
    guard let data = data else { return nil }
    
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ"
    formatter.calendar = Calendar(identifier: .iso8601)
    formatter.timeZone = TimeZone(secondsFromGMT: -3)
    
    let decoder = JSONDecoder()
    decoder.dateDecodingStrategy = .formatted(formatter)
    
    return try? decoder.decode(T.self, from: data)
  }
}
