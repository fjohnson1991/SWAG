//
//  AddViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class AddBookViewController: UIViewController {
    
    var addBookView: AddBookView!
    var addBookViewBottomConstraintConstant: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        setUpNotifications()
    }
    
    func configureView() {
        self.view.backgroundColor = UIColor.white
        self.title = "Add Book"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .done, target: self, action: #selector(doneButtonCheck))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        self.navigationItem.setHidesBackButton(true, animated:true)
        self.hideKeyboardWhenTappedAround(isActive: true)
        
        addBookView = AddBookView()
        addBookView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(addBookView)
        addBookView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        addBookViewBottomConstraintConstant = NSLayoutConstraint()
        addBookViewBottomConstraintConstant.constant = 0.0
        addBookViewBottomConstraintConstant = addBookView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: addBookViewBottomConstraintConstant.constant)
        addBookViewBottomConstraintConstant?.isActive = true
        addBookView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
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
    
    func doneButtonCheck() {
        if (addBookView.authorTextField.text != "") || (addBookView.titleTextField.text != "") || (addBookView.categoriesTextField.text != "") || (addBookView.publisherTextField.text != "") {
            self.doneButtonAlert()
        } else {
            self.clearTextFields()
            self.doneButton()
        }
    }
    
    func doneButtonAlert() {
        let alertController = UIAlertController(title: "Are you sure?", message: "Your changes will not be saved if you leave the page prior to submitting the book.", preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction) in
            self.clearTextFields()
            self.doneButton()
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
        removeNotifications()
    }
}

// MARK: - Notification funcs
extension AddBookViewController {
    
    func invalidEntriesError() {
        let alertController = UIAlertController(title: "Oops", message: "You must enter the book's title and author before submitting.", preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default)
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
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
        let alertController = UIAlertController(title: "Are you sure?", message: "You have not filled in all the information.", preferredStyle: .alert)
        let YesAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction) in
            self.addBookView.submitButtonPressed()
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(YesAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue else { print("Error calc keyboard size"); return }
        if addBookView.categoriesTextField.isEditing {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1, animations: {
                self.addBookViewBottomConstraintConstant.constant = keyboardSize.size.height * 0.5 + 20.0
                print(self.addBookViewBottomConstraintConstant.constant)
                self.view.layoutIfNeeded()
            })
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.addBookView.categoriesTextField.isEditing {
            self.view.layoutIfNeeded()
            UIView.animate(withDuration: 1, animations: {
                self.addBookViewBottomConstraintConstant.constant = 0.0
                self.view.layoutIfNeeded()
            })
        }
    }
}
