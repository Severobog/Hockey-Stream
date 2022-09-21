//
//  HockeyPre.swift
//  SportsLibrary
//
//  Created by Usman Qamar on 8/28/22.
//

import Foundation

struct HockeyPre: Codable {
    let timeRequest: Double
    let capacityRequests, remainRequests, lastTimeYourKey, dateGames: String
    let gamesPre: [HockeyGamesPre]

    enum CodingKeys: String, CodingKey {
        case timeRequest = "time_request"
        case capacityRequests = "capacity_requests"
        case remainRequests = "remain_requests"
        case lastTimeYourKey = "last_time_your_key"
        case dateGames = "date_games"
        case gamesPre = "games_pre"
    }
}

// MARK: - GamesPre
struct HockeyGamesPre: Codable {
    let gameID, time, timeStatus: String
    let league, home, away: AwayHockey

    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case timeStatus = "time_status"
        case time
        case league, home, away
    }
}

// MARK: - Away
struct AwayHockey: Codable {
    let name, id: String
    let imageID: String?
    let cc: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageID = "image_id"
        case cc
    }
}
