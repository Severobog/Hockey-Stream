//
//  ResponseData.swift
//  Receipt Manager
//
//  Created by MAC on 17/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

struct ResponseData {
    let responseCode: Int
    let responseMessage: String
    
    init(data: [String : Any]) {
        responseCode = data["ResponseCode"] as? Int ?? 0
        responseMessage = data["ResponseMsg"] as? String ?? ""
    }
}

struct ResponseStatus {
    static let fail = 0
    static let success = 1
    static let ConfirmationLink = 2
    static let SocialSignup = 3
    static let ForcefullyUpdate = 10
}
