//
//  NewsCell.swift
//  BetweenSports
//
//  Created by Shailesh on 12/07/22.
//

import UIKit

class NewsCell: UITableViewCell {
    
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func upadateValue(obj: Layout) {
        imgNews.setImage(url: obj.contents[0].consumable?.image_uri ?? "", placeholderImage: UIImage(named: "ic_news_bg"))
        lblTitle.text = obj.contents[0].consumable?.title
    }
    
}
