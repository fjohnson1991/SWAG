//
//  AddViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    let dataStore = BookDataStore.sharedInstance
    var addBookView: AddBookView!
    var addBookViewBottomConstraintConstant: NSLayoutConstraint!
    var addBookViewTopConstraintConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        setUpNotifications()
    }
    
    func configureLayout() {
        // General
        self.view.backgroundColor = UIColor.white
        self.title = "Add Book"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonCheck))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.hideKeyboardWhenTappedAround(isActive: true)
        
        // Add book view
        addBookView = AddBookView()
        addBookView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addBookView)
        addBookViewTopConstraintConstant = NSLayoutConstraint()
        addBookViewTopConstraintConstant.constant = 10
        addBookViewTopConstraintConstant = addBookView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: addBookViewTopConstraintConstant.constant)
        addBookViewTopConstraintConstant.isActive = true
        addBookViewBottomConstraintConstant = NSLayoutConstraint()
        addBookViewBottomConstraintConstant.constant = 0.0
        addBookViewBottomConstraintConstant = addBookView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: addBookViewBottomConstraintConstant.constant)
        addBookViewBottomConstraintConstant?.isActive = true
        addBookView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        addBookView.delegate = self 
    }
    
    func setUpNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(invalidEntriesError), name: Notification.Name("empty-entries-error"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(successfulSubmitBook), name: Notification.Name("successful-submit-book"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(areYouSure), name: Notification.Name("are-you-sure"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func removeNotifications() {
        NotificationCenter.default.removeObserver(self, name: Notification.Name("empty-entries-error"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("successful-submit-book"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name("are-you-sure"), object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    
    func clearTextFields() {
        self.addBookView.authorTextField.text = ""
        self.addBookView.titleTextField.text = ""
        self.addBookView.categoriesTextField.text = ""
        self.addBookView.publisherTextField.text = ""
    }
    
    // MARK: - Navigation bar selector 
    func doneButtonCheck() {
        if (addBookView.authorTextField.text != "") || (addBookView.titleTextField.text != "") || (addBookView.categoriesTextField.text != "") || (addBookView.publisherTextField.text != "") {
            self.doneButtonAlert()
        } else {
            self.clearTextFields()
            self.doneButton()
        }
    }
    
    func doneButtonAlert() {
        let yesAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction) in
            self.clearTextFields()
            self.doneButton()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        presentAlertWith(title: "Are you sure?", message: "Your changes will not be saved if you leave the page prior to submitting the book.", okAction: yesAction, cancelAction: cancelAction)
    }
    
    // MARK: - Navigation
    func doneButton() {
        let booksTableViewController: BooksTableViewController = BooksTableViewController()
        self.navigationController?.pushViewController(booksTableViewController, animated: true)
        removeNotifications()
    }
}

// MARK: - Notification funcs
extension AddBookViewController {
    
    func invalidEntriesError() {
        presentAlertWithTitle(title: "Oops", message: "You must enter the book's title and author before submitting.")
    }
    
    func successfulSubmitBook() {
        let alertController = UIAlertController(title: "Great News!", message: "You have successfully submitted a book.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) {(action: UIAlertAction) in
            self.clearTextFields()
            self.doneButton()
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func areYouSure() {
        let yesAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction) in
            self.addBookView.delegate.submitButtonPressed()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        presentAlertWith(title: "Are you sure?", message: "You have not filled in all the information.", okAction: yesAction, cancelAction: cancelAction)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        keyboardWillCoverCheck(notification: notification) { (willCover, keyboardHeight) in
            if willCover {
                if (addBookView.publisherTextField.isEditing && addBookView.categoriesTextField.text == "") || (addBookView.publisherTextField.text == "" && addBookView.categoriesTextField.isEditing) {
                    self.view.layoutIfNeeded()
                    UIView.animate(withDuration: 1, animations: {
                        self.addBookViewBottomConstraintConstant.constant = keyboardHeight! * 0.3
                        self.addBookViewTopConstraintConstant.constant = -(keyboardHeight! * 0.3)
                        self.view.layoutIfNeeded()
                    })
                }
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { print("Error calc keyboard size"); return }
        if self.addBookViewBottomConstraintConstant.constant == keyboardSize.size.height * 0.3 {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1, animations: {
                self.addBookViewBottomConstraintConstant.constant = 0.0
                self.addBookViewTopConstraintConstant.constant = 10.0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    private func keyboardWillCoverCheck(notification: NSNotification, completion: (Bool, CGFloat?) -> Void) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { print("Error calc keyboard size"); return }
        if self.view.frame.height/2 < (keyboardSize.height - 37) {
            completion(true, keyboardSize.height)
        }
        completion(false, nil)
    }
}

// MARK: - Handle AddBookViewProtocol protocol 
extension AddBookViewController: AddBookViewProtocol {
    
    func submitButtonPressed() {
        guard
            let title = addBookView.titleTextField.text,
            let author = addBookView.authorTextField.text
            else { print("titleTextField and authorTextField error unwrapping in ABV"); return }
            let categories = addBookView.categoriesTextField.text ?? ""
            let publisher = addBookView.publisherTextField.text ?? ""
        dataStore.addBookToServer(with: author, categories: categories, title: title, publisher: publisher) { (success) in
            if success {
                DispatchQueue.main.async {
                    NotificationCenter.default.post(name: Notification.Name("successful-submit-book"), object: nil)
                }
            } else {
                self.presentAlertWithTitle(title: "Sorry!", message: "Failed to add book.")
            }
        }
    }
}
