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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        BookAPICalls.deleteLastBookFromServer(with: 8)

        configLayout()
        populateBookData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configLayout() {
        self.view.backgroundColor = UIColor.white
        self.title = "Books"
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "AddButton"), style: .done, target: self, action: #selector(segueToAddBookVC))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.tableView.register(BookTableViewCell.self, forCellReuseIdentifier: "bookCell")
        self.tableView.rowHeight = 80
    }
    
    func populateBookData() {
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
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
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
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    // MARK: - Navigation
    func segueToAddBookVC() {
        let addBookViewController: AddBookViewController = AddBookViewController()
        let navOnModal: UINavigationController = UINavigationController(rootViewController: addBookViewController)
        self.present(navOnModal, animated: true, completion: nil)
    }
    
    func segueToDetailVC(with indexPath: IndexPath) {
        let detailViewController: DetailViewController = DetailViewController()
        self.navigationController?.pushViewController(detailViewController, animated: true)
        detailViewController.detailView.titleLabel.text = bookArray[indexPath.row].title
        detailViewController.detailView.authorLabel.text = bookArray[indexPath.row].author
        detailViewController.detailView.publisherLabel.text = bookArray[indexPath.row].publisher
        detailViewController.detailView.tagsLabel.text = bookArray[indexPath.row].categories
        detailViewController.detailView.lastCheckedOutLabel.text = bookArray[indexPath.row].lastCheckedOut
    }
}
