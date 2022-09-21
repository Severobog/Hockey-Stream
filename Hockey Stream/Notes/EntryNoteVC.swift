//
//  DetailNoteVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 04.09.2022.
//

import UIKit

class EntryVC: UIViewController {
    
    @IBOutlet var titleField : UITextField!
    @IBOutlet var noteField : UITextView!
    
    public var completion: ((String, String) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()
        titleField.becomeFirstResponder()

    }
    
    @IBAction func backButton(_ sender: UIButton) {
        AppDelegate.shared.playAudioFile()
        dismiss(animated: true)
    }
    @IBAction func saveAction(_ sender: Any) {
        AppDelegate.shared.playAudioFile()
        didTapSave()
        dismiss(animated: true)
    }
    
    @objc
    func didTapSave() {
        if let text = titleField.text, !text.isEmpty,  !noteField.text.isEmpty {
            completion?(text, noteField.text)
        }
    }
    

}
