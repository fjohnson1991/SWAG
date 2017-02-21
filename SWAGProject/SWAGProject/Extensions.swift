//
//  Extensions.swift
//  SWAGProject
//
//  Created by Felicity Johnson on 2/20/17.
//  Copyright © 2017 FJ. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    static let themeBlue = UIColor(red: 45 / 255, green: 105 / 255, blue: 163 / 255, alpha: 1)
    static let themeDarkBlue = UIColor(red: 2 / 255, green: 0 / 255, blue: 129 / 255, alpha: 1)
    static let themeGreen = UIColor(red: 1 / 255, green: 167 / 255, blue: 99 / 255, alpha: 1)
    static let themeYellow = UIColor(red: 255 / 255, green: 214 / 255, blue: 1 / 255, alpha: 1)
}

extension UIFont {
    static let themeTinyBold = UIFont(name: "HelveticaNeue-Bold", size: 11)
    static let themeSmallBold = UIFont(name: "HelveticaNeue-Bold", size: 15)
    static let themeMediumBold = UIFont(name: "HelveticaNeue-Bold", size: 24)
    static let themeLargeBold = UIFont(name: "HelveticaNeue-Bold", size: 32)
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}
