//
//  ClearBooksView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/23/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class ClearBooksView: UIView {
    
    lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear Books?"
        label.font = UIFont.themeSmallBold
        label.textColor = UIColor.themeOffWhite
        return label
    }()
    
    lazy var executeDeleteButton: UIButton = {
        let button = UIButton()
        button.setTitle("Yes", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.themeBlue, for: .normal)
        button.backgroundColor = UIColor.themeOffWhite
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.themeBlue, for: .normal)
        button.backgroundColor = UIColor.themeOffWhite
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    lazy var deleteDropDownStackView = UIStackView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View Configuration
    private func configure() {
        self.backgroundColor = UIColor.themeBlue
        
        deleteDropDownStackView.addArrangedSubview(deleteLabel)
        deleteDropDownStackView.addArrangedSubview(executeDeleteButton)
        deleteDropDownStackView.addArrangedSubview(cancelButton)
        deleteDropDownStackView.axis = .horizontal
        deleteDropDownStackView.alignment = .center
        deleteDropDownStackView.distribution = .fillEqually
        deleteDropDownStackView.spacing = 20
        deleteDropDownStackView.layoutMargins = UIEdgeInsetsMake(12, 12, 12, 12)
    }
    
    // MARK: View Constraints
    private func constrain() {
        deleteDropDownStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(deleteDropDownStackView)
        deleteDropDownStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        deleteDropDownStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9).isActive = true
        deleteDropDownStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        deleteDropDownStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}