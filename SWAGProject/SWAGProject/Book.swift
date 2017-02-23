//
//  Book.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/21/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

class Book {
    var author: String
    var categories: String
    var id: Int
    var title: String
    var url: String
    var lastCheckedOut: String?
    var lastCheckedOutBy: String?
    var publisher: String?
    
    init?(dict: [String: Any]) {
        guard
            let author = dict["author"] as? String,
            let categories = dict["categories"] as? String,
            let id = dict["id"] as? Int,
            let title = dict["title"] as? String,
            let url = dict["url"] as? String
            else { print("Error parsing JSON to Book"); return nil }
        
        let lastCheckedOut = dict["lastCheckedOut"] as? String ?? ""
        let lastCheckedOutBy = dict["lastCheckedOutBy"] as? String ?? ""
        let publisher = dict["publisher"] as? String ?? ""
        
        self.author = author
        self.categories = categories
        self.id = id
        self.title = title
        self.url = url
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
    }
    
    init(author: String, categories: String, id: Int, title: String, url: String, lastCheckedOut: String?, lastCheckedOutBy: String?, publisher: String?) {
        self.author = author
        self.categories = categories
        self.id = id
        self.title = title
        self.url = url
        self.lastCheckedOut = lastCheckedOut
        self.lastCheckedOutBy = lastCheckedOutBy
        self.publisher = publisher
    }
}
