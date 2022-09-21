//
//  Extension.swift
//  Waydari
//
//  Created by Ravi's mac on 13/06/18.
//  Copyright © 2018 macOs. All rights reserved.
//

import Foundation
import UIKit
import Photos
import AudioToolbox
import SDWebImage
import Accelerate
import Security
import CoreFoundation

import CommonCrypto
import Alamofire

// *************************************************************************
// MARK:-
// MARK:-   Constants
// *************************************************************************
//Naboleia

let AppName = "Sports Factor"
let userDefault = UserDefaults.standard

let appdelegate = UIApplication.shared.delegate as! AppDelegate
//let splashScreen = SplashVC()


func mandatoryMark(_ color: UIColor) -> NSAttributedString {
    
    let mark = " *"
    let attrib = NSAttributedString(string: mark, attributes: [NSAttributedString.Key.font:UIFont.systemFont(ofSize: 17), NSAttributedString.Key.foregroundColor: color])
    return attrib
}
extension UIImageView {
    
    func setUserImage(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "ic_Profile"), options: .retryFailed)
    }
    
    func setNewsImage(url: String) {
        self.sd_setImage(with: URL(string: url), placeholderImage: UIImage(named: "Icon Round"), options: .retryFailed)
    }
    
    func setImage(url: String, placeholderImage: UIImage? = nil) {
        self.sd_setImage(with: URL(string: url), placeholderImage: placeholderImage, options: .retryFailed)
    }
}

//func setAfter(_ delay: Double = 0.01, closure: @escaping @convention(block) () -> Swift.Void) {
//
//    DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
//        closure()
//    }
//}

extension Date {
          func timeAgoDisplay() -> String {
        let secondsAgo = Int(Date().timeIntervalSince(self))

        let minute = 60
        let hour = 60 * minute
        let day = 24 * hour
        let week = 7 * day

        if secondsAgo < minute {
            return "\(secondsAgo) sec ago"
        } else if secondsAgo < hour {
            return "\(secondsAgo / minute) min ago"
        } else if secondsAgo < day {
            return "\(secondsAgo / hour) hrs ago"
        } else if secondsAgo < week {
            return "\(secondsAgo / day) days ago"
        }

        return "\(secondsAgo / week) weeks ago"
    }
}

extension Date {
    var millisecondsSince1970: Int64 {
        Int64((self.timeIntervalSince1970 * 1000.0).rounded())
    }
    
    init(milliseconds: Int64) {
        self = Date(timeIntervalSince1970: TimeInterval(milliseconds) / 1000)
    }
}




func takeScreenshot() -> UIImage? {
    var screenshotImage :UIImage?
    let layer = UIApplication.shared.keyWindow!.layer
    let scale = UIScreen.main.scale
    UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
    guard let context = UIGraphicsGetCurrentContext() else {return nil}
    layer.render(in:context)
    screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    return screenshotImage
}

func setCustomdataToUserdefault(_ customData: Any, forKey: String) {
    let data = NSKeyedArchiver.archivedData(withRootObject: customData)
    UserDefaults.standard.set(data, forKey: forKey)
    UserDefaults.standard.synchronize()
}

func getCustomData(_ forKey: String) -> Any? {
    let customData = UserDefaults.standard.object(forKey: forKey) as! Data
    return NSKeyedUnarchiver.unarchiveObject(with: customData)
}

func addCodableClassToUserDefault<T: Codable>(obj: T, forKey: String) {
    let encoder = JSONEncoder()
    if let encoded = try? encoder.encode(obj) {
        UserDefaults.standard.set(encoded, forKey: forKey)
        UserDefaults.standard.synchronize()
    }
}

func getCodableClassFromUserDefault<T: Codable>(type: T.Type, forKey: String) -> T? {
    if let savedObj = UserDefaults.standard.object(forKey: forKey) as? Data {
        let decoder = JSONDecoder()
        if let loadedObj = try? decoder.decode(T.self, from: savedObj) {
            return loadedObj
        } else {
            return nil
        }
    } else {
        return nil
    }
}



// MARK:-
// MARK:-   Play System Sound
class Sound {
    static var soundID: SystemSoundID = 0
    static func install(_ fileName: String = "", ext: String = "", soundiD: SystemSoundID = 0) {
        guard let url = Bundle.main.url(forResource: fileName, withExtension: ext) else { return  }
        soundID = soundiD
        AudioServicesCreateSystemSoundID(url as CFURL, &soundID)
    }
    static func play() {
        guard soundID != 0 else { return }
        AudioServicesPlaySystemSound(soundID)
    }
    static func dispose() {
        guard soundID != 0 else { return }
        AudioServicesDisposeSystemSoundID(soundID)
    }
}


// ***************************************************************
// MARK:-
// MARK:-   PHAsset
// ***************************************************************
extension PHAsset {
    
    var originalFilename: String? {
        
        var fname:String?
        
        if #available(iOS 9.0, *) {
            let resources = PHAssetResource.assetResources(for: self)
            if let resource = resources.first {
                fname = resource.originalFilename
            }
        }
        
        if fname == nil {
            fname = self.value(forKey: "filename") as? String
        }
        
