//
//  BookAPIRequest.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/21/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

struct BooksAPIRequest {
    
    static func serverRequest(with serverURL: String, completion: @escaping (([[String: Any]]) -> Void)) {
        let session = URLSession.shared
        let url = URL(string: serverURL)
        guard let unwrappedURL = url else {return}
        
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            if error != nil {
                guard let error = error?.localizedDescription else { return }
                print(error)
            }
            
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                if let unwrappedData = data {
                    do {
                        let responseJSON = try JSONSerialization.jsonObject(with: unwrappedData, options: []) as! [[String: Any]]
                        
                        completion(responseJSON)
                        
                    } catch {}
                }
            } else { print(httpResponse.statusCode)}
        }
        task.resume()
    }
}
