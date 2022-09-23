//
//  FootballCell.swift
//  BetweenSports
//
//  Created by Shailesh on 11/07/22.
//

import UIKit

class MatchesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var gameDataLbl: UILabel!
    
    @IBOutlet weak var homeTeamFlag: UIImageView!
    @IBOutlet weak var awayTeamFlag: UIImageView!
    
    @IBOutlet weak var team1Lbl: UILabel!
    @IBOutlet weak var team2Lbl: UILabel!
    
    @IBOutlet weak var scoreLbl: UILabel!
    
    @IBOutlet var liveLbl: UIButton!
}
