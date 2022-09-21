//
//  HeaderRequest.swift
//  
//
//  Created by MAC on 28/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

class HeaderRequestParameter {
    var parameters = [String : String]()
    
    static let Token = "token"
    static let Key = "key"
    
    init() {}

    func addParameter(key: String, value: String) {
        parameters[key] = value
    }
}
