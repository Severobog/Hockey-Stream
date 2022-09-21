//
//  FactorVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 04.09.2022.
//

import UIKit

class FactorVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
   

    @IBOutlet var colView: UICollectionView!
    
    let models = ["BestBets", "OneBet", "TwoBet", "LionBet"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        colView.delegate = self
        colView.dataSource = self
        
        colView.backgroundColor = .none
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return models.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = colView.dequeueReusableCell(withReuseIdentifier: "oddsCell", for: indexPath) as! bukCell
        
        cell.betLbl.text = models[indexPath.row]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppDelegate.shared.playAudioFile()
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "factor") as? oddsPreMatches else {return}
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
