//
//  APIManager.swift
//  Receipt Manager
//
//  Created by MAC on 17/03/20.
//  Copyright © 2020 MAC. All rights reserved.
//

import Foundation
import Alamofire
import SVProgressHUD

class APIManager {
    
    private static let NetworkError = networkError
    
    public static let apiSessionManager: Session = {
        let configuration = URLSessionConfiguration.default
        configuration.requestCachePolicy = .reloadIgnoringLocalCacheData
        configuration.urlCache = nil
        configuration.timeoutIntervalForRequest = 300
        configuration.timeoutIntervalForResource = 300
        
        return Session(configuration: configuration)
    }()
    
    class func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
        return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
    }
    
    class func callAPI(url: String, method: Alamofire.HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil, parameterEncoding: ParameterEncoding = URLEncoding.default, isShowHud: Bool = true, success successBlock: @escaping ((Any?, Int?) -> Void), failure failureBlock: ((Error, Int?) -> Bool)?) -> DataRequest {
        
        DLog("parameters = ", parameters ?? [String : Any]())
        DLog("apiURL = ", url)
        
        var newHeaders = HTTPHeaders()
        if let header = headers {
            for h in header {
                newHeaders.add(name: h.key, value: h.value)
            }
        }
        
        if !isNetworkReachable() {
            showMessageAlert(title: AppName, andMessage: "No internet connection, please check you mobile data", withOkButtonTitle: "Ok")
            successBlock(nil, 0)
        }
        
        if isShowHud {
            IndicatorManager.showLoader()
        }
        
        return apiSessionManager.request(url, method: method, parameters: parameters, encoding: parameterEncoding, headers: newHeaders)
            .responseString { response in
                DLog("Response String: \(String(describing: response.value))")
            }
            .responseJSON { response in
                DLog("Response Error: ", response.error)
                DLog("Response JSON: ", response.value)
                DLog("response.request: ", response.request?.allHTTPHeaderFields)
                DLog("Response Status Code: ", response.response?.statusCode)
                
                DispatchQueue.main.async {
                    if response.error == nil {
                        let responseObject = response.value
                        
                        
                        successBlock(responseObject, response.response?.statusCode)
                        
                    } else {
                        if failureBlock != nil && failureBlock!(response.error! as NSError, response.response?.statusCode) {
                            if let statusCode = response.response?.statusCode {
                                APIManager.handleAlamofireHttpFailureError(statusCode: statusCode)
                            }
                        }
                    }
                    
                    if isShowHud {
                        IndicatorManager.hideLoader()
                    }
                }
            }
    }
    
    class func callAPIWithUpload(url: String, method: Alamofire.HTTPMethod, parameters: [String: Any]? = nil, headers: [String: String]? = nil, fileParameters: [FileParameterRequest]? = nil, isShowHud: Bool = true, success successBlock: @escaping ((Any?, Int?) -> Void), failure failureBlock: ((Error, Int?) -> Bool)?) {
        
        var finalParameters = [String: Any]()
        if parameters != nil {
            finalParameters = parameters!
        }
        
        DLog("parameters = ", finalParameters)
        DLog("apiURL = ", url)
        
        if !isNetworkReachable() {
            showMessageAlert(title: "Error", andMessage: NetworkError, withOkButtonTitle: "OK")
            successBlock(nil, 0)
        }
        
        if isShowHud {
            IndicatorManager.showLoader()
        }
        
        var newHeaders = HTTPHeaders()
        if let header = headers {
            for h in header {
                newHeaders.add(name: h.key, value: h.value)
            }
        }
        
        apiSessionManager.upload(multipartFormData: { multipartFormData in
            multipartFormData.append("".data(using: String.Encoding.utf8)!, withName: "")
            
            for (key, value) in finalParameters {
                multipartFormData.append(String(describing: value).data(using: .utf8)!, withName: key)
            }
            
            if fileParameters != nil && fileParameters!.count > 0 {
                for i in 0...(fileParameters!.count - 1) {
                    let dict = fileParameters![i].parameters
                    if !dict.isEmpty {
                        print(dict)
                        multipartFormData.append(dict["file_data"] as! Data, withName: dict["param_name"] as! String, fileName: dict["file_name"] as? String, mimeType: dict["mime_type"] as? String)
                    }
                }
            }
            
        }, to: url, method: method , headers: newHeaders)
        .responseString { response in
            DLog("Response String: \(String(describing: response.value))")
        }
        .responseJSON { response in
            DLog("Response Error: ", response.error)
            DLog("Response JSON: ", response.value)
            DLog("response.request: ", response.request?.allHTTPHeaderFields)
            DLog("Response Status Code: ", response.response?.statusCode)
            
            DispatchQueue.main.async {
                if response.error == nil {
                    let responseObject = response.value
                    successBlock(responseObject, response.response?.statusCode)
                    
                } else {
                    if failureBlock != nil && failureBlock!(response.error! as NSError, response.response?.statusCode) {
                        if let statusCode = response.response?.statusCode {
//                            APIManager.handleAlamofireHttpFailureError(statusCode: statusCode)
                        }
                    }
                }
                
                if isShowHud {
                    IndicatorManager.hideLoader()
                }
            }
        }
    }
    
    class func handleAlamofireHttpFailureError(statusCode: Int) {
        switch statusCode {
        case NSURLErrorNotConnectedToInternet:
            showMessageAlert(title: "Error", andMessage: "The request timed out, please verify your internet connection and try again", withOkButtonTitle: "OK")
        case NSURLErrorCannotFindHost:
            showMessageAlert(title: "Error", andMessage: "An unexpected network error occurred, please try again!", withOkButtonTitle: "OK")
        case NSURLErrorCannotParseResponse:
            showMessageAlert(title: "Error", andMessage: "An unexpected network error occurred, please try again later!", withOkButtonTitle: "OK")
        case NSURLErrorUnknown:
            showMessageAlert(title: "Error", andMessage: "Oops!! Something went wrong, please try after some time!", withOkButtonTitle: "OK")
        case NSURLErrorCancelled:
            break
        case NSURLErrorTimedOut:
            showMessageAlert(title: "Error", andMessage: "The request timed out, please verify your internet connection and try again", withOkButtonTitle: "OK")
        case NSURLErrorNetworkConnectionLost:
            showMessageAlert(title: "Internet", andMessage: NetworkError, withOkButtonTitle: "OK")
        default:
            showMessageAlert(title: "Error", andMessage: "An unexpected network error occurred", withOkButtonTitle: "OK")
        }
    }
    
    class func isNetworkReachable() -> Bool {
        return NetworkReachabilityManager(host: "www.apple.com")?.isReachable ?? false
    }
}
