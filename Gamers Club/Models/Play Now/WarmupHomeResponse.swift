//
//  WarmupHomeResponse.swift
//  Gamers Club
//
//  Created by Felipe Almeida on 30/03/22.
//

import Foundation

// MARK: - Warmup
struct Warmup: Codable {
    let servers: [Server]?
    let ac: Bool?
    let pagination: Pagination?
}

// MARK: - Pagination
struct Pagination: Codable {
    let current, perPage, total: Int?
}

// MARK: - Server
struct Server: Codable, Equatable {
    let filterID, serverID, id: String?
    let mask: String?
    let port, slots, slotsUsed: String?
    let ip: String?
    let name: String?
    let hasReservedSlots: Bool?
    let typeName: String?
    let modeName: String?
    let modeDescription: String?
    let mapName: String?
    let mapImage: String?
    let isElite, ac: Bool?

    enum CodingKeys: String, CodingKey {
        case filterID = "filter_id"
        case serverID = "server_id"
        case id, mask, port, slots
        case slotsUsed = "slots_used"
        case ip, name
        case hasReservedSlots = "has_reserved_slots"
        case typeName = "type_name"
        case modeName = "mode_name"
        case modeDescription = "mode_description"
        case mapName = "map_name"
        case mapImage = "map_image"
        case isElite = "is_elite"
        case ac
    }
  
  public static func == (lhs: Server, rhs: Server) -> Bool {
    return lhs.filterID == rhs.filterID &&
    lhs.serverID == rhs.serverID &&
    lhs.id == rhs.id &&
    lhs.mask == rhs.mask &&
    lhs.port == rhs.port &&
    lhs.slots == rhs.slots &&
    lhs.slotsUsed == rhs.slotsUsed &&
    lhs.ip == rhs.ip &&
    lhs.name == rhs.name &&
    lhs.hasReservedSlots == rhs.hasReservedSlots &&
    lhs.typeName == rhs.typeName &&
    lhs.modeName == rhs.modeName &&
    lhs.modeDescription == rhs.modeDescription &&
    lhs.mapName == rhs.mapName &&
    lhs.mapImage == rhs.mapImage &&
    lhs.isElite == rhs.isElite &&
    lhs.ac == rhs.ac
  }
}
