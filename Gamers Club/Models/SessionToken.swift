//
//  SessionToken.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 22/03/22.
//

import Foundation

// MARK: - SessionToken
struct SessionToken: Codable {
    let id, exp: Int
    let token: String
}
