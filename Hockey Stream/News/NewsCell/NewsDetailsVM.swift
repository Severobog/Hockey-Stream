//
//  NewsVM.swift
//  BetweenSports
//
//  Created by Shailesh on 25/07/22.
//

import Foundation

class NewsDetailsVM {
    lazy var apiClient = APIClient()
    var newsBody = ""
    
    func newsDetailsApi(id: String, completion: @escaping (_ success: Bool) -> Void) {
        
       let url = "https://api.theathletic.com/v5cached/articles/\(id)"
        
        _ = apiClient.getNewsDetails(url: url, completionBlock: { (response, error)  in
            
            if error != nil {
                completion(false)
            }
            
            guard let response = response else {
                completion(false)
                return
            }
            
            if let data = response["truncated_article_body"] as? String {
                let a = data.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
                self.newsBody = a.replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil)
            }
            if let data1 = response["article_body"] as? String {
                let a = data1.replacingOccurrences(of: "<[^>]+>", with: "", options: String.CompareOptions.regularExpression, range: nil)
                self.newsBody = "\(self.newsBody)\n\(a.replacingOccurrences(of: "&[^;]+;", with: "", options: .regularExpression, range: nil))"
            }
            completion(true)
            
        })
    }
}
