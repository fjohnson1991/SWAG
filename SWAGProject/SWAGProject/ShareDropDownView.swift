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
        constrain()
        formatButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeDarkBlue
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.setTitleColor(UIColor.red, for: .highlighted)
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Twitter", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeDarkBlue
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.setTitleColor(UIColor.red, for: .highlighted)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeDarkBlue
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.setTitleColor(UIColor.red, for: .highlighted)
        return button
    }()
    
    private func constrain() {
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(facebookButton)
        facebookButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        facebookButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(twitterButton)
        twitterButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        twitterButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 20).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(cancelButton)
        cancelButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        cancelButton.topAnchor.constraint(equalTo: twitterButton.bottomAnchor, constant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func formatButtons() {
        self.layoutIfNeeded()
        facebookButton.layer.cornerRadius = facebookButton.frame.width/2
        twitterButton.layer.cornerRadius = twitterButton.frame.width/2
        cancelButton.layer.cornerRadius = cancelButton.frame.width/2
    }
}