        return fname
    }
}


extension Sequence where Iterator.Element == UIView {
    
    func setRound() {
        self.forEach { (v) in
            v.setRound()
        }
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        self.forEach { (v) in
            v.cornerRadius = radius
        }
    }
    
    
    
    func setShadow(_ radius: CGFloat, _ width: CGFloat, _ height: CGFloat, _ color:UIColor, _ opacity: Float = 1.0) {
        self.forEach { (v) in
            v.setShadow(radius, width, height, color, opacity)
        }
    }
    
}

extension Sequence where Iterator.Element == UITextField {
    
    func setCornerRadius(_ radius: CGFloat) {
        self.forEach { (v) in
            v.cornerRadius = radius
        }
    }
    
    
    
    
    
    func setBlankView(_ width: CGFloat, _ side: Side = .Left) {
        self.forEach { (v) in
            v.setBlankView(width, side)
        }
    }
    
//    func setView(_ image: UIImage, _ width: CGFloat, _ imageWidth: CGFloat, _ side: Side = .Left) {
//        self.forEach { (v) in
//            v.setView(image, width, imageWidth, side)
//        }
//    }
    
    func setLeftSemantic() {
        self.forEach { (tf) in
            tf.setLeftSemantic()
        }
    }
    
    func setRightSemantic() {
        self.forEach { (tf) in
            tf.setRightSemantic()
        }
    }
}


extension UIWindow {
    
    func setRootVC(_ vc: UIViewController) -> UIWindow {
        self.rootViewController = vc
        return self
    }
}

//Show PopUp
func getView<T>(viewT: T.Type) -> T {
    
    let v = UINib(nibName: String(describing: viewT), bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as! T
    return v
}

func openXIB(XIB : UIView){
    (AppDelegate.shared.window!.rootViewController! as! UINavigationController).viewControllers.last!.view.addSubview(XIB)
    XIB.frame = UIScreen.main.bounds
    XIB.alpha = 0.0

    UIView.animate(withDuration: 0.25) {
        XIB.alpha = 1.0
    }
}


// ***************************************************************
// MARK:-
// MARK:-  UIViewControler
// ***************************************************************
extension UIViewController {
//    
    func pushVC(_ vc: UIViewController, animated: Bool = true) {
        
        if let nav = navigationController {
            nav.pushViewController(vc, animated: animated)
        }
    }
    
    func backVC() {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    func pushNews() {
        let vc1 = self.storyboard?.instantiateViewController(withIdentifier: "NewsVC") as! NewsVC
        self.navigationController?.pushViewController(vc1, animated: true)
    }

    
    func alertWith(_ title: String? = AppName, message: String?, type: UIAlertController.Style = UIAlertController.Style.alert, cancelTitle:String? = "OK",  othersTitle: [String] = [], sheetSourceView: UIView? = nil, cancelTap:(()->())? = nil, othersTap: ((_ index: Int, _ title: String)->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: type)
        if othersTitle .count > 0 {
            for (index, str) in othersTitle.enumerated() {
                alert.addAction(UIAlertAction(title: str, style: .default, handler: { (action) in
                    othersTap?(index, str)
                    UIControl().sendAction(#selector(URLSessionTask.suspend), to: UIApplication.shared, for: nil)
                }))
            }
        }
        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel, handler: { (action) in
            cancelTap?()
        }))
        if type == .actionSheet, sheetSourceView != nil, UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad {
            alert.popoverPresentationController?.permittedArrowDirections = .any
            alert.popoverPresentationController?.sourceView = sheetSourceView
            alert.popoverPresentationController?.sourceRect = sheetSourceView!.bounds
        }
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    func errorAlert(_ title: String = AppName, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK".localized, style: .default, handler: { (action) in
        }))
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successAlert(_ title: String = AppName, message: String, doneAction:(()->())? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action) in
            if doneAction != nil {
                doneAction!()
            }
        }))
        
        DispatchQueue.main.async {
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func popToVC<T: UIViewController>(_ viewcontroller: T.Type, animted: Bool = true) {
        if let navvc = navigationController {
            popFromNav(navvc, viewcontroller: viewcontroller, animted: animted)
        }
        else if self is UINavigationController {
            if let navvc = self as? UINavigationController {
                popFromNav(navvc, viewcontroller: viewcontroller, animted: animted)
            }
        }
    }
    
    private func popFromNav<T: UIViewController>(_ navvc: UINavigationController, viewcontroller: T.Type, animted: Bool = true) {
        for vc in navvc.viewControllers {
            if vc.isKind(of: viewcontroller) {
                navvc.popToViewController(vc, animated: animted)
                break
            }
        }
    }
    
    
    
    func hasNavigationVC<T : UIViewController>(contain vc: T.Type) -> (Bool, Int) {
        if let vcs = navigationController?.viewControllers {
            for (index,vc) in vcs.enumerated() {
                if vc is T {
                    return (true, index)
                }
            }
        }
        return (false,-1)
    }
   
}

// MARK:-   Networkavalable
// ***************************************************************

func isNetworkReachable() -> Bool {
    return NetworkReachabilityManager(host: "www.apple.com")?.isReachable ?? false
}

