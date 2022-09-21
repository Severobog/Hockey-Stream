//
//  APIClient.swift
//  Receipt Manager
//
//  Created by MAC on 17/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Alamofire
import Foundation

class APIClient {
    
    private func callAPI(url: String, method: Alamofire.HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil, parameterEncoding: ParameterEncoding = URLEncoding.default, isShowHud: Bool = true, completion completionBlock: @escaping ([String: Any]?, Error?) -> Void) -> DataRequest {
        
        let headers = HeaderRequestParameter()
        headers.addParameter(key: "Package", value: HeaderKey)
        return APIManager.callAPI(url: url, method: method, parameters: parameters, headers: headers.parameters, parameterEncoding: parameterEncoding, isShowHud: isShowHud, success: { response, _ in
            
            DispatchQueue.main.async {
                let responseObj = response as? [String: Any]
                completionBlock(responseObj, nil)
            }
        },
        failure: { (error, status) -> Bool in
            
            DispatchQueue.main.async {
                completionBlock(nil, error)
            }
            return true
        })
    }
    
    private func callAPIWithBarear(url: String, method: Alamofire.HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil, parameterEncoding: ParameterEncoding = URLEncoding.default, isShowHud: Bool = true, completion completionBlock: @escaping ([String: Any]?, Error?) -> Void) -> DataRequest {
        
        let headers = HeaderRequestParameter()
        headers.addParameter(key: "Authorization", value: BearerKey)
        return APIManager.callAPI(url: url, method: method, parameters: parameters, headers: headers.parameters, parameterEncoding: parameterEncoding, isShowHud: isShowHud, success: { response, _ in
            
            DispatchQueue.main.async {
                let responseObj = response as? [String: Any]
                completionBlock(responseObj, nil)
            }
        },
        failure: { (error, status) -> Bool in
            
            DispatchQueue.main.async {
                completionBlock(nil, error)
            }
            return true
        })
    }
    
    private func CallAPIWithUpload(url: String, method: Alamofire.HTTPMethod, parameters: [String: Any]? = nil, fileParameters: [FileParameterRequest]?, headers: [String: String]? = nil, isShowHud: Bool = true, completion completionBlock: @escaping ([String : Any]?, Error?) -> Void) {
        
        let headers = HeaderRequestParameter()
        APIManager.callAPIWithUpload(url: url, method: method, parameters: parameters, headers: headers.parameters, fileParameters: fileParameters, isShowHud: isShowHud, success: { (response, _) in
            
            DispatchQueue.main.async {
                let responseObj = response as? [String: Any]
                completionBlock(responseObj, nil)
            }
        }) { (error, status) -> Bool in
            
            DispatchQueue.main.async {
                completionBlock(nil, error)
            }
            return true
        }
    }
    
    // MARK: -
    
    func getMatchData(url: String, completionBlock: @escaping ([String : Any]?, Error?) -> Void) -> DataRequest {
        return callAPI(url: url, method: .get, headers: nil, completion: completionBlock)
    }
    
    func getNewsDetails(url: String, completionBlock: @escaping ([String : Any]?, Error?) -> Void) -> DataRequest {
        return callAPIWithBarear(url: url, method: .get, headers: nil, completion: completionBlock)
    }
   
}
