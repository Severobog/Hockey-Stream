//
//  CalendarVC.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 31.08.2022.
//

import AVFoundation
import UIKit

class CalendarVC: UIViewController {
    var currentMonth = "January"
    var months = ["January", "February", "March", "April", "May", "June", "July", "August", "September", "October", "November", "December"]
    var todayDate = 2
    var actualMonth = "January"
    var yearCount = 0
    var currentYear = 2022
    
    @IBOutlet weak var daysCol: UICollectionView!
    @IBOutlet weak var monthLbl: UILabel!
    
    @IBAction func previousMonthAc(_ sender: Any) {
        AppDelegate.shared.playAudioFile()

        if currentMonth != "January"{
            let index = months.firstIndex(of: currentMonth)
            self.currentMonth = months[index! - 1]
            self.monthLbl.text = currentMonth
        }
        else{
            self.currentMonth = months.last!
            self.monthLbl.text = currentMonth
            self.yearCount -= 1
        }
        
        self.daysCol.reloadData()
        
    }
    @IBAction func nextMonthAc(_ sender: Any) {
        AppDelegate.shared.playAudioFile()

        if currentMonth != "December"{
            let index = months.firstIndex(of: currentMonth)
            self.currentMonth = months[index! + 1]
            self.monthLbl.text = currentMonth
        }
        else{
            self.currentMonth = months.first!
            self.monthLbl.text = currentMonth
            self.yearCount += 1
        }
        self.daysCol.reloadData()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let date = Date()
        let components = date.get(.day, .month, .year)
        currentMonth = months[(components.month ?? 12) - 1]
        currentYear = components.year!
        self.monthLbl.text = currentMonth
        self.daysCol.reloadData()
        todayDate = components.day ?? 2
        actualMonth = months[(components.month ?? 12) - 1]
    }
}
extension CalendarVC : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width - 14) / 6
        return CGSize(width: yourWidth, height: yourWidth)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 2
    }
}
extension CalendarVC : UICollectionViewDataSource,UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        
        switch currentMonth{
        case "September","April","June","November":
            return 30
        case "January","March","May","July","August","October","December":
            return 31
        case "February":
            return 28
        default:
            return 31
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DaysCollectionViewCell", for: indexPath) as! CalendarCell
        cell.dateLbl.text = "\(indexPath.row + 1)"
        cell.dateLbl.textColor = .black
        cell.contentView.backgroundColor = .white
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        AppDelegate.shared.playAudioFile()
    }

}
extension Date {
    func get(_ components: Calendar.Component..., calendar: Calendar = Calendar.current) -> DateComponents {
        return calendar.dateComponents(Set(components), from: self)
    }

    func get(_ component: Calendar.Component, calendar: Calendar = Calendar.current) -> Int {
        return calendar.component(component, from: self)
    }
}
