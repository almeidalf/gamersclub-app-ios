//
//  Init.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//
//   let init = try? newJSONDecoder().decode(Init.self, from: jsonData)

import Foundation

// MARK: - InitResponse

final class InitResponse: Codable {
    let loggedUser: LoggedUser?
    let lastMatches: [LastMatch]?
    let playerInfo: PlayerInfo?
    let character: Character?
    let matchesRating: MatchesRating?
    let stats: [Stat]?
}

// MARK: - Character
final class Character: Codable {
    let totalHits: Int?
    let hitbox: Hitbox?
}

// MARK: - Hitbox
final class Hitbox: Codable {
    let head, chest, stomach, leftArm: Int?
    let rightArm, leftLeg, rightLeg: Int?
}

// MARK: - LastMatch
final class LastMatch: Codable {
    let id: Int?
    let teamNameA: String?
    let scoreA: Int?
    let teamNameB: String?
    let scoreB, win, ratingPlayer, ratingDiff: Int?
    let map, type: String?
}

// MARK: - LoggedUser
final class LoggedUser: Codable {
    let id: Int?
    let isSubscriber: Bool?
}

// MARK: - MatchesRating
final class MatchesRating: Codable {
    let max, min: Int?
}

// MARK: - PlayerInfo
final class PlayerInfo: Codable {
    let id: Int?
    let nick: String?
    let level, rating: Int?
    let isSubscriber: Bool?
    let statsBackground: String?
    let isCalibrating: Bool?
    let calibrationMatches: Int?
}

// MARK: - Stat
final class Stat: Codable {
    let stat, value, diff: String?
}
