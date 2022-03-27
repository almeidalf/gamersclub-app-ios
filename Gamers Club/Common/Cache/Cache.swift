//
//  Cache.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 25/03/22.
//
import Foundation

public struct Cache {
  // MARK: - Variables
  
  public static var gclubsess: String? {
    get {
      UserDefaults.standard.string(forKey: Constants.gclubsess_SESSION)
    }
    
    set {
      UserDefaults.standard.set(newValue, forKey: Constants.gclubsess_SESSION)
    }
  }
  
  public static var profileSession: SessionToken? {
    get {
      guard let data = UserDefaults.standard.data(forKey: "token_profile") else { return nil }
      let session = try? JSONDecoder().decode(SessionToken.self, from: data)
      return session
    }
    
    set {
      let data = try? JSONEncoder().encode(newValue)
      UserDefaults.standard.set(data, forKey: "token_profile")
    }
  }
}
