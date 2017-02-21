//
//  AddBookView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class AddBookView: UIView {
    var titleTextField: UITextField!
    var authorTextField: UITextField!
    var publisherTextField: UITextField!
    var categoriesTextField: UITextField!
    var submitButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewItems()
        configViewLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configViewItems() {
        // labels
        titleTextField = UITextField()
        titleTextField.font = UIFont.themeSmallBold
        titleTextField.textAlignment = .left
        titleTextField.layer.borderWidth = 2.0
        titleTextField.layer.cornerRadius = 5.0
        titleTextField.layer.borderColor = UIColor.themeDarkBlue.cgColor
        titleTextField.setLeftPaddingPoints(10)
        titleTextField.attributedPlaceholder = NSAttributedString(string: "Book Title")
        
        authorTextField = UITextField()
        authorTextField.font = UIFont.themeSmallBold
        authorTextField.textAlignment = .left
        authorTextField.layer.borderWidth = 2.0
        authorTextField.layer.cornerRadius = 5.0
        authorTextField.layer.borderColor = UIColor.themeDarkBlue.cgColor
        authorTextField.setLeftPaddingPoints(10)
        authorTextField.attributedPlaceholder = NSAttributedString(string: "Author")
        
        publisherTextField = UITextField()
        publisherTextField.font = UIFont.themeSmallBold
        publisherTextField.textAlignment = .left
        publisherTextField.layer.borderWidth = 2.0
        publisherTextField.layer.cornerRadius = 5.0
        publisherTextField.layer.borderColor = UIColor.themeDarkBlue.cgColor
        publisherTextField.setLeftPaddingPoints(10)
        publisherTextField.attributedPlaceholder = NSAttributedString(string: "Publisher")
        
        categoriesTextField = UITextField()
        categoriesTextField.font = UIFont.themeSmallBold
        categoriesTextField.textAlignment = .left
        categoriesTextField.layer.borderWidth = 2.0
        categoriesTextField.layer.cornerRadius = 5.0
        categoriesTextField.layer.borderColor = UIColor.themeDarkBlue.cgColor
        categoriesTextField.setLeftPaddingPoints(10)
        categoriesTextField.attributedPlaceholder = NSAttributedString(string: "Categories")
        
        // submitButton
        submitButton = UIButton()
        submitButton.setTitle("Submit", for: .normal)
        submitButton.titleLabel?.font = UIFont.themeSmallBold
        submitButton.setTitleColor(UIColor.themeDarkBlue, for: .normal)
        submitButton.layer.borderWidth = 2.0
        submitButton.layer.cornerRadius = 5.0
        submitButton.layer.borderColor = UIColor.themeDarkBlue.cgColor
    }
    
    func configViewLayout() {
        // stackView
        let stackViewItemsToAdd = [titleTextField, authorTextField, publisherTextField, categoriesTextField]
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fillEqually
        stackView.spacing = 2.0
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
}
