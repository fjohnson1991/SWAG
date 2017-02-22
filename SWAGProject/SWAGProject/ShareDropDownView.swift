//
//  ShareDropDownView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/21/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class ShareDropDownView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
        constrain()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.themeDarkBlue, for: .normal)
        button.backgroundColor = UIColor.white
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Twitter", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.themeDarkBlue, for: .normal)
        button.backgroundColor = UIColor.white
        button.contentEdgeInsets = UIEdgeInsetsMake(5, 8, 5, 8)
        button.layer.cornerRadius = 12.0
        return button
    }()
    
    lazy var shareDropDownStackView = UIStackView()
    
    // MARK: View Configuration
    private func configure() {
        self.backgroundColor = UIColor.themeDarkBlue
        
        shareDropDownStackView.addArrangedSubview(facebookButton)
        shareDropDownStackView.addArrangedSubview(twitterButton)
        shareDropDownStackView.axis = .horizontal
        shareDropDownStackView.alignment = .center
        shareDropDownStackView.distribution = .fillEqually
        shareDropDownStackView.spacing = 2.0
        shareDropDownStackView.layoutMargins = UIEdgeInsetsMake(12, 12, 12, 12)
    }
    
    // MARK: View Constraints
    private func constrain() {
        shareDropDownStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(shareDropDownStackView)
        shareDropDownStackView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 1).isActive = true
        shareDropDownStackView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1).isActive = true
        shareDropDownStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        shareDropDownStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
    }
}
