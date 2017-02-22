//
//  AddViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    let addBookView = AddBookView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configView()
        NotificationCenter.default.addObserver(self, selector: #selector(invalidEntriesError), name: Notification.Name("empty-entries-error"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(successfulSubmitBook), name: Notification.Name("successful-submit-book"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(areYouSure), name: Notification.Name("are-you-sure"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configView() {
        self.view.backgroundColor = UIColor.white
        self.title = "Add Book"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButton))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        self.navigationItem.setHidesBackButton(true, animated:true)
        
        addBookView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addBookView)
        addBookView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        addBookView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        addBookView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
    }
    
    func invalidEntriesError() {
        let alertController = UIAlertController(title: "Oops", message: "You must enter the book's title and author before submitting", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func successfulSubmitBook() {
        let alertController = UIAlertController(title: "Great News!", message: "You have successfully submitted a book.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
        self.addBookView.authorTextField.text = ""
        self.addBookView.titleTextField.text = ""
        self.addBookView.categoriesTextField.text = ""
        self.addBookView.publisherTextField.text = ""
    }
    
    func areYouSure() {
        let alertController = UIAlertController(title: "Are you sure?", message: "You have not filled in all the information", preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction) in
            self.addBookView.submitButtonPressed()
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(YesAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Navigation
    func doneButton() {
        let booksTableViewController: BooksTableViewController = BooksTableViewController()
        self.navigationController?.pushViewController(booksTableViewController, animated: true)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("empty-entries-error"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("successful-submit-book"), object: nil)
        
        // MAKE SURE OBSERVERS STILL WORK IF DECIDE TO ADD A SECOND BOOK AFTER THE FIRST HAS BEEN COMPLETED
    }
}
