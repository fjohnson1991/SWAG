//
//  DetailViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit
import Social
import FBSDKShareKit

protocol BookDetailProtocol: class {
    var bookTitle: String { get set }
    var author: String { get set }
    var publisher: String { get set }
    var tags: String { get set }
    var lastCheckedOut: String { get set }
    var lastCheckedOutBy: String { get set }
}

class DetailViewController: UIViewController, BookDetailProtocol {
    
    let detailView = DetailView()
    var segmentedControl = UISegmentedControl(items: ["Title", "Author(s)", "Publisher", "Tags", "Other"])
    var checkoutButton: UIButton!
    let shareDropDownView = ShareDropDownView()
    var backgroundView: UIView!
    var shareClickedConstraint: NSLayoutConstraint?
    var shareRemovedConstraint: NSLayoutConstraint?
    
    var bookTitle = String()
    var author = String()
    var publisher = String()
    var tags = String()
    var lastCheckedOut = String()
    var lastCheckedOutBy = String()
    var passedBookID = Int()
    var clickToShare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        constrain()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmentedControl.selectedSegmentIndex = 0
        detailView.delegate = self
        detailView.titleLabel.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure() {
        // VC
        self.view.backgroundColor = UIColor.white
        self.title = "Detail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ShareButton"), style: .done, target: self, action: #selector(shareDropdown))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        
        // Segmented controller 
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.themeTan, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 11.0)!], for: .normal)
        segmentedControl.tintColor = UIColor.themeOrange
        
        // Checkout button 
        checkoutButton = UIButton()
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.titleLabel?.font = UIFont.themeSmallBold
        checkoutButton.setTitleColor(UIColor.themeOffWhite, for: .normal)
        checkoutButton.layer.cornerRadius = 5.0
        checkoutButton.layer.backgroundColor = UIColor.themeGreen.cgColor
        checkoutButton.addTarget(self, action: #selector(checkoutPressed), for: .touchUpInside)
        
        // Share drop down
        shareDropDownView.isHidden = true
        shareDropDownView.facebookButton.addTarget(self, action: #selector(facebookShare), for: .touchUpInside)
        shareDropDownView.twitterButton.addTarget(self, action: #selector(twitterShare), for: .touchUpInside)
        shareDropDownView.cancelButton.addTarget(self, action: #selector(cancelShare), for: .touchUpInside)
    }
    
    func constrain() {
        // Detail view
        detailView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        detailView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.6).isActive = true
        detailView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        detailView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        detailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
        
        // Segmented controller
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(segmentedControl)
        segmentedControl.heightAnchor.constraint(equalToConstant: 17).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -10).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 8).isActive = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlSegues), for: .valueChanged)
        
        // Checkout button
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(checkoutButton)
        checkoutButton.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor, constant: 0).isActive = true
        checkoutButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // MARK: - Config segmented control selector
    func segmentedControlSegues(sender: UISegmentedControl!) {
        if sender.selectedSegmentIndex == 0 {
            hideAllLabels()
            animateTransition()
            detailView.delegate = self
            detailView.titleLabel.isHidden = false
        } else if sender.selectedSegmentIndex == 1 {
            hideAllLabels()
            animateTransition()
            detailView.delegate = self
            detailView.authorLabel.isHidden = false
        } else if sender.selectedSegmentIndex == 2 {
            hideAllLabels()
            animateTransition()
            detailView.delegate = self
            detailView.publisherLabel.isHidden = false
        } else if sender.selectedSegmentIndex == 3 {
            hideAllLabels()
            animateTransition()
            detailView.delegate = self
            detailView.tagsLabel.isHidden = false
        } else if sender.selectedSegmentIndex == 4 {
            hideAllLabels()
            animateTransition()
            detailView.delegate = self
            detailView.lastCheckedOutLabel.isHidden = false
        }
    }
    
    func hideAllLabels() {
        detailView.titleLabel.isHidden = true
        detailView.authorLabel.isHidden = true
        detailView.publisherLabel.isHidden = true
        detailView.tagsLabel.isHidden = true
        detailView.lastCheckedOutLabel.isHidden = true
    }
    
    // MARK: - Animation
    func animateTransition() {
        let transitionOptions: UIViewAnimationOptions = [.transitionFlipFromRight, .showHideTransitionViews]
        UIView.transition(with: detailView, duration: 1.0, options: transitionOptions, animations: {
            self.detailView.isHidden = true
        })
        UIView.transition(with: detailView, duration: 1.0, options: transitionOptions, animations: {
            self.detailView.isHidden = false
        })
    }
    
    // MARK: - Checkout button selector
    func checkoutPressed() {
        let alert = UIAlertController(title: "Checking out?", message: "Please enter your name below", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (nameTextField) in
            nameTextField.text = "" }
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { (_) in
            
            let nameTextField = alert.textFields![0]
            guard let unwrappedName = nameTextField.text else { print("Error unwrapping name"); return }
            BookAPICalls.server(update: self.passedBookID, lastCheckedOutBy: unwrappedName, lastCheckedOut: "\(Date())")
            print("Date: \(Date())")
            print("passedID: \(self.passedBookID)")
            print("name: \(unwrappedName)")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //MARK: - Drop down funcs when clicked
    func configDropDownView() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.frame = self.view.bounds
        self.view.addSubview(backgroundView)
        
        shareDropDownView.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundView.addSubview(shareDropDownView)
        shareClickedConstraint = shareDropDownView.topAnchor.constraint(equalTo: self.backgroundView.topAnchor, constant: 0)
        shareClickedConstraint?.isActive = true
        shareDropDownView.trailingAnchor.constraint(equalTo: self.backgroundView.trailingAnchor, constant: 0).isActive = true
        shareDropDownView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        shareDropDownView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func shareDropdown() {
        if clickToShare == false {
            configDropDownView()
            shareDropDownView.isHidden = false
            clickToShare = true
            self.shareClickedConstraint?.isActive = false
            self.shareRemovedConstraint = self.shareDropDownView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0)
            self.shareRemovedConstraint?.isActive = true
        } else {
            backgroundView.removeFromSuperview()
            shareDropDownView.isHidden = true
            clickToShare = false
            self.shareClickedConstraint?.isActive = false
            self.shareRemovedConstraint?.isActive = false
            self.constrain()
        }
    }
    
    func facebookShare() {
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: "http://www.SWAG4PI.com")
        content.contentTitle = "\(bookTitle)"
        content.contentDescription = "By: \(author)"
        FBSDKShareDialog.show(from: self, with: content, delegate: self)
    }
    
    func twitterShare() {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        guard let unwrappedVC = vc else { print("Error unwrapping twitterShare details in DVC"); return }
        unwrappedVC.setInitialText("Share your thoughts on \(bookTitle) here.")
        unwrappedVC.add(URL(string: "http://www.SWAG4PI.com"))
        present(unwrappedVC, animated: true, completion: nil)
    }
    
    func cancelShare() {
        backgroundView.removeFromSuperview()
        shareDropDownView.isHidden = true
        clickToShare = false
        self.shareClickedConstraint?.isActive = false
        self.shareRemovedConstraint?.isActive = false
        self.constrain()
    }
}

// Handle FBSDKSharingDelegate protocol
extension DetailViewController: FBSDKSharingDelegate {
    
    func sharer(_ sharer: FBSDKSharing!, didCompleteWithResults results: [AnyHashable : Any]!) {
        print("RESULTS: \(results)")
    }
    
    func sharer(_ sharer: FBSDKSharing!, didFailWithError error: Error!) {
        print("ERROR: \(error)")
    }
    
    func sharerDidCancel(_ sharer: FBSDKSharing!) {
        print("sharerDidCancel")
    }
}
