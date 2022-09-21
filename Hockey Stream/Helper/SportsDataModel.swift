//
//  SportsDataModel.swift
//  BetweenSports
//
//  Created by Shailesh on 16/07/22.
//

import Foundation


// MARK: - Body
class SportsDataModel {
    
    let tournamentID: Int
    let tournamentName: String
    let gameID: Int
    var height: Int?
    let gameStart: Int
    let opp1_Name: String
    let opp2_Name: String
    let opp1_Icon, opp2_Icon: Int
    let scoreFull: String
    var oddsList = [OddsList]()
    var oddsData = [OddsData]()

    init(data: [String: Any]) {
        self.tournamentID = data["tournament_id"] as? Int ?? 0
        self.tournamentName = data["tournament_name"] as? String ?? ""
        self.gameID = data["game_id"] as? Int ?? 0
        
        self.gameStart = data["game_start"] as? Int ?? 0

        self.opp1_Name = data["opp_1_name"] as? String ?? ""
        self.opp2_Name = data["opp_2_name"] as? String ?? ""
        
        self.opp1_Icon = data["opp_1_icon"] as? Int ?? 0
        self.opp2_Icon = data["opp_2_icon"] as? Int ?? 0
        
        self.scoreFull = data["score_full"] as? String ?? ""
        
        self.oddsList = OddsList.getArray(arr: data["game_oc_list"] as? [[String: Any]] ?? [[String: Any]]())
        var temp = [OddsData]()
        self.oddsList.forEach { obj in
            if obj.oddsName == opp1_Name {
                temp.append(OddsData(name: "1", rate: String(obj.oddRate)))
            } else if obj.oddsName == opp2_Name {
                temp.append(OddsData(name: "2", rate: String(obj.oddRate)))
            } else if obj.oddsName == "Draw" {
                temp.append(OddsData(name: "X", rate: String(obj.oddRate)))
            } else if obj.oddsName.contains(opp1_Name) && obj.oddsName.contains("Or X") {
                temp.append(OddsData(name: "1X", rate: String(obj.oddRate)))
            } else if obj.oddsName.contains(opp2_Name) && obj.oddsName.contains("Or X") {
                temp.append(OddsData(name: "2X", rate: String(obj.oddRate)))
            } else if obj.oddsName.contains(opp1_Name) && obj.oddsName.contains(opp2_Name) {
                temp.append(OddsData(name: "12", rate: String(obj.oddRate)))
            }
        }
        oddsData = temp
        
        
    }
    
    class func getArray(arr: [[String: Any]]) -> [SportsDataModel] {
        var temp = [SportsDataModel]()
        for obj in arr {
            temp.append(SportsDataModel(data: obj))
        }
        return temp
    }
  
}

// MARK: - EventsList
class OddsList {
    
    var oddsName = ""
    var oddRate = 0.0
    
    init(data: [String: Any]) {
        self.oddsName = data["oc_name"] as? String ?? ""
        self.oddRate = data["oc_rate"] as? Double ?? 0.0
    }
    class func getArray(arr: [[String: Any]]) -> [OddsList] {
        var temp = [OddsList]()
        for obj in arr {
            temp.append(OddsList(data: obj))
        }
        return temp
    }
    
}


// MARK: - Store
class OddsData {
    
    var oddsName = ""
    var oddRate = ""
    
    init(name: String, rate: String) {
        self.oddsName = name
        self.oddRate = rate
    }
   
    
}
