//
//  NewsDetailsVC.swift
//  BetweenSports
//
//  Created by Shailesh on 12/07/22.
//

import UIKit

class NewsDetailsVC: UIViewController {
    
    //********************************************
    //MARK: - Outlet
    //********************************************
    
    @IBOutlet weak var imgNews: UIImageView!
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var lblNewsTitle: UILabel!
    @IBOutlet weak var lblNewsDetails: UITextView!

    //********************************************
    //MARK: - Propties
    //********************************************
    
    var details: Layout?
    private let viewModel = NewsDetailsVM()
    
    //********************************************
    //MARK: - LifeCycle
    //********************************************
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        apiCall()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgNews.setImage(url: details?.contents[0].consumable?.image_uri ?? "", placeholderImage: UIImage(named: "ic_news_bg"))
        lblNewsTitle.text = details?.contents[0].consumable?.title
    }
    
    @IBAction func backToNews(_ sender: UIButton) {
        AppDelegate.shared.playAudioFile()
        dismiss(animated: true)
    }
    
    
    
    func apiCall() {
        viewModel.newsDetailsApi(id: details?.contents[0].consumable?.id ?? "") { success in
            if success {
                self.lblNewsDetails.text = self.viewModel.newsBody
            }
        }
    }
}
