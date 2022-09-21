//
//  HockeyEnd.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 04.09.2022.
//

import Foundation

struct HockeyEnd: Codable {
    let timeRequest: Double
    let capacityRequests, remainRequests, lastTimeYourKey, dateGames: String
    let gamesEnd: [HockeyGamesEnd]

    enum CodingKeys: String, CodingKey {
        case timeRequest = "time_request"
        case capacityRequests = "capacity_requests"
        case remainRequests = "remain_requests"
        case lastTimeYourKey = "last_time_your_key"
        case dateGames = "date_games"
        case gamesEnd = "games_end"
    }
}

// MARK: - GamesEnd
struct HockeyGamesEnd: Codable {
    let gameID, time, timeStatus: String
    let league, home, away: EndHockey
    let score: String

    enum CodingKeys: String, CodingKey {
        case gameID = "game_id"
        case time
        case timeStatus = "time_status"
        case league, home, away, score
    }
}

// MARK: - Away
struct EndHockey: Codable {
    let name, id: String
    let imageID: String?
    let cc: String

    enum CodingKeys: String, CodingKey {
        case name, id
        case imageID = "image_id"
        case cc
    }
}
