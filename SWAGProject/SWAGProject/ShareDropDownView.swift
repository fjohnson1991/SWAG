//
//  ShareDropDownView.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/21/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

protocol ShareDropDownViewProtocol: class {
    func facebookWasClicked()
    func twitterWasClicked()
    func cancelWasClicked()
}

class ShareDropDownView: UIView {
    
    lazy var facebookButton: UIButton = {
        let button = UIButton()
        button.setTitle("Facebook", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeOrange
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.setTitleColor(UIColor.themeTan, for: .highlighted)
        button.addTarget(self, action: #selector(facebookWasTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var twitterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Twitter", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeOrange
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.setTitleColor(UIColor.themeTan, for: .highlighted)
        button.addTarget(self, action: #selector(twitterWasTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Cancel", for: .normal)
        button.titleLabel?.font = UIFont.themeTinyBold
        button.setTitleColor(UIColor.white, for: .normal)
        button.backgroundColor = UIColor.themeOrange
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 2)
        button.layer.shadowOpacity = 1.0
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
        button.setTitleColor(UIColor.themeTan, for: .highlighted)
        button.addTarget(self, action: #selector(cancelWasTapped), for: .touchUpInside)
        return button
    }()
    
    weak var delegate: ShareDropDownViewProtocol!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViewConstraints()
        formatButtons()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    private func setupViewConstraints() {
        // facebookButton
        facebookButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(facebookButton)
        facebookButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        facebookButton.topAnchor.constraint(equalTo: topAnchor, constant: 20).isActive = true
        facebookButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        facebookButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // twitterButton
        twitterButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(twitterButton)
        twitterButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        twitterButton.topAnchor.constraint(equalTo: facebookButton.bottomAnchor, constant: 20).isActive = true
        twitterButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        twitterButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
        // cancelButton
        cancelButton.translatesAutoresizingMaskIntoConstraints = false
        addSubview(cancelButton)
        cancelButton.centerXAnchor.constraint(equalTo: centerXAnchor, constant: 0).isActive = true
        cancelButton.topAnchor.constraint(equalTo: twitterButton.bottomAnchor, constant: 20).isActive = true
        cancelButton.widthAnchor.constraint(equalToConstant: 80).isActive = true
        cancelButton.heightAnchor.constraint(equalToConstant: 80).isActive = true
    }
    
    private func formatButtons() {
        layoutIfNeeded()
        facebookButton.layer.cornerRadius = facebookButton.frame.width/2
        twitterButton.layer.cornerRadius = twitterButton.frame.width/2
        cancelButton.layer.cornerRadius = cancelButton.frame.width/2
    }
    
    // MARK: - Protocol funcs 
    func facebookWasTapped() {
        delegate.facebookWasClicked()
    }
    
    func twitterWasTapped() {
        delegate.twitterWasClicked()
    }
    
    func cancelWasTapped() {
        delegate.cancelWasClicked()
    }
}
