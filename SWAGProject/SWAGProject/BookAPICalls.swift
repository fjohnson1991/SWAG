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
    static func serverRequest(with completion: @escaping (([[String: Any]], Bool) -> Void)) {
        let session = URLSession.shared
        let url = URL(string: Constants.serverBaseURL)
        guard let unwrappedURL = url else {return}
        let task = session.dataTask(with: unwrappedURL) { (data, response, error) in
            if error != nil {
                completion([], false)
            }
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let responseJSON = try JSONSerialization.jsonObject(with: data, options: []) as! [[String: Any]]
                    completion(responseJSON, true)
                } catch {}
            } else { print(httpResponse.statusCode)}
        }
        task.resume()
    }
    
    // POST
    static func server(post author: String, categories: String?, title: String, publisher: String?, completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: Constants.serverBaseURL) else { return }
        var urlRequest = URLRequest(url: url)
        var dictionary = [String: Any]()
        dictionary["title"] = title
        dictionary["categories"] = categories
        dictionary["author"] = author
        dictionary["publisher"] = publisher
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        guard let unwrappedData = jsonData else { return }
        urlRequest.httpBody = unwrappedData
        urlRequest.httpMethod = "POST"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                guard let error = error?.localizedDescription else { return }
                print(error)
                completion(false)
            }
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                guard let data = data else { return }
                do {
                    let response = try JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                    print(response)
                    completion(true)
                } catch {}
            } else { print(httpResponse.statusCode)}
        }
        task.resume()
    }
    
    // PUT
    static func server(update id: Int, dictionary:[String: Any], completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "\(Constants.serverBaseURL)/\(id)") else { return }
        var urlRequest = URLRequest(url: url)
        let jsonData = try? JSONSerialization.data(withJSONObject: dictionary, options: [])
        guard let unwrappedData = jsonData else { return }
        urlRequest.httpBody = unwrappedData
        urlRequest.httpMethod = "PUT"
        urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let session = URLSession.shared
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            if error != nil {
                guard let error = error?.localizedDescription else { return }
                print(error)
                completion(false)
            }
            let httpResponse = response as! HTTPURLResponse
            if httpResponse.statusCode == 200 {
                completion(true)
            } else { print(httpResponse.statusCode)}
        }
        task.resume()
    }
    
    // DELETE (one book)
    static func deleteBookFromServer(with id: Int, completion: @escaping (Bool) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "\(Constants.serverBaseURL)/\(id)")
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "DELETE"
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    guard let error = error?.localizedDescription else { return }
                    print(error)
                    completion(false)
                } else {
                    let httpResponse = response as! HTTPURLResponse
                    print("Delete status code: \(httpResponse.statusCode)")
                    completion(true)
                }
            })
            task.resume()
        }
    }
    
    // DELETE (all books)
    static func clearBooksFromServer(with completion: @escaping (Bool) -> Void) {
        let session = URLSession.shared
        let url = URL(string: "https://prolific-interview.herokuapp.com/58ab049e53fba2000ab50b6e/clean")
        if let unwrappedURL = url {
            var request = URLRequest(url: unwrappedURL)
            request.httpMethod = "DELETE"
            let task = session.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    guard let error = error?.localizedDescription else { return }
                    print(error)
                    completion(false)
                } else {
                    let httpResponse = response as! HTTPURLResponse
                    print("Delete status code: \(httpResponse.statusCode)")
                    completion(true)
                }
            })
            task.resume()
        }
    }
}