// MARK:-
// MARK:- UIPageViewController
extension UIPageViewController {
    
    func addPageControllerInto(_ vc: UIViewController, containerView: UIView) {
        
        dataSource = vc as? UIPageViewControllerDataSource
        delegate = vc as? UIPageViewControllerDelegate
        
        vc.addChild(self)
        self.didMove(toParent: vc)
        
        containerView.addSubview(self.view)
        self.view.addSurroundConstraintIn(containerView)
    }
    
}


// MARK:-
// MARK:-  UIView

enum VerticalLocation: String {
    case bottom
    case top
}

extension UIView {
    func addShadow(location: VerticalLocation, color: UIColor = AppColor.Black, opacity: Float = 0.5, radius: CGFloat = 0.4) {
        switch location {
        case .bottom:
             addShadow(offset: CGSize(width: 0, height: 10), color: color, opacity: opacity, radius: radius)
        case .top:
            addShadow(offset: CGSize(width: 0, height: 0), color: color, opacity: opacity, radius: radius)
        }
    }

    func addShadow(offset: CGSize, color: UIColor = .black, opacity: Float = 0.1, radius: CGFloat = 0.1) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = offset
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    func dropShadow(color: UIColor, opacity: Float = 0.5, offSet: CGSize, radius: CGFloat = 1, scale: Bool = true) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius

        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = scale ? UIScreen.main.scale : 1
      }
    
    
}

//MARK:- UISwitch
extension UISwitch {

    func set(width: CGFloat, height: CGFloat) {

        let standardHeight: CGFloat = 31
        let standardWidth: CGFloat = 51

        let heightRatio = height / standardHeight
        let widthRatio = width / standardWidth

        transform = CGAffineTransform(scaleX: widthRatio, y: heightRatio)
    }
}

extension UIView {
    
