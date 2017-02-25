//
//  BooksTableViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BooksTableViewController: UITableViewController {
    
    let dataStore = BookDataStore.sharedInstance
    var clearBooksView: ClearBooksView!
    var backgroundView: UIView!
    var noDataView: NoDataView!
    var clearClickedConstraint: NSLayoutConstraint!
    var clearRemovedConstraint: NSLayoutConstraint!
    var clickToDelete = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        showTableViewOrNoDataView()
    }
    
    func configureLayout() {
        view.backgroundColor = UIColor.white
        title = "Books"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "AddButton"), style: .done, target: self, action: #selector(segueToAddBookVC))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear All", style: .done, target: self, action: #selector(clearBooks))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "bookCell")
        tableView.rowHeight = 65
        
        // Clear books drop down
        clearBooksView = ClearBooksView()
        clearBooksView.isHidden = true
        clearBooksView.delegate = self 
    }
    
    // MARK: - Determine if books exist & populate tableView or handle when no data view
    func showTableViewOrNoDataView() {
        dataStore.populateBookData { (success) in
            if success {
                if self.dataStore.bookArray.count == 0 {
                    DispatchQueue.main.async {
                        self.noDataViewConfigure()
                    }
                } else if self.dataStore.bookArray.count > 0 {
                    if self.noDataView != nil && self.view.subviews.contains(self.noDataView) {
                        self.noDataView.removeFromSuperview()
                    }
                }
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            } else {
                self.presentAlertWithTitle(title: "Sorry!", message: "Failed to fetch book data")
            }
        }
    }
    
    func noDataViewConfigure() {
        noDataView = NoDataView()
        noDataView.frame = view.bounds
        view.addSubview(noDataView)
    }
    
    // MARK: - Clear drop down config & funcs
    func clearBooks() {
        if clickToDelete == false {
            configClearBooks()
            clearBooksView.isHidden = false
            clickToDelete = true
            clearClickedConstraint.isActive = false
            clearRemovedConstraint = clearBooksView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
            clearRemovedConstraint?.isActive = true
        } else {
            backgroundView.removeFromSuperview()
            clearBooksView.isHidden = true
            clickToDelete = false
            clearClickedConstraint.isActive = false
            clearRemovedConstraint.isActive = false
        }
    }
    
    func configClearBooks() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.frame = view.bounds
        view.addSubview(backgroundView)
        
        clearBooksView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(clearBooksView)
        clearClickedConstraint = clearBooksView.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 0)
        clearClickedConstraint.isActive = true
        clearBooksView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0).isActive = true
        clearBooksView.heightAnchor.constraint(equalToConstant: 65).isActive = true
        clearBooksView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Navigation
    func segueToAddBookVC() {
        let addBookViewController: AddBookViewController = AddBookViewController()
        let navOnModal: UINavigationController = UINavigationController(rootViewController: addBookViewController)
        self.present(navOnModal, animated: true, completion: nil)
    }
    
    func segueToDetailVC(with indexPath: IndexPath) {
        let detailViewController: DetailViewController = DetailViewController()
        let book = dataStore.bookArray[indexPath.row]
        detailViewController.book = book
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

// MARK: - Handle TableViewDelegate & TableViewDataSource
extension BooksTableViewController {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataStore.bookArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bookCell", for: indexPath) as! BookTableViewCell
        let currentBook = dataStore.bookArray[indexPath.row]
        cell.titleLabel.text = currentBook.capitalizeWords(in: currentBook.title)
        cell.authorLabel.text = currentBook.capitalizeWords(in: currentBook.author)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.segueToDetailVC(with: indexPath)
    }
}

// MARK: - Handle ClearBooksViewProtocol
extension BooksTableViewController: ClearBooksViewProtocol {
    func executeDeleteWasClicked() {
        dataStore.deleteAllBooks { (success) in
            if success {
                self.cancelWasClicked()
                self.showTableViewOrNoDataView()
            } else {
                self.presentAlertWithTitle(title: "Sorry!", message: "Failed to delete all books.")
            }
        }
    }
    
    func cancelWasClicked() {
        clickToDelete = false
        DispatchQueue.main.async {
            self.backgroundView.removeFromSuperview()
            self.clearBooksView.isHidden = true
            self.clearClickedConstraint.isActive = false
            self.clearRemovedConstraint.isActive = false
        }
    }
}

