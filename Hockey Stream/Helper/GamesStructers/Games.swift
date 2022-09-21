//
//  Games.swift
//  Soccer stream
//
//  Created by Usman Qamar on 8/16/22.
//

import Foundation

// MARK: - Games
struct Games: Codable {
    let timeRequest: Double
    let capacityRequests, remainRequests, lastTimeYourKey: String
    let gamesLive: [GamesLive]

    enum CodingKeys: String, CodingKey {
        case timeRequest = "time_request"
        case capacityRequests = "capacity_requests"
        case remainRequests = "remain_requests"
        case lastTimeYourKey = "last_time_your_key"
        case gamesLive = "games_live"
    }
}

// MARK: - GamesLive
struct GamesLive: Codable {
    let gameID, time, timeStatus: String
    let league, home, away: Away
    let timer, score, bet365ID: String

    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case time
        case timeStatus = "time_status"
        case league, home, away, timer, score
        case bet365ID = "bet365_id"
    }
}

// MARK: - Away
struct Away: Codable {
    let name, id: String
    let imageID: String?
    let cc: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageID = "image_id"
        case cc
    }
}
