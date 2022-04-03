//
//  ProfileModels.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 02/04/22.
//

import Foundation

// MARK: - UserMe
class UserMe: Codable {
    let id: Int?
    let name, email, nick, subscription: String?
    let level, rating: Int?
    let avatar, background: String?
    let steamid: String?
    let createTime: String?
    let country: String?

    enum CodingKeys: String, CodingKey {
        case id, name, email, nick, subscription, level, rating, avatar, background, steamid
        case createTime = "create_time"
        case country
    }

    init(id: Int?, name: String?, email: String?, nick: String?, subscription: String?, level: Int?, rating: Int?, avatar: String?, background: String?, steamid: String?, createTime: String?, country: String?) {
        self.id = id
        self.name = name
        self.email = email
        self.nick = nick
        self.subscription = subscription
        self.level = level
        self.rating = rating
        self.avatar = avatar
        self.background = background
        self.steamid = steamid
        self.createTime = createTime
        self.country = country
    }
}
