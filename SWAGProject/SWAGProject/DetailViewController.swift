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

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    let shareDropDownView = ShareDropDownView()
    var blurEffectView: UIVisualEffectView!
    weak var shareClickedConstraint: NSLayoutConstraint?
    weak var shareRemovedConstraint: NSLayoutConstraint?
    var passedBookID = Int()
    var clickToShare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configure()
        constrain()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configure() {
        self.view.backgroundColor = UIColor.white
        self.title = "Detail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ShareButton"), style: .done, target: self, action: #selector(shareDropdown))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        
        shareDropDownView.isHidden = true
        shareDropDownView.facebookButton.addTarget(self, action: #selector(facebookShare), for: .touchUpInside)
        shareDropDownView.twitterButton.addTarget(self, action: #selector(twitterShare), for: .touchUpInside)
        shareDropDownView.cancelButton.addTarget(self, action: #selector(cancelShare), for: .touchUpInside)
        
        // add delegate to call this instead of via target
        detailView.checkoutButton.addTarget(self, action: #selector(checkoutPressed), for: .touchUpInside)
    }
    
    func constrain() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 0).isActive = true
        detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        detailView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        detailView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor, constant: 0).isActive = true
    }
    
    func configDropDownView() {
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.light)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = self.view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.view.addSubview(blurEffectView)
        
        shareDropDownView.translatesAutoresizingMaskIntoConstraints = false
        self.blurEffectView.addSubview(shareDropDownView)
        shareClickedConstraint = shareDropDownView.topAnchor.constraint(equalTo: self.blurEffectView.topAnchor, constant: 0)
        shareClickedConstraint?.isActive = true
        shareDropDownView.trailingAnchor.constraint(equalTo: self.blurEffectView.trailingAnchor, constant: 0).isActive = true
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
            blurEffectView.removeFromSuperview()
            shareDropDownView.isHidden = true
            clickToShare = false
            self.shareClickedConstraint?.isActive = false
            self.shareRemovedConstraint?.isActive = false
            self.constrain()
        }
    }
    
    func facebookShare() {
        guard
            let title = detailView.titleLabel.text,
            let author = detailView.authorLabel.text
            else { print("Error unwrapping title and author for fbShare in DVC"); return }
        
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: "http://www.SWAG4PI.com")
        content.contentTitle = "\(title)"
        content.contentDescription = "By: \(author)"
        FBSDKShareDialog.show(from: self, with: content, delegate: self)
    }
    
    func twitterShare() {
        guard
            let title = detailView.titleLabel.text else { print("Error unwrapping title for twitterShare in DVC"); return }
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        guard let unwrappedVC = vc else { print("Error unwrapping VC in twitterShare in DVC"); return }
        unwrappedVC.setInitialText("Share your thoughts on \(title) here.")
        unwrappedVC.add(URL(string: "http://www.SWAG4PI.com"))
        present(unwrappedVC, animated: true, completion: nil)
    }
    
    func cancelShare() {
        blurEffectView.removeFromSuperview()
        shareDropDownView.isHidden = true
        clickToShare = false
        self.shareClickedConstraint?.isActive = false
        self.shareRemovedConstraint?.isActive = false
        self.constrain()
    }
    
    // MARK: - Navigation
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
        //        let booksTableViewController: BooksTableViewController = BooksTableViewController()
        //        self.navigationController?.pushViewController(booksTableViewController, animated: true)
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
