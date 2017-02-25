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
    
    let dataStore = BookDataStore.sharedInstance
    var detailView: DetailView!
    var segmentedControl: UISegmentedControl!
    var segmentItems: [SegmentItems]!
    var book: Book!
    var checkoutButton: UIButton!
    var deleteButton: UIButton!
    var updateButton: UIButton!
    var shareDropDownView: ShareDropDownView!
    var backgroundView: UIView!
    var shareClickedConstraint: NSLayoutConstraint!
    var shareRemovedConstraint: NSLayoutConstraint!
    var clickToShare = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureLayout()
        setupViewConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        segmentedControl.selectedSegmentIndex = 0
        detailView.titleLabel.text = book.title
        detailView.titleLabel.isHidden = false
    }
    
    func configureLayout() {
        // VC
        view.backgroundColor = UIColor.white
        title = "Detail"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ShareButton"), style: .done, target: self, action: #selector(shareDropdown))
        navigationItem.rightBarButtonItem?.setTitleTextAttributes([NSFontAttributeName: UIFont.systemFont(ofSize: 12, weight: UIFontWeightSemibold), NSForegroundColorAttributeName: UIColor.white],for: UIControlState.normal)
        
        // Segmented control
        segmentedControlConfig()
        
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
        
        // Update button
        updateButton = UIButton()
        updateButton.setTitle("Update", for: .normal)
        updateButton.titleLabel?.font = UIFont.themeSmallBold
        updateButton.setTitleColor(UIColor.themeOffWhite, for: .normal)
        updateButton.layer.cornerRadius = 5.0
        updateButton.layer.backgroundColor = UIColor.themeOrange.cgColor
        updateButton.addTarget(self, action: #selector(updatePressed), for: .touchUpInside)
        
        // Share drop down
        shareDropDownView = ShareDropDownView()
        shareDropDownView.isHidden = true
        shareDropDownView.delegate = self
    }
    
    func setupViewConstraints() {
        // Detail view
        detailView = DetailView()
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        detailView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.5).isActive = true
        detailView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        detailView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        detailView.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0).isActive = true
        
        // Segmented controller
        segmentedControl.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(segmentedControl)
        segmentedControl.heightAnchor.constraint(equalToConstant: 17).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
        segmentedControl.topAnchor.constraint(equalTo: detailView.bottomAnchor, constant: 8).isActive = true
        segmentedControl.addTarget(self, action: #selector(segmentedControlSegues), for: .valueChanged)
        
        // Checkout button
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(checkoutButton)
        checkoutButton.centerXAnchor.constraint(equalTo: segmentedControl.centerXAnchor, constant: 0).isActive = true
        checkoutButton.topAnchor.constraint(equalTo: segmentedControl.bottomAnchor, constant: 10).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        checkoutButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        // Delete button
        deleteButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(deleteButton)
        deleteButton.centerXAnchor.constraint(equalTo: checkoutButton.centerXAnchor, constant: 0).isActive = true
        deleteButton.topAnchor.constraint(equalTo: checkoutButton.bottomAnchor, constant: 10).isActive = true
        deleteButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        deleteButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
        
        // Update button
        updateButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(updateButton)
        updateButton.centerXAnchor.constraint(equalTo: deleteButton.centerXAnchor, constant: 0).isActive = true
        updateButton.topAnchor.constraint(equalTo: deleteButton.bottomAnchor, constant: 10).isActive = true
        updateButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        updateButton.widthAnchor.constraint(equalToConstant: 150).isActive = true
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
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { [unowned alert] (_) in
            let nameTextField = alert.textFields![0]
            guard let unwrappedName = nameTextField.text else { print("Error unwrapping name"); return }
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss zzz"
            let dateString = dateFormatter.string(from: currentDate)
            var dictionary = [String: Any]()
            dictionary["lastCheckedOutBy"] = unwrappedName
            dictionary["lastCheckedOut"] = dateString
            self.dataStore.updateBookInfo(with: self.book.id, dictionary: dictionary, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        let booksTableViewController: BooksTableViewController = BooksTableViewController()
                        self.navigationController?.pushViewController(booksTableViewController, animated: true)
                    }
                } else {
                    self.presentAlertWithTitle(title: "Sorry!", message: "Checkout failed.")
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Delete button selector
    func deletePressed() {
        let yesAction = UIAlertAction(title: "Yes", style: .default) {(_) in
            self.dataStore.deleteOneBook(with: self.book.id, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        let booksTableViewController: BooksTableViewController = BooksTableViewController()
                        self.navigationController?.pushViewController(booksTableViewController, animated: true)
                    }
                } else {
                    self.presentAlertWithTitle(title: "Sorry!", message: "Delete failed.")
                }
            })
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        presentAlertWith(title: "Are you sure?", message: "Please comfirm you would like to delete this book.", okAction: yesAction, cancelAction: cancelAction)
    }
    
    // MARK: - Update button selector
    func updatePressed() {
        let alert = UIAlertController(title: "Update book?", message: "Please enter the book's updated information below.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField { (titleTextField) in
            titleTextField.autocapitalizationType = .words
            titleTextField.placeholder = "Update title here"
        }
        alert.addTextField { (authorTextField) in
            authorTextField.autocapitalizationType = .words
            authorTextField.placeholder = "Update author here"
        }
        alert.addTextField { (publisherTextField) in
            publisherTextField.autocapitalizationType = .words
            publisherTextField.placeholder = "Update publisher here"
        }
        alert.addTextField { (tagsTextField) in
            tagsTextField.autocapitalizationType = .words
            tagsTextField.placeholder = "Update tags here"
        }
        alert.addAction(UIAlertAction(title: "Submit", style: UIAlertActionStyle.default, handler: { [unowned alert] (_) in
            let titleTextField = alert.textFields![0]
            let authorTextField = alert.textFields![1]
            let publisherTextField = alert.textFields![2]
            let tagsTextField = alert.textFields![3]
            var dictionary = [String: Any]()
            if titleTextField.text != "" {
                guard let unwrappedTitle = titleTextField.text else { return }
                dictionary["title"] = unwrappedTitle
            }
            if authorTextField.text != "" {
                guard let unwrappedAuthor = authorTextField.text else { return }
                dictionary["author"] = unwrappedAuthor
            }
            if publisherTextField.text != "" {
                guard let unwrappedPublisher = publisherTextField.text else { return }
                dictionary["publisher"] = unwrappedPublisher
            }
            if tagsTextField.text != "" {
                guard let unwrappedTags = tagsTextField.text else { return }
                dictionary["categories"] = unwrappedTags
            }
            self.dataStore.updateBookInfo(with: self.book.id, dictionary: dictionary, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        let booksTableViewController: BooksTableViewController = BooksTableViewController()
                        self.navigationController?.pushViewController(booksTableViewController, animated: true)
                    }
                } else {
                    self.presentAlertWithTitle(title: "Sorry!", message: "Update failed.")
                }
            })
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Share drop down config & funcs
    func configDropDownView() {
        backgroundView = UIView()
        backgroundView.backgroundColor = UIColor.black.withAlphaComponent(0.8)
        backgroundView.frame = view.bounds
        view.addSubview(backgroundView)
        
        shareDropDownView.translatesAutoresizingMaskIntoConstraints = false
        backgroundView.addSubview(shareDropDownView)
        shareClickedConstraint = shareDropDownView.topAnchor.constraint(equalTo: backgroundView.topAnchor, constant: 0)
        shareClickedConstraint.isActive = true
        shareDropDownView.trailingAnchor.constraint(equalTo: backgroundView.trailingAnchor, constant: 0).isActive = true
        shareDropDownView.heightAnchor.constraint(equalToConstant: 300).isActive = true
        shareDropDownView.widthAnchor.constraint(equalToConstant: 100).isActive = true
    }
    
    func shareDropdown() {
        if clickToShare == false {
            configDropDownView()
            shareDropDownView.isHidden = false
            clickToShare = true
            shareClickedConstraint.isActive = false
            shareRemovedConstraint = shareDropDownView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0)
            shareRemovedConstraint?.isActive = true
        } else {
            backgroundView.removeFromSuperview()
            shareDropDownView.isHidden = true
            clickToShare = false
            shareClickedConstraint.isActive = false
            shareRemovedConstraint.isActive = false
        }
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

// MARK: - Handle ShareDropDownViewProtocol protocol
extension DetailViewController: ShareDropDownViewProtocol {
    func facebookWasClicked() {
        let content : FBSDKShareLinkContent = FBSDKShareLinkContent()
        content.contentURL = URL(string: "http://www.SWAG4PI.com")
        content.contentTitle = "\(book.title)"
        content.contentDescription = "By: \(book.author)"
        FBSDKShareDialog.show(from: self, with: content, delegate: self)
    }
    
    func twitterWasClicked() {
        let vc = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
        guard let unwrappedVC = vc else { print("Error unwrapping twitterShare details in DVC"); return }
        unwrappedVC.setInitialText("Share your thoughts on \(book.title) here.")
        unwrappedVC.add(URL(string: "http://www.SWAG4PI.com"))
        present(unwrappedVC, animated: true, completion: nil)
    }
    
    func cancelWasClicked() {
        backgroundView.removeFromSuperview()
        shareDropDownView.isHidden = true
        clickToShare = false
        shareClickedConstraint.isActive = false
        shareRemovedConstraint.isActive = false
    }
}
