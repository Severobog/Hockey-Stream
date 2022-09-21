//
//  CompleatedVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 31.08.2022.
//

import UIKit

class CompleatedVC: UIViewController {
    
    @IBOutlet var gameCol: UICollectionView!
    
    var allHockeyGames : [HockeyGamesEnd] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        gameCol.backgroundColor = .none
        
        gameCol.delegate = self
        gameCol.dataSource = self
        
        let urlNew = URL(string: "https://spoyer.com/api/get.php?login=ayna&token=12784-OhJLY5mb3BSOx0O&task=enddata&sport=icehockey&day=20220901&p=1")
        var requestNew = URLRequest(url: urlNew!)
        requestNew.httpMethod = "GET"

        URLSession.shared.dataTask(with: requestNew, completionHandler: { data, response, error -> Void in
            
            do {
                let jsonDecoder = JSONDecoder()
                let responseModel = try jsonDecoder.decode(HockeyEnd.self, from: data!)
                
                self.allHockeyGames = responseModel.gamesEnd
                
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

extension CompleatedVC : UICollectionViewDelegateFlowLayout{
    
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
    
extension CompleatedVC : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return allHockeyGames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesCollectionViewCell", for: indexPath) as! MatchesCollectionViewCell
            let date = Date(timeIntervalSince1970: Double(self.allHockeyGames[indexPath.row].time)!)
                let dateFormatter = DateFormatter()
                dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                dateFormatter.timeZone = .current
                let localDate = dateFormatter.string(from: date)
            let components = localDate.components(separatedBy: " at ")
            
            cell.team1Lbl.text = "\(self.allHockeyGames[indexPath.row].home.name)"
            cell.team2Lbl.text = "\(self.allHockeyGames[indexPath.row].away.name)"
            cell.gameDataLbl.text = components[0]
            cell.homeTeamFlag.image = UIImage(named: "hockeyImg")
            cell.awayTeamFlag.image = UIImage(named: "hockeyImg")
            cell.scoreLbl.text = "\(self.allHockeyGames[indexPath.row].score)"
            
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            AppDelegate.shared.playAudioFile()
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "hockey") as? HockeyStatisticVC else {return}
            vc.modalPresentationStyle = .overFullScreen
            print(self.allHockeyGames[indexPath.row].gameID)
            vc.gameID = self.allHockeyGames[indexPath.row].gameID
            vc.gameCell = {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MatchesCollectionViewCell", for: indexPath) as! MatchesCollectionViewCell
                let date = Date(timeIntervalSince1970: Double(self.allHockeyGames[indexPath.row].time)!)
                    let dateFormatter = DateFormatter()
                    dateFormatter.timeStyle = DateFormatter.Style.medium //Set time style
                    dateFormatter.dateStyle = DateFormatter.Style.medium //Set date style
                    dateFormatter.timeZone = .current
                    let localDate = dateFormatter.string(from: date)
                let components = localDate.components(separatedBy: " at ")

                cell.team1Lbl.text = "\(self.allHockeyGames[indexPath.row].home.name)"
                cell.team2Lbl.text = "\(self.allHockeyGames[indexPath.row].away.name)"
                cell.gameDataLbl.text = components[0]
                cell.homeTeamFlag.image = UIImage(named: "hockeyImg")
                cell.awayTeamFlag.image = UIImage(named: "hockeyImg")
                cell.scoreLbl.text = "\(self.allHockeyGames[indexPath.row].score)"

                return cell
            }()
            present(vc, animated: true)
    }
}
