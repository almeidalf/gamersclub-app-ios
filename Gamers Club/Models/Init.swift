//
//  Init.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 23/03/22.
//
//   let init = try? newJSONDecoder().decode(Init.self, from: jsonData)

import Foundation

// MARK: - Init
struct Init: Codable {
    let loggedUser: LoggedUser?
    let lastMatches: [LastMatch]?
    let playerInfo: PlayerInfo?
    let character: Character?
    let matchesRating: MatchesRating?
    let stats: [Stat]?
}

// MARK: - Character
struct Character: Codable {
    let totalHits: Int?
    let hitbox: Hitbox?
}

// MARK: - Hitbox
struct Hitbox: Codable {
    let head, chest, stomach, leftArm: Int?
    let rightArm, leftLeg, rightLeg: Int?
}

// MARK: - LastMatch
struct LastMatch: Codable {
    let id: Int?
    let teamNameA: String?
    let scoreA: Int?
    let teamNameB: String?
    let scoreB, win, ratingPlayer, ratingDiff: Int?
    let map, type: String?
}

// MARK: - LoggedUser
struct LoggedUser: Codable {
    let id: Int?
    let isSubscriber: Bool?
}

// MARK: - MatchesRating
struct MatchesRating: Codable {
    let max, min: Int?
}

// MARK: - PlayerInfo
struct PlayerInfo: Codable {
    let id: Int?
    let nick: String?
    let level, rating: Int?
    let isSubscriber: Bool?
    let statsBackground: JSONNull?
    let isCalibrating: Bool?
    let calibrationMatches: Int?
}

// MARK: - Stat
struct Stat: Codable {
    let stat, value, diff: String?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
