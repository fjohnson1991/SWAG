//
//  BookTableViewCell.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class BookTableViewCell: UITableViewCell {
    
    lazy var titleLabel: UILabel! = {
        let label = UILabel()
        label.font = UIFont.themeSmallBold
        label.textAlignment = .left
        label.textColor = UIColor.themeTan
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeTinyBoldItalic
        label.textAlignment = .left
        label.textColor = UIColor.themeBlue
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configViewLayout()
    }
    
    private func configViewLayout() {
        let stackView = UIStackView()
        stackView.axis = UILayoutConstraintAxis.vertical
        stackView.distribution = UIStackViewDistribution.fill
        stackView.spacing = 2.0
        stackView.alignment = UIStackViewAlignment.leading
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10).isActive = true
        stackView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.9).isActive = true
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(authorLabel)
    }
    
    // MARK: - Helper func called in BooksTableVC
    func capitalizeWords(in label: String) -> String {
        let labelCharArray = Array(label.characters)
        var arrayWithApostrophe = [String]()
        var finalString = String()
        if labelCharArray.contains("'") {
            let components = label.components(separatedBy: "'")
            for item in components {
                arrayWithApostrophe.append(item.capitalized)
            }
            finalString = arrayWithApostrophe.joined(separator: "'")
        } else {
            finalString = label.capitalized
        }
        return finalString
    }
}
