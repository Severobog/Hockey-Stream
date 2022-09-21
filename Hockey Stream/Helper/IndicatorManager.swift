//
//  IndicatorManager.swift
//  Food Values
//
//  Created by MAC on 08/04/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import SVProgressHUD

class IndicatorManager: NSObject {
    
    private static var loadingCount = 0
    
    class func showLoader() {
        
        if loadingCount == 0 {
            // Show loader
            DispatchQueue.main.async {
                SVProgressHUD.setDefaultMaskType(.clear)
                SVProgressHUD.show(withStatus: "Loading...")
            }
        }
        loadingCount += 1
        
    }
    
    class func hideLoader() {
        
        if loadingCount > 0 {
            loadingCount -= 1
        }
        if loadingCount == 0 {
            // Hide loader
            DispatchQueue.main.async {
                SVProgressHUD.dismiss()
            }
        }
        
    }
}

