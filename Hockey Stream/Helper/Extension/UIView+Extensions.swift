//
//  UIView+Extensions.swift
//  Ping
//
//  Created by MAC on 03/06/21.
//

import UIKit

extension UIView {
//    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
//    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            let color = UIColor(cgColor: layer.borderColor!)
            return color
        }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    
//    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
    }
    
//    @IBInspectable
    var shadowColor: UIColor? {
        get {
            return UIColor(cgColor: layer.shadowColor!)
        }
        set {
            layer.shadowColor = newValue!.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 2)
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
    }
    
//    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = newValue
            layer.shadowOpacity = shadowOpacity
            layer.shadowRadius = shadowRadius
        }
    }
    
//    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowColor = shadowColor?.cgColor
            layer.shadowOffset = shadowOffset
            layer.shadowOpacity = newValue
            layer.shadowRadius = shadowRadius
        }
    }
    
//    @IBInspectable
    var enableMaskBound: Bool {
        get {
            return layer.masksToBounds
        }
        set {
            layer.masksToBounds = newValue
        }
    }
}
