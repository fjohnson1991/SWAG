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
    static let themeBlue = UIColor(red: 0 / 255, green: 23 / 255, blue: 35 / 255, alpha: 1)
    static let themeOrange = UIColor(red: 0 / 255, green: 139 / 255, blue: 102 / 255, alpha: 1)
    static let themeGreen = UIColor(red: 238 / 255, green: 158 / 255, blue: 6 / 255, alpha: 1)
    static let themeTan = UIColor(red: 217 / 255, green: 143 / 255, blue: 51 / 255, alpha: 1)
    static let themeOffWhite = UIColor(red: 241 / 255, green: 241 / 255, blue: 241 / 255, alpha: 1)
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
