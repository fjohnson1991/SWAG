//
//  AddBookView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class AddBookView: UIView, UITextFieldDelegate {
    
    var titleTextField: UITextField!
    var authorTextField: UITextField!
    var publisherTextField: UITextField!
    var categoriesTextField: UITextField!
    var submitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure() {
        // textFields
        titleTextField = UITextField()
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Book Title")
        
        authorTextField = UITextField()
        authorTextField.attributedPlaceholder = NSAttributedString(string: "Author")
        
        publisherTextField = UITextField()
        publisherTextField.attributedPlaceholder = NSAttributedString(string: "Publisher")
        
        categoriesTextField = UITextField()
        categoriesTextField.attributedPlaceholder = NSAttributedString(string: "Categories")
        
        let textFields = [titleTextField, authorTextField, publisherTextField, categoriesTextField]
        for textField in textFields {
            guard let unwrappedTextField = textField else { print("Error config textFields in ABV"); return }
            config(unwrappedTextField)
        }
        
        // submitButton
        submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = UIFont.themeSmallBold
        submitButton.setTitleColor(UIColor.themeOffWhite, for: .normal)
        submitButton.layer.cornerRadius = 5.0
        submitButton.layer.backgroundColor = UIColor.themeGreen.cgColor
        submitButton.addTarget(self, action: #selector(submitButtonPressedChecks), for: .touchUpInside)
    }
    
    func config(_ textField: UITextField) {
        textField.delegate = self
        textField.font = UIFont.themeSmallBold
        textField.textAlignment = .left
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 5.0
        textField.layer.borderColor = UIColor.themeOrange.cgColor
        textField.setLeftPaddingPoints(10)
    }
    
    func constrain() {
        // stackView
        let stackViewItemsToAdd = [titleTextField, authorTextField, publisherTextField, categoriesTextField]
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.spacing = 10.0
        stackView.alignment = UIStackViewAlignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        stackView.heightAnchor.constraint(equalToConstant: 200).isActive = true
        for item in stackViewItemsToAdd {
            guard let unwrappedItem = item else { print("Error unwrapping stackViewItemsToAdd item"); return }
            stackView.addArrangedSubview(unwrappedItem)
            item?.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 1).isActive = true
        }
        
        // submitButton
        submitButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(submitButton)
        submitButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 0).isActive = true
        submitButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        submitButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        submitButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    func submitButtonPressedChecks() {
        if titleTextField.text == "" || authorTextField.text == "" {
            NotificationCenter.default.post(name: Notification.Name("empty-entries-error"), object: nil)
        }
        
        if titleTextField.text != "" && authorTextField.text != "" && categoriesTextField.text == "" || publisherTextField.text == "" {
            NotificationCenter.default.post(name: Notification.Name("are-you-sure"), object: nil)
        }
        
        if titleTextField.text != "" && authorTextField.text != "" && categoriesTextField.text != "" && publisherTextField.text != "" {
            submitButtonPressed()
        }
    }
    
    func submitButtonPressed() {
        guard
            let title = titleTextField.text,
            let author = authorTextField.text
            else { print("titleTextField and authorTextField error unwrapping in ABV"); return }
        let categories = categoriesTextField.text ?? ""
        let publisher = publisherTextField.text ?? ""
        
        BookAPICalls.server(post: author, categories: categories, title: title, publisher: publisher) {
            OperationQueue.main.addOperation {
                NotificationCenter.default.post(name: Notification.Name("successful-submit-book"), object: nil)
            }
        }
    }
}

extension AddBookView {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.textField(change: true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        textField.textField(change: false)
    }
}
