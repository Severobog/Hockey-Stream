//
//  oddsPreMatches.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 04.09.2022.
//

import UIKit

class oddsPreMatches: UIViewController {
    
    @IBOutlet var gameCol: UICollectionView!
    

    var allGames : [HockeyGamesPre] = []
    
    @IBAction func backAc(_ sender: UIButton) {
        AppDelegate.shared.playAudioFile()
        dismiss(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameCol.backgroundColor = .none
        
        gameCol.delegate = self
        gameCol.dataSource = self
        
        let url = URL(string: "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=predata&sport=icehockey&day=today")
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request, completionHandler: { data, response, error -> Void in
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(HockeyPre.self, from: data!)
                let games = responseModel.gamesPre
                
                for game in games {
                    self.allGames.append(game)
                }

                DispatchQueue.main.async {
                    self.gameCol.reloadData()
                }
                
            } catch {
                print("JSON Serialization error")
            }
        }).resume()
    }
    
    func convertDateToStringGame(date: Date) -> String {
           let formatter = DateFormatter()
           formatter.dateStyle = .long
           formatter.timeStyle = .medium
           formatter.dateFormat = "dd-MM-yyyy"
           return formatter.string(from: date as Date)
    }
}

extension oddsPreMatches : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width
        return CGSize(width: yourWidth, height: 220)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}
    
extension oddsPreMatches : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesCollectionViewCell", for: indexPath) as! MatchesCollectionViewCell
        
                let date = Date(timeIntervalSince1970: Double(self.allGames[indexPath.row].time)!)
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                dateFormatter.timeZone = .current
                let localDate = dateFormatter.string(from: date)
            let components = localDate.components(separatedBy: " at ")
            
            cell.team1Lbl.text = "\(self.allGames[indexPath.row].home.name)"
            cell.team2Lbl.text = "\(self.allGames[indexPath.row].away.name)"
            cell.gameDataLbl.text = components[0]
            cell.homeTeamFlag.image = UIImage(named: "soccerImg")
            cell.awayTeamFlag.image = UIImage(named: "soccerImg")
            
            return cell
        }
}
