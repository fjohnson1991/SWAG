//
//  BookAPIRequest.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/21/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

struct BookAPICalls {
    
    // GET
    static func serverRequest(with completion: @escaping (([[String: Any]]) -> Void)) {
        let session = URLSession.shared
        let url = URL(string: "https://prolific-interview.herokuapp.com/58ab049e53fba2000ab50b6e/books")
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
    
    // POST
    static func server(post author: String, categories: String?, title: String, publisher: String?, completion: @escaping () -> Void) {
        
        let requestDictionary = ["author": author, "categories": categories, "title": title, "publisher": publisher]
        print("author: \(author)")
        print("categories: \(categories)")
        print("title: \(title)")
        let jsonData = try? JSONSerialization.data(withJSONObject: requestDictionary)
        guard let url = URL(string: "https://prolific-interview.herokuapp.com/58ab049e53fba2000ab50b6e/books") else { print("Error unwrapping url in post"); return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = jsonData
        print("jsonData: \(request.httpBody?.description)")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let unwrappedData = data else { print("Error unwrapping data in post func"); return }
            print(unwrappedData.description)
            let httpResponse = response as! HTTPURLResponse
            print(httpResponse.statusCode)
            if error == nil {
                let responseJSON = try? JSONSerialization.jsonObject(with: unwrappedData, options: [])
                if let responseJSON = responseJSON as? [String: Any] {
                    print(responseJSON)
                    completion()
                }
            } else {
                print(error?.localizedDescription ?? "error")
            }
        }
        task.resume()
    }
    
    // PUT
    static func server(update lastCheckedOutBy: String, id: Int, completion: @escaping () -> Void) {
        let session = URLSession.shared
        let url = URL(string: "https://prolific-interview.herokuapp.com/58ab049e53fba2000ab50b6e/books/\(id)")
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "PUT"
            let requestDictionary = ["lastCheckedOutBy" : lastCheckedOutBy]
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                let httpResponse = response as! HTTPURLResponse
                if httpResponse.statusCode == 200 {
                    if let unwrappedData = data {
                        do {
                            let jsonData = try JSONSerialization.data(withJSONObject: requestDictionary, options: [])
                            request.httpBody = jsonData
                            print("RESPONSE: \(jsonData)")
                            completion()
                        } catch {}
                    } else { print(httpResponse.statusCode)}
                }
            })
            task.resume()
        }
    }
    
    // Delete a book
    static func deleteLastBookFromServer(with id: Int) {
        let session = URLSession.shared
        let url = URL(string: "https://prolific-interview.herokuapp.com/58ab049e53fba2000ab50b6e/books/\(id)")
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "DELETE"
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                let httpResponse = response as! HTTPURLResponse
                print("Delete status code: \(httpResponse.statusCode)")
            })
            task.resume()
        }
    }
}