    /// Set the view layer as an hexagon
    func setupHexagonView(rotationOffset: CGFloat = CGFloat(.pi / 2.0)) {
        let lineWidth: CGFloat = 0
        let path = self.roundedPolygonPath(rect: self.bounds, lineWidth: lineWidth, sides: 6, cornerRadius: 2, rotationOffset: rotationOffset)
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        mask.lineWidth = lineWidth
        mask.strokeColor = UIColor.clear.cgColor
        mask.fillColor = UIColor.white.cgColor
        self.layer.mask = mask
        
        let border = CAShapeLayer()
        border.path = path.cgPath
        border.lineWidth = lineWidth
        border.strokeColor = UIColor.white.cgColor
        border.fillColor = UIColor.clear.cgColor
        self.layer.addSublayer(border)
    }
    
    
    func setShadowTop(color: CGColor) {
        layer.shadowColor = color
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: -4)
        layer.shadowRadius = 1.4
        layer.shadowOpacity = 0.6
    }
    
    func setShadowBottom(color: CGColor) {
        layer.shadowColor = color
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 3)
        layer.shadowRadius = 1.4
        layer.shadowOpacity = 0.6
    }
    
    func setShadowBottomOpacityLow(color: CGColor) {
        layer.shadowColor = color
        layer.masksToBounds = false
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 1
        layer.shadowOpacity = 0.1
    }
    
    
    /// Makes a bezier path which can be used for a rounded polygon
    /// layer
    ///
    /// - Parameters:
    ///   - rect: uiview rect bounds
    ///   - lineWidth: width border line
    ///   - sides: number of polygon's sides
    ///   - cornerRadius: radius for corners
    ///   - rotationOffset: offset of rotation of the view
    /// - Returns: the newly created bezier path for layer mask
    public func roundedPolygonPath(rect: CGRect, lineWidth: CGFloat, sides: NSInteger, cornerRadius: CGFloat, rotationOffset: CGFloat = 0) -> UIBezierPath {
        let path = UIBezierPath()
        let theta: CGFloat = CGFloat(2.0 * .pi) / CGFloat(sides) // How much to turn at every corner
        let width = min(rect.size.width, rect.size.height)        // Width of the square
        
        let center = CGPoint(x: rect.origin.x + width / 2.0, y: rect.origin.y + width / 2.0)
        
        // Radius of the circle that encircles the polygon
        // Notice that the radius is adjusted for the corners, that way the largest outer
        // dimension of the resulting shape is always exactly the width - linewidth
        let radius = (width - lineWidth + cornerRadius - (cos(theta) * cornerRadius)) / 2.0
        
        // Start drawing at a point, which by default is at the right hand edge
        // but can be offset
        var angle = CGFloat(rotationOffset)
        
        let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
        path.move(to: CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta)))
        
        for _ in 0..<sides {
            angle += theta
            
            let corner = CGPoint(x: center.x + (radius - cornerRadius) * cos(angle), y: center.y + (radius - cornerRadius) * sin(angle))
            let tip = CGPoint(x: center.x + radius * cos(angle), y: center.y + radius * sin(angle))
            let start = CGPoint(x: corner.x + cornerRadius * cos(angle - theta), y: corner.y + cornerRadius * sin(angle - theta))
            let end = CGPoint(x: corner.x + cornerRadius * cos(angle + theta), y: corner.y + cornerRadius * sin(angle + theta))
            
            path.addLine(to: start)
            path.addQuadCurve(to: end, controlPoint: tip)
        }
        
        path.close()
        
        // Move the path to the correct origins
        let bounds = path.bounds
        let transform = CGAffineTransform(translationX: -bounds.origin.x + rect.origin.x + lineWidth / 2.0, y: -bounds.origin.y + rect.origin.y + lineWidth / 2.0)
        path.apply(transform)
        
        return path
    }
    
    static func getView<T>(viewT: T.Type) -> T {
        
        let v = UINib(nibName: String(describing: viewT), bundle: Bundle.main).instantiate(withOwner: nil, options: nil).first as! T
        return v
    }
    
    static func viewFromNibName(_ name: String) -> UIView? {
        let views = Bundle.main.loadNibNamed(name, owner: nil, options: nil)
        return views?.first as? UIView
    }
    
    func addSurroundConstraintIn(_ containerView: UIView) {
        self.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: self, attribute: .top, relatedBy: .equal, toItem: containerView, attribute: .top, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self, attribute: .bottom, relatedBy: .equal, toItem: containerView, attribute: .bottom, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self, attribute: .right, relatedBy: .equal, toItem: containerView, attribute: .right, multiplier: 1.0, constant: 0.0).isActive = true
        NSLayoutConstraint(item: self, attribute: .left, relatedBy: .equal, toItem: containerView, attribute: .left, multiplier: 1.0, constant: 0.0).isActive = true
    }
    
    func setCornerRadius(_ radius: CGFloat) {
        self.layer.cornerRadius = radius
    }
    
    func setRound() {
        self.cornerRadius = self.frame.width/2
    }
    
  
    
    
    func setShadow(_ radius: CGFloat, _ width: CGFloat, _ height: CGFloat, _ color:UIColor, _ opacity: Float = 1.0) {
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOffset = CGSize(width: width, height: height)
        self.layer.shadowOpacity = opacity
        self.layer.shadowRadius = radius
    }
    
    
    
   
    func Set_Corner_Only(corners: UIRectCorner, radius: CGFloat) {
            let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
            let mask = CAShapeLayer()
            mask.path = path.cgPath
            layer.mask = mask
        }
    
    
    
    
    
    
    func removeBorderLayer(of borders:[BorderSide]) {
        
        func remove(_ bordersArr:[BorderSide]) {
            for border in bordersArr {
                if let lays = layer.sublayers {
                    for lay in lays {
                        print("&&&&&&")
                        print(lay.name!)
                        print(String(describing: border))
                        if lay.name == String(describing: border) {
                            lay.removeFromSuperlayer()
                        }
                    }
                }
            }
        }
        
        if borders.contains(.all) {
            let names : [BorderSide] = [.left, .right, .top, .bottom, .all]
            remove(names)
        }
        else {
            remove(borders)
        }
    }
    
    

    
    
    func applyGradient(colours: [UIColor]) -> Void {
        self.applyGradient(colours: colours, locations: nil)
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    func applyGradient1(colours: [UIColor]) -> Void {
        self.applyGradient1(colours: colours, locations: [0.2,0.5,1.0])
    }
    
    func TextGradient(colours: [UIColor]) -> Void {
        self.applyGradient1(colours: colours, locations: [0.2,0.5,1.0])
    }
    
    func applyGradient1(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.colors = colours.map { $0.cgColor }
        gradient.frame = self.bounds
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    

    
   
    
}



// MARK:-
// MARK:-  UIColor

//extension UIColor {
//    convenience init(_ hex:String, _ alpha:CGFloat = 1.0) {
//        let hex = hex.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//        let scanner            = Scanner(string: hex as String)
//
//        if (hex.hasPrefix("#")) {
//            scanner.scanLocation = 1
//        }
//
//        var color:UInt32 = 0
//        scanner.scanHexInt32(&color)
//
//        let mask = 0x000000FF
//        let r = Int(color >> 16) & mask
//        let g = Int(color >> 8) & mask
//        let b = Int(color) & mask
//
//        let red   = CGFloat(r) / 255.0
//        let green = CGFloat(g) / 255.0
//        let blue  = CGFloat(b) / 255.0
//
//        self.init(red:red, green:green, blue:blue, alpha:alpha)
//    }
//}



//MARK:-
//MARK:-   String

extension String {
    
//    func md5() -> String {
//        
////        let context = UnsafeMutablePointer<CC_MD5_CTX>.allocate(capacity: 1)
////        var digest = Array<UInt8>(repeating:0, count:Int(16))
////        CC_MD5_Init(context)
////        CC_MD5_Update(context, self , CC_LONG(self.lengthOfBytes(using: String.Encoding.utf8)))
////        CC_MD5_Final(&digest, context)
//        context.deallocate()
//        //context.deallocate(capacity: 1)
//        var hexString = ""
//        for byte in digest {
//            hexString += String(format:"%02x", byte)
//        }
//        
//        return hexString
//    }
    
//    var md5Value: String {
//        let length = Int(CC_MD5_DIGEST_LENGTH)
//        var digest = [UInt8](repeating: 0, count: length)
//
//        if let d = self.data(using: .utf8) {
//            _ = d.withUnsafeBytes { body -> String in
//                CC_MD5(body.baseAddress, CC_LONG(d.count), &digest)
//
//                return ""
//            }
//        }
//
//        return (0 ..< length).reduce("") {
//            $0 + String(format: "%02x", digest[$1])
//        }
//    }
    
    var attributed : NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    var trimed: String {
        return self.replacingOccurrences(of: " ", with: "")
    }
    
//    var isEmptyOrWhiteSpace : Bool {
//        return (self.rangeOfCharacter(from: CharacterSet.whitespacesAndNewlines.inverted)?.isEmpty ?? true)
//    }
    
    var localized : String {
        return NSLocalizedString(self, comment: self)
    }
    
    var validateEmail : Bool {
        
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: self.trimed)
    }
    
    var isValiduserName: Bool {
        let UsernameRegEx = "[0-9a-zA-Z ]+"
        let UsernameRegExs = NSPredicate(format:"SELF MATCHES %@", UsernameRegEx)
        return UsernameRegExs.evaluate(with: self)
    }
    
//    func height(withConstrainedWidth width: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: width, height: .greatestFiniteMagnitude)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return ceil(boundingBox.height)
//    }
//
//    func width(withConstrainedHeight height: CGFloat, font: UIFont) -> CGFloat {
//        let constraintRect = CGSize(width: .greatestFiniteMagnitude, height: height)
//        let boundingBox = self.boundingRect(with: constraintRect, options: .usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
//
//        return ceil(boundingBox.width)
//    }
    
//    func toDate(_ dateFormat: String) -> Date? {
//        let df = DateFormatter()
//        df.dateFormat = dateFormat
//        return df.date(from: self)
//    }
//
//    func toDouble() -> Double? {
//        return NumberFormatter().number(from: self)?.doubleValue
//    }
    
    func notificationName() -> Notification.Name {
        return Notification.Name(self)
    }
    
    func base64Encoded() -> String? {
        return data(using: .utf8)?.base64EncodedString()
    }
    
    func base64Decoded() -> String? {
        guard let data = Data(base64Encoded: self) else { return nil }
        return String(data: data, encoding: .utf8)
    }
    
//    public func getDateWithFormate(formate: String, timezone: String) -> Date {
//        let formatter = DateFormatter()
//        formatter.dateFormat = formate
//        formatter.timeZone = TimeZone(abbreviation: timezone)
//        return formatter.date(from: self)! as Date
//    }
}


