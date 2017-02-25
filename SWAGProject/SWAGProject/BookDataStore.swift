//
//  BookDataStore.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/24/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation

final class BookDataStore {
    
    static let sharedInstance = BookDataStore()
    private init() {}
    
    var bookArray = [Book]()
    
    // MARK: - Populate bookArray
    func populateBookData(with completion: @escaping (Bool) -> Void) {
        bookArray.removeAll()
        BookAPICalls.serverRequest { (responseJSON, success) in
            if success {
                for response in responseJSON {
                    guard let newBook = Book(dict: response) else { print("Error populating book data in BTVC"); return }
                    self.bookArray.append(newBook)
                }
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // MARK: - Add book to server 
    func addBookToServer(with author: String, categories: String, title: String, publisher: String, completion: @escaping (Bool) -> Void) {
        BookAPICalls.server(post: author, categories: categories, title: title, publisher: publisher) { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
    // MARK: - Update book 
    func updateBookInfo(with id: Int, dictionary:[String: Any], completion: @escaping (Bool) -> Void) {
        BookAPICalls.server(update: id, dictionary: dictionary, completion: { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    // MARK: - Delete one book from server 
    func deleteOneBook(with id: Int, completion: @escaping (Bool) -> Void) {
        BookAPICalls.deleteBookFromServer(with: id, completion: { (success) in
            if success {
                completion(true)
            } else {
                completion(false)
            }
        })
    }
    
    // MARK: - Delete all books
    func deleteAllBooks(with completion: @escaping (Bool) -> Void) {
        BookAPICalls.clearBooksFromServer { (success) in
            if success {
                self.populateBookData(with: {_ in })
                completion(true)
            } else {
                completion(false)
            }
        }
    }
    
}
