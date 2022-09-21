//
//  StatisticHockey.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 05.09.2022.
//

import Foundation

struct hockeyStat: Codable {
    let results: [HockeyStatPre]

    enum CodingKeys: String, CodingKey {
        case results
    }
}

struct HockeyStatPre: Codable {
    let stats: hStat
    
    enum CodingKeys: String, CodingKey {
        case stats
    }
}

struct hStat: Codable {
    let shoots, penalties, goalsOnPP, s7: [String?]
    
    enum CodingKeys: String, CodingKey {
        case shoots = "shots" //Атаки по воротам - Blows
        case goalsOnPP = "goals_on_power_play"
        case penalties //Пенальти - fouls
        case s7 //Хз что это
    }
}