extension NSAttributedString {
    
    static func + (left: NSAttributedString, right: NSAttributedString) -> NSAttributedString
    {
        let result = NSMutableAttributedString()
        result.append(left)
        result.append(right)
        return result
    }
}


//MARK:-
//MARK:-   Dateformatter

extension DateFormatter {
    
    func getMMMDateStringFrom(_ date: Date) -> String {
        
        let df = DateFormatter()
        df.dateFormat = "dd-MMM-yyyy"
        return df.string(from: date)
    }
    
    class func getTime(_ forDate: NSDate) -> String {
        
        let dformatter = DateFormatter()
        dformatter.dateFormat = "h:mm a"
        return dformatter.string(from: forDate as Date)
    }
    
    class func getDate(_ forDate: String) -> Date {
        
        let dformatter = DateFormatter()
        dformatter.dateStyle = .medium
        return dformatter.date(from: forDate)!
    }
    
    class func relativeTo(_ date: Date) -> String {
        
        let dformatter = DateFormatter()
        dformatter.dateStyle = .medium
        dformatter.doesRelativeDateFormatting = true
        return dformatter.string(from: date)
    }
}

//MARK:-
//MARK:-   Date
extension Date {
    
    func time() -> String {
        let df = DateFormatter()
        df.dateFormat = "h:mm a"
        return df.string(from: self)
    }
    
    func showDate() -> String {
        let df = DateFormatter()
        df.dateFormat = "M/d/yyyy"
        return df.string(from: self)
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
    
    public func getDateStringWithFormate(_ formate: String, timezone: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = formate
        formatter.timeZone = TimeZone(abbreviation: timezone)
        return formatter.string(from: self)
    }
}


//MARK:-
//MARK:-    UIResponder
extension UIResponder {
    
    func firstAvailableViewController() -> UIViewController? {
        return self.traverseResponderChainForFirstViewController()
    }
    
    func firstAvailableTableView() -> UITableView? {
        return self.traverseResponderChainForFirstTableView()
    }
    
    func traverseResponderChainForFirstViewController() -> UIViewController? {
        if let nextResponder = self.next {
            if nextResponder is UIViewController {
                return nextResponder as? UIViewController
            } else if nextResponder is UIView {
                return nextResponder.traverseResponderChainForFirstViewController()
            } else {
                return nil
            }
        }
        return nil
    }
    
