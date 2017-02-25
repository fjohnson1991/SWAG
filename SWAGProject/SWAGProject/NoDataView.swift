//
//  NoDataView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/24/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class NoDataView: UIView {
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.themeOrange
        label.font = UIFont.themeSmallBold
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.textAlignment = .center
        label.text = "Welcome to SWAG4PI! Click the \"+\" button on the top left corner to add books. All the added books will show up here. You can click on each book to find out the book's details and to update or remove the book. Want to start fresh? Click the \"Clear All\" button on the top right. Have fun!"
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configViewLayoutAndConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configViewLayoutAndConstraints() {
        backgroundColor = UIColor.themeOffWhite
        
        welcomeLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(welcomeLabel)
        welcomeLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        welcomeLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        welcomeLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8).isActive = true
        welcomeLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
