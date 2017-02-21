//
//  DetailView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    var titleLabel: UILabel!
    var authorLabel: UILabel!
    var publisherLabel: UILabel!
    var tagsLabel: UILabel!
    var lastCheckedOutLabel: UILabel!
    var checkoutButton: UIButton!

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
        titleLabel = UILabel()
        titleLabel.font = UIFont.themeMediumBold
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        titleLabel.textAlignment = .left
        titleLabel.text = "Title Placeholder"
        
        authorLabel = UILabel()
        authorLabel.font = UIFont.themeSmallBold
        authorLabel.numberOfLines = 0
        authorLabel.lineBreakMode = .byWordWrapping
        authorLabel.textAlignment = .left
        authorLabel.text = "Author Placeholder"
        
        publisherLabel = UILabel()
        publisherLabel.font = UIFont.themeTinyBold
        publisherLabel.numberOfLines = 0
        publisherLabel.lineBreakMode = .byWordWrapping
        publisherLabel.textAlignment = .left
        publisherLabel.text = "Publisher: Publisher Placeholder"

        tagsLabel = UILabel()
        tagsLabel.font = UIFont.themeTinyBold
        tagsLabel.numberOfLines = 0
        tagsLabel.lineBreakMode = .byWordWrapping
        tagsLabel.textAlignment = .left
        tagsLabel.text = "Tags: Tags Placeholder"
        
        lastCheckedOutLabel = UILabel()
        lastCheckedOutLabel.font = UIFont.themeTinyBold
        lastCheckedOutLabel.numberOfLines = 0
        lastCheckedOutLabel.lineBreakMode = .byWordWrapping
        lastCheckedOutLabel.textAlignment = .left
        lastCheckedOutLabel.text = "Last Checked Out: \nPlaceholder"
        
        // checkoutButton
        checkoutButton = UIButton()
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.titleLabel?.font = UIFont.themeSmallBold
        checkoutButton.setTitleColor(UIColor.themeDarkBlue, for: .normal)
        checkoutButton.layer.borderWidth = 2.0
        checkoutButton.layer.cornerRadius = 5.0
        checkoutButton.layer.borderColor = UIColor.themeDarkBlue.cgColor
    }
    
    func configViewLayout() {
        // stackView
        let stackViewItemsToAdd = [titleLabel, authorLabel, publisherLabel, tagsLabel, lastCheckedOutLabel]
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.equalSpacing
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
        }
        
        // checkoutButton
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(checkoutButton)
        checkoutButton.centerXAnchor.constraint(equalTo: stackView.centerXAnchor, constant: 0).isActive = true
        checkoutButton.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 10).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
}