    func traverseResponderChainForFirstTableView() -> UITableView? {
        if let nextResponder = self.next {
            if nextResponder is UITableView {
                return nextResponder as? UITableView
            } else if nextResponder is UIView {
                return nextResponder.traverseResponderChainForFirstTableView()
            } else {
                return nil
            }
        }
        return nil
    }
}


// MARK:-
// MARK:-  UITableView
extension UITableView {
    

    
    func scrollToBottom(animate: Bool) {
        DispatchQueue.main.async {
            let indexPath = IndexPath(
                row: self.numberOfRows(inSection:  self.numberOfSections-1) - 1,
                section: self.numberOfSections - 1)
            self.scrollToRow(at: indexPath, at: .bottom, animated: animate)
        }
    }
    
    func scrollToTop() {
        
        DispatchQueue.main.async {
            let indexPath = IndexPath(row: 0, section: 0)
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
    
    var setContentInset : (CGFloat?,CGFloat?,CGFloat?,CGFloat?) {
        set {
            let inset = contentInset
            contentInset = UIEdgeInsets(top: newValue.0 ?? inset.top, left: newValue.1 ?? inset.left, bottom: newValue.2 ?? inset.bottom, right: newValue.3 ?? inset.right)
        }
        get {
            return (contentInset.top, contentInset.left, contentInset.bottom, contentInset.right)
        }
    }
    
    func dequeCell<T>(_ cell: T.Type, indexPath: IndexPath? = nil) -> T {
        if let indexPath = indexPath {
            let cell1 = dequeueReusableCell(withIdentifier: String(describing: cell), for: indexPath) as! T
            return cell1
        } else {
            let cell1 = dequeueReusableCell(withIdentifier: String(describing: cell)) as! T
            return cell1
        }
    }
}

// MARK:-
// MARK:-  UITableView
extension UICollectionView {
    
    func dequeCell<T>(_ cell: T.Type, indexPath: IndexPath) -> T {
        let cell1 = dequeueReusableCell(withReuseIdentifier: String(describing: cell), for: indexPath) as! T
        return cell1
    }
    
}


//MARK:-
//MARK:-   UITextField
enum Side {
    case Left
    case Right
}

public enum BorderSide {
    case top
    case bottom
    case left
    case right
    case all
}


//MARK:-
//MARK:-   UITextView

extension UITextView : NSTextStorageDelegate{
    
    private class PlaceholderLabel: UILabel { }
    
    private var placeholderLabel: PlaceholderLabel {
        if let label = subviews.compactMap( { $0 as? PlaceholderLabel }).first {
            return label
        } else {
            let label = PlaceholderLabel(frame: .zero)
            label.font = font
            addSubview(label)
            return label
        }
    }
    
    @IBInspectable
    var extPlaceholder: String {
        get {
            return subviews.compactMap( { $0 as? PlaceholderLabel }).first?.text ?? ""
        }
        set {
            let placeholderLabel = self.placeholderLabel
            placeholderLabel.text = newValue
            placeholderLabel.textColor = UIColor(red: 0, green: 0, blue: 0.0980392, alpha: 0.22)
            placeholderLabel.numberOfLines = 0
            let width = frame.width - textContainer.lineFragmentPadding * 2
            let size = placeholderLabel.sizeThatFits(CGSize(width: width, height: .greatestFiniteMagnitude))
            placeholderLabel.frame.size.height = size.height + 4
            placeholderLabel.frame.size.width = width
            placeholderLabel.frame.origin = CGPoint(x: textContainer.lineFragmentPadding, y: textContainerInset.top)
            
            textStorage.delegate = self
            
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
    public func textStorage(_ textStorage: NSTextStorage, didProcessEditing editedMask: NSTextStorage.EditActions, range editedRange: NSRange, changeInLength delta: Int) {
        if editedMask.contains(.editedCharacters) {
            placeholderLabel.isHidden = !text.isEmpty
        }
    }
    
}

//MARK:-
//MARK:-   UITextField

extension UITextField {
    
    func setBlankView(_ width: CGFloat, _ side: Side = .Left) {
        
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: width, height: width))
        
        if side == .Left {
            self.leftView = paddingView
            self.leftViewMode = .always
        }
        else if side == .Right {
            self.rightView = paddingView
            self.rightViewMode = .always
        }
    }
    

    @objc func tapOnImgView(_ recognizer: UITapGestureRecognizer) {
        self.becomeFirstResponder()
    }
    
    public func setRightSemantic() {
        self.semanticContentAttribute = .forceRightToLeft
        self.textAlignment = .right
    }
    
    func setLeftSemantic() {
        self.semanticContentAttribute = .forceLeftToRight
        self.textAlignment = .left
    }
    
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


//MARK:-
//MARK:-   UILable
extension UILabel {
    
//    var getLableHeight: CGFloat {
//        let height = text!.height(withConstrainedWidth: Getwidth, font: font)
//        return height
//    }
    
    func applyLineSpace(_ space: CGFloat) {
        
        let attribStr = NSMutableAttributedString(attributedString: self.attributedText!)
        let paragStyle = NSMutableParagraphStyle()
        paragStyle.lineSpacing = space
        paragStyle.alignment = self.textAlignment
        attribStr.addAttributes([NSAttributedString.Key.paragraphStyle: paragStyle], range: NSMakeRange(0, attribStr.length))
        self.attributedText = attribStr
    }
    
    func textBGColor(_ fullText : String , changeText : String ) {
        
        let strNumber: NSString = fullText as NSString
        
        let paragStyle = NSMutableParagraphStyle()
        paragStyle.lineSpacing = 4
        paragStyle.alignment = self.textAlignment
        
        let attribute = NSMutableAttributedString(string: fullText, attributes: [.backgroundColor: UIColor.clear, .paragraphStyle: paragStyle])
        
        if changeText.count > 0 {
            let strarr = changeText.components(separatedBy: CharacterSet.whitespacesAndNewlines)
            strarr.forEach { (str) in
                let range = (strNumber).range(of: str, options: .caseInsensitive)
                attribute.addAttribute(NSAttributedString.Key.backgroundColor, value: UIColor.yellow, range: range)
            }
        }
        self.attributedText = attribute
    }
}

// MARK:-
// MARK:-  Decimal Float Velue Set In lbl
extension Float {
    var clean: String {
       return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
    }
}

// MARK:-
// MARK:-  Circle View
class CircleView : UIView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setRound()
    }
}


class CircleImageView : UIImageView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setRound()
    }
}

