//
//  ClearBooksView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/23/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

protocol ClearBooksViewProtocol: class {
    func executeDeleteWasClicked()
    func cancelWasClicked()
}

class ClearBooksView: UIView {
    
    lazy var deleteLabel: UILabel = {
        let label = UILabel()
        label.text = "Clear Books?"
        label.adjustsFontSizeToFitWidth = true 
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
        button.addTarget(self, action: #selector(executeDeleteWasTapped), for: .touchUpInside)
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
        button.addTarget(self, action: #selector(cancelWasTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var deleteDropDownStackView = UIStackView()
    weak var delegate: ClearBooksViewProtocol!

    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewLayout()
        setupViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // MARK: View Configuration
    private func configViewLayout() {
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
    private func setupViewConstraints() {
        deleteDropDownStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(deleteDropDownStackView)
        deleteDropDownStackView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 1).isActive = true
        deleteDropDownStackView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.9).isActive = true
        deleteDropDownStackView.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        deleteDropDownStackView.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Protocol funcs
    func executeDeleteWasTapped() {
        delegate.executeDeleteWasClicked()
    }
    
    func cancelWasTapped() {
        delegate.cancelWasClicked()
    }
}
