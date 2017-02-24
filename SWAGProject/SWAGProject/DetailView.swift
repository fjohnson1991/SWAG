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
        configViewLayout()
        setupViewConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViewLayout() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.themeOrange.cgColor
    }
    
    private func setupViewConstraints() {
        let labels = [titleLabel, authorLabel, publisherLabel, tagsLabel, lastCheckedOutLabel]
        for label in labels {
            constrain(label)
        }
    }
    
    // MARK: - Helper func to constrain labels 
    private func constrain(_ label: UILabel) {
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        label.widthAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.9).isActive = true
        label.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 0).isActive = true
    }
    
    // MARK: - Helper funcs called in DetailVC segmentedControlSegues()
    func formatCategories(of bookTags: String) -> String {
        let tagArray = bookTags.components(separatedBy: ",")
        return tagArray.joined(separator: "\n").capitalized
    }
    
    func formatLastCheckedOut(_ date: String?) -> String {
        guard let unwrappedDate = date else { print("Error unwrapping date in DV"); return "" }
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC")
        guard let convertedDate = dateFormatter.date(from: unwrappedDate) else { print("Error unwrapping convertedDate in DV"); return "" }
        dateFormatter.timeZone = TimeZone(abbreviation: "EST")
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: convertedDate)
    }
}
