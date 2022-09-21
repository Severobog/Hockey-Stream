//
//  FileParameterRequest.swift
//  Receipt Manager
//
//  Created by MAC on 17/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation

class FileParameterRequest {
    var parameters = [String: Any]()
    
    static let fileData = "file_data"
    static let paramName = "param_name"
    static let fileName = "file_name"
    static let mimeType = "mime_type"
    
    init() {}
    
    func addParameter(key: String, value: Any?) {
        parameters[key] = value
    }
}
