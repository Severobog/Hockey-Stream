//
//  NotesVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 31.08.2022.
//

import UIKit

class NotesVC: UIViewController, UITableViewDelegate, UITableViewDataSource  {

    @IBOutlet var addButton: UIButton!
    @IBOutlet var tableView: UITableView!
    @IBOutlet var noNotes: UIView!
    
    var models : [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        if models.isEmpty {
            tableView.isHidden = true
        } else {
            noNotes.isHidden = true
        }
    }
    
    @IBAction func addNote(_ sender: UIButton) {
        AppDelegate.shared.playAudioFile()
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "new") as? EntryVC else {return}
        vc.completion = { noteTitle, note in
            self.models.append((noteTitle, note))
            self.noNotes.isHidden = true
            self.tableView.isHidden = false
            self.tableView.reloadData()
        }
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath)
        
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let model = models[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? DetailNoteVC else {return}
        AppDelegate.shared.playAudioFile()
        vc.noteTitle = model.title
        vc.note = model.note
        vc.modalPresentationStyle = .overFullScreen
        present(vc, animated: true)
    }
    
}