class CircleButton : UIButton {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setRound()
    }
}

func showMessageAlert(title: String, andMessage message: String, withOkButtonTitle okButtonTitle: String) {
    let alertWindow: UIWindow = UIWindow(frame: UIScreen.main.bounds)
    alertWindow.rootViewController = UIViewController()
    alertWindow.windowLevel = UIWindow.Level.alert + 1
    alertWindow.makeKeyAndVisible()
    
    let alertController: UIAlertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
    alertController.addAction(UIAlertAction(title: okButtonTitle, style: .default, handler: { (action) -> Void in
        
        alertWindow.isHidden = true
        
    }))
    
    alertWindow.rootViewController?.present(alertController, animated: true, completion: nil)
}

func DLog(_ items: Any?..., function: String = #function, file: String = #file, line: Int = #line) {
    DispatchQueue.main.async {
        if isDevelopmentMode {
            print("-----------START-------------")
            let url = NSURL(fileURLWithPath: file)
            print("Message = ", items, "\n\n(File: ", url.lastPathComponent ?? "nil", ", Function: ", function, ", Line: ", line, ")")
            print("-----------END-------------\n")
        }
    }
}

extension UIImage {
    
    func tint(with color: UIColor) -> UIImage {
        var image = withRenderingMode(.alwaysTemplate)
        UIGraphicsBeginImageContextWithOptions(size, false, scale)
        color.set()
        
        image.draw(in: CGRect(origin: .zero, size: size))
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
}

extension CGFloat {
    
    var dp: CGFloat {
        return (self / 320) * UIScreen.main.bounds.width
    }
}

extension UITapGestureRecognizer {
    
    func didTapAttributedTextInLabel(label: UILabel, inRange targetRange: NSRange) -> Bool {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let str = label.attributedText!
        let attr = NSMutableAttributedString(attributedString: str)
        attr.addAttributes([NSAttributedString.Key.font: label.font!], range: NSRange(location: 0, length: str.length))
        
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: attr)
        
        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines
        let labelSize = label.frame.size
        textContainer.size = CGSize(width: labelSize.width, height: CGFloat.greatestFiniteMagnitude)
        
        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)
        
        let locationOfTouchInLabel = self.location(in: label)
        
        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInLabel, in: textContainer, fractionOfDistanceBetweenInsertionPoints: nil)
        
        return NSLocationInRange(indexOfCharacter, targetRange)
    }
    
    
}
extension Optional where Wrapped: UIImage {
    
    func isEqualToImage(_ image: UIImage?) -> Bool {
        
        if self == nil {
            return false
        }
        if image == nil {
            return false
        }
        
        if #available(iOS 13.0, *) {
            if let selfData = self!.jpegData(compressionQuality: 1.0), let otherData = image!.jpegData(compressionQuality: 1.0) {
                return selfData == otherData
            } else {
                return false
            }
        } else {
            return self! == image!
        }
    }
}

extension Array where Element: Equatable {
    // Remove first collection element that is equal to the given `object`:
    mutating func remove(object: Element) {
        guard let index = firstIndex(of: object) else {return}
        remove(at: index)
    }
}

//MARK:- Last Decimal Value
extension Double {
    func roundToDecimal(_ fractionDigits: Int) -> Double {
        let multiplier = pow(10, Double(fractionDigits))
        return Darwin.round(self * multiplier) / multiplier
    }
}

@IBDesignable
final class GradientView: UIView {
    @IBInspectable var startColor: UIColor = UIColor.clear
    @IBInspectable var endColor: UIColor = UIColor.clear

    override func draw(_ rect: CGRect) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = CGRect(x: CGFloat(0),
                                y: CGFloat(0),
                                width: superview!.frame.size.width,
                                height: superview!.frame.size.height)
        gradient.colors = [startColor.cgColor, endColor.cgColor]
        gradient.zPosition = -1
        layer.addSublayer(gradient)
    }
}

//@IBDesignable
class GradientSlider: UISlider {

    @IBInspectable var thickness: CGFloat = 20 {
        didSet {
//            setup()
        }
    }

