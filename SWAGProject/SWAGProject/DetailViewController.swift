//
//  DetailViewController.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    let detailView = DetailView()
    let shareDropDownView = ShareDropDownView()
    var passedBookID = Int()

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
        
//        shareDropDownView.shareDropDownStackView.isHidden = true
        shareDropDownView.facebookButton.addTarget(self, action: #selector(facebookShare), for: .touchUpInside)
        shareDropDownView.twitterButton.addTarget(self, action: #selector(twitterShare), for: .touchUpInside)
        
        // add delegate to call this instead of via target
        detailView.checkoutButton.addTarget(self, action: #selector(checkoutPressed), for: .touchUpInside)
    }
    
    func constrain() {
        detailView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(detailView)
        detailView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 10).isActive = true
        detailView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        detailView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: 0).isActive = true
        
        shareDropDownView.translatesAutoresizingMaskIntoConstraints = false
        self.detailView.addSubview(shareDropDownView)
        shareDropDownView.topAnchor.constraint(equalTo: self.detailView.topAnchor, constant: 10).isActive = true
        shareDropDownView.trailingAnchor.constraint(equalTo: self.detailView.trailingAnchor, constant: 0).isActive = true 
        shareDropDownView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        shareDropDownView.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
    
    func shareDropdown() {
        print("share button touched")
        UIView.animate(withDuration: 0.3) {
            self.shareDropDownView.shareDropDownStackView.isHidden = false
        }
    }
    
    func facebookShare() {
        
    }
    
    func twitterShare() {
        
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
