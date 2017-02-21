//
//  BookTableViewCell.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configViewLayout()
    }
    
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.themeSmallBold
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeTinyBold
        label.textAlignment = .left
        label.textColor = UIColor.black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    func configViewLayout() {
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fill
        stackView.spacing = 2.0
        stackView.alignment = UIStackViewAlignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalTo: self.contentView.heightAnchor, multiplier: 0.9).isActive = true
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
    }
}