    @IBInspectable var sliderThumbImage: UIImage? {
        didSet {
//            setup()
        }
    }

//    func setup() {
//        let minTrackStartColor = AppColor.AppButtonGradiantStart
//        let minTrackEndColor = AppColor.AppButtonGradiantEnd
//        let maxTrackColor = AppColor.AppSliderNoFill
//        do {
//            self.setMinimumTrackImage(try self.gradientImage(
//            size: self.trackRect(forBounds: self.bounds).size,
//            colorSet: [minTrackStartColor.cgColor, minTrackEndColor.cgColor]),
//                                  for: .normal)
//            self.setMaximumTrackImage(try self.gradientImage(
//            size: self.trackRect(forBounds: self.bounds).size,
//            colorSet: [maxTrackColor.cgColor, maxTrackColor.cgColor]),
//                                  for: .normal)
//            self.setThumbImage(sliderThumbImage, for: .normal)
//        } catch {
//            self.minimumTrackTintColor = minTrackStartColor
//            self.maximumTrackTintColor = maxTrackColor
//        }
//    }

    func gradientImage(size: CGSize, colorSet: [CGColor]) throws -> UIImage? {
        let tgl = CAGradientLayer()
        tgl.frame = CGRect.init(x:0, y:0, width:size.width, height: size.height)
        tgl.cornerRadius = tgl.frame.height / 2
        tgl.masksToBounds = false
        tgl.colors = colorSet
        tgl.startPoint = CGPoint.init(x:0.0, y:0.5)
        tgl.endPoint = CGPoint.init(x:1.0, y:0.5)

        UIGraphicsBeginImageContextWithOptions(size, tgl.isOpaque, 0.0);
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        tgl.render(in: context)
        let image =

    UIGraphicsGetImageFromCurrentImageContext()?.resizableImage(withCapInsets:
        UIEdgeInsets.init(top: 0, left: size.height, bottom: 0, right: size.height))
        UIGraphicsEndImageContext()
        return image!
    }

    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(
            x: bounds.origin.x,
            y: bounds.origin.y,
            width: bounds.width,
            height: thickness
        )
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
//        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        setup()
    }


}

extension CGFloat {
    var isEven: Bool {
        return truncatingRemainder(dividingBy: 2.0) == 0
    }
}

#if canImport(AppKit) && !targetEnvironment(macCatalyst)
import AppKit
extension NSBezierPath {
    convenience init(roundedRect rect: NSRect, topLeftRadius: CGFloat, topRightRadius: CGFloat,
                     bottomLeftRadius: CGFloat, bottomRightRadius: CGFloat)
    {
        self.init()
        
        let maxCorner = min(rect.width, rect.height) / 2
        
        let radiusTopLeft = min(maxCorner, max(0, topLeftRadius))
        let radiusTopRight = min(maxCorner, max(0, topRightRadius))
        let radiusBottomLeft = min(maxCorner, max(0, bottomLeftRadius))
        let radiusBottomRight = min(maxCorner, max(0, bottomRightRadius))
        
        guard !rect.isEmpty else {
            return
        }
        
        let topLeft = NSPoint(x: rect.minX, y: rect.maxY)
        let topRight = NSPoint(x: rect.maxX, y: rect.maxY)
        let bottomRight = NSPoint(x: rect.maxX, y: rect.minY)
        
        move(to: NSPoint(x: rect.midX, y: rect.maxY))
        appendArc(from: topLeft, to: rect.origin, radius: radiusTopLeft)
        appendArc(from: rect.origin, to: bottomRight, radius: radiusBottomLeft)
        appendArc(from: bottomRight, to: topRight, radius: radiusBottomRight)
        appendArc(from: topRight, to: topLeft, radius: radiusTopRight)
        close()
    }
    
    convenience init(roundedRect rect: NSRect, byRoundingCorners corners: RectCorner, radius: CGFloat) {
        let radiusTopLeft = corners.contains(.topLeft) ? radius : 0
        let radiusTopRight = corners.contains(.topRight) ? radius : 0
        let radiusBottomLeft = corners.contains(.bottomLeft) ? radius : 0
        let radiusBottomRight = corners.contains(.bottomRight) ? radius : 0
        
        self.init(roundedRect: rect, topLeftRadius: radiusTopLeft, topRightRadius: radiusTopRight,
                  bottomLeftRadius: radiusBottomLeft, bottomRightRadius: radiusBottomRight)
    }
}

extension KFCrossPlatformImage {
    // macOS does not support scale. This is just for code compatibility across platforms.
    convenience init?(data: Data, scale: CGFloat) {
        self.init(data: data)
    }
}
#endif

extension Date {
    var isPast: Bool {
        return isPast(referenceDate: Date())
    }

    func isPast(referenceDate: Date) -> Bool {
        return timeIntervalSince(referenceDate) <= 0
    }

    // `Date` in memory is a wrap for `TimeInterval`. But in file attribute it can only accept `Int` number.
    // By default the system will `round` it. But it is not friendly for testing purpose.
    // So we always `ceil` the value when used for file attributes.
    var fileAttributeDate: Date {
        return Date(timeIntervalSince1970: ceil(timeIntervalSince1970))
    }
}
