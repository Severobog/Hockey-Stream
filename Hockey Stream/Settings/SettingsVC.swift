//
//  SettingsVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 31.08.2022.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet var settingsView: UIView!
    @IBOutlet var screenLight: UISlider!
    @IBOutlet var segmentedSound: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        screenLight.minimumValue = 0
        screenLight.maximumValue = 1
        
        if AppDelegate.shared.volumeEnabel {
            segmentedSound.selectedSegmentIndex = 0
        } else  {
            segmentedSound.selectedSegmentIndex = 1
        }
        
    }
    
    @IBAction func screenLightAction(_ sender: UISlider) {
        UIScreen.main.brightness = CGFloat(sender.value)
        
    }
    @IBAction func volumeControll(_ sender: UISegmentedControl) {
        
        if AppDelegate.shared.volumeEnabel {
            AppDelegate.shared.volumeEnabel = false
            
        } else  {
            AppDelegate.shared.volumeEnabel = true
            AppDelegate.shared.playAudioFile()
        }
    }
    
}
