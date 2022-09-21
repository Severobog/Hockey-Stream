//
//  File.swift
//  BetweenSports
//
//  Created by Shailesh on 16/07/22.
//

import Foundation

class CommonViewModel {
    lazy var apiClient = APIClient()
    
    var errorMessage = ""
    var url = ""
    var matchData = [SportsDataModel]()
    
    var newsData: NewsDataModel?
    
    func gameDataApi(GameName: String, completion: @escaping (_ success: Bool) -> Void) {
        
        if GameName == "Football" {
            url = "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=soccer&day=today"
        } else if GameName == "Hockey" {
            url = "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=icehockey&day=today"
        }
        
        
        _ = apiClient.getMatchData(url: url, completionBlock: { (response, error)  in
            
            if error != nil {
                completion(false)
            }
            
            guard let response = response else {
                completion(false)
                return
            }
            self.matchData.removeAll()
            let data = response["body"] as? [[String: Any]]  ?? [[String: Any]]()
            self.matchData = SportsDataModel.getArray(arr: data)

            
            
            completion(true)
            
        })
    }
    
    func gameDataUpacomingApi(GameName: String, completion: @escaping (_ success: Bool) -> Void) {
        
        
        if GameName == "Football" {
            url = "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=soccer&day=today"
        } else if GameName == "Hockey" {
            url = "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=icehockey&day=today"
        }
        
        
        _ = apiClient.getMatchData(url: url, completionBlock: { (response, error)  in
            
            if error != nil {
                completion(false)
            }
            
            guard let response = response else {
                completion(false)
                return
            }
            self.matchData.removeAll()
            let data = response["body"] as? [[String: Any]]  ?? [[String: Any]]()
            self.matchData = SportsDataModel.getArray(arr: data)

            completion(true)
            
        })
    }
    
    func newsDataApi(completion: @escaping (_ success: Bool) -> Void) {
        
        
       let base = "https://graphql.theathletic.com/graphql?extensions=%7B%22persistedQuery%22:%7B%22sha256Hash%22:%223d8dd131e53c6ec755686b69d96412b5d48a8ee4807ecccee5b4c8bda5a82bae%22,%22version%22:1%7D%7D&variables=%7B%22filter%22:%7B%22feed_id%22:10859991,%22feed_type%22:%22following%22,%22layouts%22:%5B%7B%22consumable_types%22:%5B%22article%22,%22qanda%22,%22discussion%22,%22liveBlog%22,%22news%22%5D,%22layout_type%22:%22one_content_curated%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22qanda%22,%22discussion%22,%22liveBlog%22,%22news%22%5D,%22layout_type%22:%22three_content_curated%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22qanda%22,%22discussion%22,%22liveBlog%22,%22news%22%5D,%22layout_type%22:%22four_content_curated%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22qanda%22,%22discussion%22,%22liveBlog%22,%22news%22%5D,%22layout_type%22:%22curated_content_list%22%7D,%7B%22consumable_types%22:%5B%22brief%22%5D,%22layout_type%22:%22shortforms%22%7D,%7B%22consumable_types%22:%5B%22news%22%5D,%22layout_type%22:%22headlines_list%22%7D,%7B%22consumable_types%22:%5B%22news%22%5D,%22layout_type%22:%22single_headline%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22single_content%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22three_content%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22highlight_three_content%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22four_content%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22highlight_four_content%22%7D,%7B%22consumable_types%22:%5B%22podcast%22%5D,%22layout_type%22:%22recommended_podcasts%22%7D,%7B%22consumable_types%22:%5B%22article%22%5D,%22layout_type%22:%22most_popular_articles%22%7D,%7B%22consumable_types%22:%5B%22podcast_episode%22%5D,%22layout_type%22:%22podcast_episodes_list%22%7D,%7B%22consumable_types%22:%5B%22podcast_episode%22%5D,%22layout_type%22:%22podcast_episode%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22one_content%22%7D,%7B%22consumable_types%22:%5B%22announcement%22%5D,%22layout_type%22:%22announcement%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22one_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22two_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22three_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22four_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22four_gallery_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22five_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22five_gallery_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22six_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22six_plus_gallery_curation%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22podcast_episode%22,%22discussion%22,%22qanda%22,%22news%22,%22liveBlog%22%5D,%22layout_type%22:%22seven_plus_hero_curation%22%7D,%7B%22consumable_types%22:%5B%22topic%22%5D,%22layout_type%22:%22topic%22%7D,%7B%22consumable_types%22:%5B%22liveRoom%22%5D,%22layout_type%22:%22live_room%22%7D,%7B%22consumable_types%22:%5B%22article%22,%22discussion%22,%22qanda%22%5D,%22layout_type%22:%22more_for_you%22%7D,%7B%22consumable_types%22:%5B%22spotlight%22%5D,%22layout_type%22:%22spotlight_carousel%22%7D,%7B%22consumable_types%22:%5B%22feed_game%22%5D,%22layout_type%22:%22scores%22%7D%5D,%22locale%22:%22en-RU%22,%22page%22:0,%22platform%22:%22ios%22%7D%7D"
        
        _ = apiClient.getMatchData(url: base, completionBlock: { (response, error)  in
            
            if error != nil {
                completion(false)
            }
            
            guard let response = response else {
                completion(false)
                return
            }
            let data = response["data"] as? [String: Any]  ?? [String: Any]()
            self.newsData = NewsDataModel(data: data)
             
            completion(true)
            
        })
    }
    
}
