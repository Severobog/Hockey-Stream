//
//  NewsModel.swift
//  Sports-Factor
//
//  Created by Демид Стариков on 02.09.2022.
//

import Foundation

class NewsDataModel {
    var feed: Feed?
    
    init(data: [String: Any]) {
        self.feed = Feed(data: data["feed"] as? [String: Any] ?? [String:Any]())
    }
    
}

class Feed {
    var layouts  = [Layout]()
    init(data: [String: Any]) {
        self.layouts = Layout.getArray(arr: data["layouts"] as? [[String: Any]] ?? [[String: Any]]())
        
    }
    
  
}


class Layout {
    var contents  = [Contents]()
    init(data: [String: Any]) {
        self.contents = Contents.getArray(arr: data["contents"] as? [[String: Any]] ?? [[String: Any]]())
        
    }
    
    class func getArray(arr: [[String: Any]]) -> [Layout] {
        var temp = [Layout]()
        for obj in arr {
            temp.append(Layout(data: obj))
        }
        return temp
    }
}

class Contents {
   
    var consumable: Consumable?
    var author : Author?
    init(data: [String: Any]) {
     
        self.consumable = Consumable(data: data["consumable"] as? [String: Any] ?? [String: Any]())
        self.author = Author(data: data["author"] as? [String: Any] ?? [String: Any]())
    }
    
    class func getArray(arr: [[String: Any]]) -> [Contents] {
        var temp = [Contents]()
        for obj in arr {
            temp.append(Contents(data: obj))
        }
        return temp
    }
}

class Consumable {
    var id  = ""
    var title  = ""
    var image_uri  = ""
    var permalink = ""
    var excerpt  = ""
    var author: Author?
   
    init(data: [String: Any]) {
        self.id = data["id"] as? String ?? ""
        self.title = data["title"] as? String ?? ""
        self.image_uri = data["image_uri"] as? String ?? ""
        self.excerpt = data["excerpt"] as? String ?? ""
        self.permalink = data["permalink"] as? String ?? ""
        self.author = Author(data: data["Author"] as? [String: Any] ?? [String: Any]())
    }
}

class Author {
    var description = ""
    var bio = ""
    
    init(data: [String: Any]) {
        self.description = data["description"] as? String ?? ""
        self.bio = data["bio"] as? String ?? ""
    }
}
