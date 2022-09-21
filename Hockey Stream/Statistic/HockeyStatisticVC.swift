//
//  HockeyStatisticVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 04.09.2022.
//

import UIKit

class HockeyStatisticVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet var gameCellView: UICollectionView!
    
    var gameCell = MatchesCollectionViewCell()
    var gameID = ""
    var games : [HockeyStatPre] = []

    @IBOutlet var shoots1: UILabel!
    @IBOutlet var shoots2: UILabel!
    
    @IBOutlet var penalties1: UILabel!
    @IBOutlet var penalties2: UILabel!
    
    @IBOutlet var goalsPP1: UILabel!
    @IBOutlet var goalsPP2: UILabel!
    
    @IBOutlet var s71: UILabel!
    @IBOutlet var s72: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameCellView.dataSource = self
        gameCellView.delegate = self
        
        let url = URL(string: "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=eventdata&game_id=\(gameID)")
        
        //5144221

        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(hockeyStat.self, from: data!)
                self.games = responseModel.results
                
                DispatchQueue.main.async {
                     self.statLoad()
                }
               
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
    
    func statLoad() {
        shoots1.text = (games.first!.stats.shoots.first)!
        shoots2.text = (games.first!.stats.shoots.last)!
        if shoots1.text == nil {
            shoots1.text = "0"
        }

        if shoots2.text == nil {
            shoots2.text = "0"
        }
        
        penalties1.text = (games.first!.stats.penalties.first)!
        penalties2.text = (games.first!.stats.penalties.last)!
        
        goalsPP1.text = (games.first!.stats.goalsOnPP.first)!
        goalsPP2.text = (games.first!.stats.goalsOnPP.last)!
        
        s71.text = (games.first!.stats.s7.first)!
        s71.text = (games.first!.stats.s7.first)!
    }

    @IBAction func backButton(_ sender: UIButton) {
        AppDelegate.shared.playAudioFile()
        dismiss(animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesCollectionViewCell", for: indexPath) as! MatchesCollectionViewCell
        
        cell = gameCell
        
        return cell
    }
    
}
