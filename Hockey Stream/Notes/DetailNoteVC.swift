//
//  DetailNoteVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 04.09.2022.
//

import UIKit

class DetailNoteVC: UIViewController {
    
    @IBOutlet var titleLabel : UILabel!
    @IBOutlet var noteLabel : UITextView!
    
    public var noteTitle: String = ""
    public var note: String = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = noteTitle
        noteLabel.text = note
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        AppDelegate.shared.playAudioFile()
        dismiss(animated: true)
    }
}
