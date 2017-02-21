//
//  BookTableViewCell.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    var titleLabel: UILabel!
    var authorLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        configViewItems()
        configViewLayout()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configViewItems() {
        titleLabel = UILabel()
        titleLabel.font = UIFont.themeSmallBold
        titleLabel.textAlignment = .left
        titleLabel.text = "Book Title"
        
        authorLabel = UILabel()
        authorLabel.font = UIFont.themeTinyBold
        authorLabel.textAlignment = .left
        authorLabel.text = "Author"
    }
    
    func configViewLayout() {
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
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
    }
}
