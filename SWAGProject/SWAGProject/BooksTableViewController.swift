//
//  BooksTableViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    var bookArray = [Book]()
    var clearBooksView: ClearBooksView!
    var backgroundView: UIView!
    var clearClickedConstraint: NSLayoutConstraint?
    var clearRemovedConstraint: NSLayoutConstraint?
    var clickToDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configLayout()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        populateBookData()
    }
    
    func configLayout() {
        self.view.backgroundColor = UIColor.white
        self.title = "Books"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "AddButton"), style: .done, target: self, action: #selector(segueToAddBookVC))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(clearBooks))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "bookCell")
        self.tableView.rowHeight = 65
        
        // Clear books drop down
        clearBooksView = ClearBooksView()
        clearBooksView.isHidden = true
        clearBooksView.executeDeleteButton.addTarget(self, action: #selector(executeClearBooks), for: .touchUpInside)
        clearBooksView.cancelButton.addTarget(self, action: #selector(cancelClearBooks), for: .touchUpInside)
    }
    
    func populateBookData() {
        bookArray.removeAll()
        BookAPICalls.serverRequest { (responseJSON) in
            for response in responseJSON {
                guard let newBook = Book(dict: response) else { print("Error populating book data in BTVC"); return }
                self.bookArray.append(newBook)
            }
            OperationQueue.main.addOperation {
                self.tableView.reloadData()
            }
        }
    }
    
    func clearBooks() {
        if clickToDelete == false {
            configClearBooks()
            clearBooksView.isHidden = false
            clickToDelete = true
            self.clearClickedConstraint?.isActive = false
            self.clearRemovedConstraint = self.clearBooksView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
            self.clearRemovedConstraint?.isActive = true
        } else {
            backgroundView.removeFromSuperview()
            clearBooksView.isHidden = true
            clickToDelete = false
            self.clearClickedConstraint?.isActive = false
            self.clearRemovedConstraint?.isActive = false
        }
    }
    
    func configClearBooks() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.frame = self.view.bounds
        self.view.addSubview(backgroundView)
        
        clearBooksView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView.addSubview(clearBooksView)
        clearClickedConstraint = clearBooksView.bottomAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
        clearClickedConstraint?.isActive = true
        clearBooksView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0).isActive = true
        clearBooksView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        clearBooksView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
    }
    
    func executeClearBooks() {
        BookAPICalls.clearBooksFromServer()
    }
    
    func cancelClearBooks() {
        backgroundView.removeFromSuperview()
        clearBooksView.isHidden = true
        clickToDelete = false
        self.clearClickedConstraint?.isActive = false
        self.clearRemovedConstraint?.isActive = false
    }
    
    // MARK: - Navigation
    func segueToAddBookVC() {
        let addBookViewController: AddBookViewController = AddBookViewController()
        let navOnModal: UINavigationController = UINavigationController(rootViewController: addBookViewController)
        self.present(navOnModal, animated: true, completion: nil)
    }
    
    func segueToDetailVC(with indexPath: IndexPath) {
        let detailViewController: DetailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
        let book = bookArray[indexPath.row]
        detailViewController.book = book
    }
}

// MARK: - TableViewDelegate & TableViewDataSource funcs
extension BooksTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        cell.titleLabel.text = bookArray[indexPath.row].title
        cell.authorLabel.text = bookArray[indexPath.row].author
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        segueToDetailVC(with: indexPath)
    }
}
