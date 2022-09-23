//
//  HockeyLive.swift
//  Hockey Stream
//
//  Created by Демид Стариков on 23.09.2022.
//


import Foundation

struct HockeyLive: Codable {
    let gamesLive: [HockeyGamesLive]

    enum CodingKeys: String, CodingKey {
        case gamesLive = "games_live"
    }
}

// MARK: - GamesPre
struct HockeyGamesLive: Codable {
    let gameID, time, timeStatus, score: String
    let league, home, away: AwayHockeyLive

    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case timeStatus = "time_status"
        case time
        case score
        case league, home, away
    }
}

// MARK: - Away
struct AwayHockeyLive: Codable {
    let name, id: String
    let imageID: String?
    let cc: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageID = "image_id"
        case cc
    }
}
