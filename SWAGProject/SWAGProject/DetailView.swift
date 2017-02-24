//
//  DetailView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    lazy var lastCheckedOutLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeBlue
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViews()
        constrainViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureViews() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.themeOrange.cgColor
    }
    
    private func constrainViews() {
        let labels = [titleLabel, authorLabel, publisherLabel, tagsLabel, lastCheckedOutLabel]
        for label in labels {
            constrain(label)
        }
    }
    
    private func constrain(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        label.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
    
    func formatCategories(of bookTags: String) -> String {
        let tagArray = bookTags.components(separatedBy: ",")
        return tagArray.joined(separator: "\n").capitalized
    }
    
    func formatLastCheckedOut(_ date: String?) -> String {
        guard let unwrappedDate = date else { print("Error unwrapping date in DV"); return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let dateComponents = Array(unwrappedDate.characters)
        var dateToFormat = String()
        for i in 0...9 {
            dateToFormat.append(dateComponents[i])
        }
        guard let format = dateFormatter.date(from: dateToFormat) else { print("Error unwrapping formatted date in DV"); return "" }
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: format)
    }
}
