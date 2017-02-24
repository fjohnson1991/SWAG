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

enum SegmentItems {
    case title
    case author
    case publisher
    case tags
    case other

    func convertToString() -> String {
        switch self {
        case .title:
            return "Title"
        case .author:
            return "Author(s)"
        case .publisher:
            return "Publisher"
        case .tags:
            return "Tags"
        case .other:
            return "Other"
        }
    }
}

class DetailViewController: UIViewController {
 
    var book: Book!
    var detailView: DetailView!
    var segmentedControl: UISegmentedControl!
    var checkoutButton: UIButton!
    var deleteButton: UIButton!
    var shareDropDownView: ShareDropDownView!
    var backgroundView: UIView!
    var shareClickedConstraint: NSLayoutConstraint?
    var shareRemovedConstraint: NSLayoutConstraint?
    var clickToShare = false
    var segmentItems: [SegmentItems]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        segmentedControlConfig()
        constrainView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmentedControl.selectedSegmentIndex = 0
        detailView.titleLabel.text = book.title
        detailView.titleLabel.isHidden = false
    }
    
    func configureView() {
        // VC
        self.view.backgroundColor = UIColor.white
        self.title = "Detail"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ShareButton"), style: .done, target: self, action: #selector(shareDropdown))
        self.navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        
        // Checkout button 
        checkoutButton = UIButton()
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.titleLabel?.font = UIFont.themeSmallBold
        checkoutButton.setTitleColor(UIColor.themeOffWhite, for: .normal)
        checkoutButton.layer.cornerRadius = 5.0
        checkoutButton.layer.backgroundColor = UIColor.themeGreen.cgColor
        checkoutButton.addTarget(self, action: #selector(checkoutPressed), for: .touchUpInside)
        
        // Delete button
        deleteButton = UIButton()
        deleteButton.setTitle("Delete", for: .normal)
        deleteButton.titleLabel?.font = UIFont.themeSmallBold
        deleteButton.setTitleColor(UIColor.themeOffWhite, for: .normal)
        deleteButton.layer.cornerRadius = 5.0
        deleteButton.layer.backgroundColor = UIColor.themeBlue.cgColor
        deleteButton.addTarget(self, action: #selector(deletePressed), for: .touchUpInside)
        
        // Share drop down
        shareDropDownView = ShareDropDownView()
        shareDropDownView.isHidden = true
        shareDropDownView.facebookButton.addTarget(self, action: #selector(facebookShare), for: .touchUpInside)
        shareDropDownView.twitterButton.addTarget(self, action: #selector(twitterShare), for: .touchUpInside)
        shareDropDownView.cancelButton.addTarget(self, action: #selector(cancelShare), for: .touchUpInside)
    }
    
    func constrainView() {
        // Detail view
        detailView = DetailView()
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
        
        // Delete button
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(deleteButton)
        deleteButton.centerXAnchor.constraint(equalTo: checkoutButton.centerXAnchor, constant: 0).isActive = true
        deleteButton.topAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
    }
    
    // MARK: - Config segmented control & selector
    func segmentedControlConfig() {
        var segmentToShow = [String]()
        segmentItems = [.title, .author]
        if book.publisher != "" || book.publisher == nil {
            segmentItems.append(.publisher)
        }
        if book.categories != "" {
            segmentItems.append(.tags)
        }
        if book.lastCheckedOut != "" || book.lastCheckedOut == nil {
            segmentItems.append(.other)
        }
        for item in segmentItems {
            segmentToShow.append(item.convertToString())
        }
        segmentedControl = UISegmentedControl(items: segmentToShow)
        segmentedControl.setTitleTextAttributes([NSForegroundColorAttributeName : UIColor.themeTan, NSFontAttributeName: UIFont(name: "HelveticaNeue-Bold", size: 11.0)!], for: .normal)
        segmentedControl.tintColor = UIColor.themeOrange
    }
    
    func segmentedControlSegues(sender: UISegmentedControl!) {
        let selectedItem = segmentItems[sender.selectedSegmentIndex]
        switch selectedItem {
        case .title:
            hideAllLabels()
            animateTransition()
            detailView.titleLabel.text = book.title
            detailView.titleLabel.isHidden = false
        case .author:
            hideAllLabels()
            animateTransition()
            detailView.authorLabel.isHidden = false
            detailView.authorLabel.text = book.author
        case .publisher:
            hideAllLabels()
            animateTransition()
            detailView.publisherLabel.isHidden = false
            detailView.publisherLabel.text = book.publisher
        case .tags:
            hideAllLabels()
            animateTransition()
            detailView.tagsLabel.isHidden = false
            detailView.tagsLabel.text = detailView.formatCategories(of: book.categories)
        case .other:
            hideAllLabels()
            animateTransition()
            detailView.lastCheckedOutLabel.isHidden = false
            detailView.lastCheckedOutLabel.text = "Last checked out by \(book.lastCheckedOutBy!) on \(detailView.formatLastCheckedOut(book.lastCheckedOut))"
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
        alert.addTextField { (textField) in
            textField.autocapitalizationType = .words }
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { (_) in
            let nameTextField = alert.textFields![0]
            guard let unwrappedName = nameTextField.text else { print("Error unwrapping name"); return }
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
            let dateString = dateFormatter.string(from: currentDate)
            print(dateString)
            BookAPICalls.server(update: self.book.id, lastCheckedOutBy: unwrappedName, lastCheckedOut: dateString, completion: { (success) in
                if success {
                    OperationQueue.main.addOperation {
                        let booksTableViewController: BooksTableViewController = BooksTableViewController()
                        self.navigationController?.pushViewController(booksTableViewController, animated: true)
                    }
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delete button selector 
    func deletePressed() {
        let alertController = UIAlertController(title: "Are you sure?", message: "Please comfirm you would like to delete this book.", preferredStyle: UIAlertControllerStyle.alert)
        let YesAction = UIAlertAction(title: "Yes", style: .default) {(action: UIAlertAction) in
            BookAPICalls.deleteBookFromServer(with: self.book.id, completion: { (success) in
                if success {
                    OperationQueue.main.addOperation {
                        let booksTableViewController: BooksTableViewController = BooksTableViewController()
                        self.navigationController?.pushViewController(booksTableViewController, animated: true)
                    }
                }
            })
        }
        let CancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        alertController.addAction(YesAction)
        alertController.addAction(CancelAction)
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Drop down funcs when clicked
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
        }
    }
    
    func facebookShare() {
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: "http://www.SWAG4PI.com")
        content.contentTitle = "\(book.title)"
        content.contentDescription = "By: \(book.author)"
        FBSDKShareDialog.show(from: self, with: content, delegate: self)
    }
    
    func twitterShare() {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        guard let unwrappedVC = vc else { print("Error unwrapping twitterShare details in DVC"); return }
        unwrappedVC.setInitialText("Share your thoughts on \(book.title) here.")
        unwrappedVC.add(URL(string: "http://www.SWAG4PI.com"))
        present(unwrappedVC, animated: true, completion: nil)
    }
    
    func cancelShare() {
        backgroundView.removeFromSuperview()
        shareDropDownView.isHidden = true
        clickToShare = false
        self.shareClickedConstraint?.isActive = false
        self.shareRemovedConstraint?.isActive = false
    }
}

// MARK: - Handle FBSDKSharingDelegate protocol
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
