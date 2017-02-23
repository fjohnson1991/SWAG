//
//  DetailView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    weak var delegate: BookDetailProtocol! {
        didSet {
            titleLabel.text = "Title: \n\(delegate.bookTitle)"
            authorLabel.text = "Author(s): \(delegate.author)"
            publisherLabel.text = "Publisher: \(delegate.publisher)"
            tagsLabel.text = "Tags: \(delegate.tags)"
            lastCheckedOutLabel.text = "Last checked out by: \(delegate.lastCheckedOutBy) \n\nDate last checked out: \(delegate.lastCheckedOut)"
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var authorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var publisherLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var tagsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    lazy var lastCheckedOutLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.themeMediumBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .left
        label.isHidden = true
        return label
    }()
    
    func configure() {
        self.layer.borderWidth = 2.0
        self.layer.borderColor = UIColor.themeOrange.cgColor
    }
    
    func constrain() {
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
}
