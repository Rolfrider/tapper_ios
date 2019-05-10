//
//  Color.swift
//  Tapper
//
//  Created by Rafał Kwiatkowski on 07/05/2019.
//  Copyright © 2019 Rafał Kwiatkowski. All rights reserved.
//

import UIKit


enum Color {
    case primary
    case darkPrimary
    case accent
    case secondary
}

extension Color{
    var value: UIColor {
        var instanceColor = UIColor.clear
        
        switch self {
        case .primary:
            instanceColor = UIColor(hexString: "#0ad560")
        case .darkPrimary:
            instanceColor = UIColor(hexString: "#05af4d")
        case .accent:
            instanceColor = UIColor(hexString: "#BDBDBD")
        case .secondary:
            instanceColor = UIColor(hexString: "#333333")
        }
        
        return instanceColor
    }
    
}

extension UIColor {
    /**
     Creates an UIColor from HEX String in "#363636" format
     
     - parameter hexString: HEX String i    n "#363636" format
     - returns: UIColor from HexString
     */
    convenience init(hexString: String) {
        
        let hexString: String = (hexString as NSString).trimmingCharacters(in: .whitespacesAndNewlines)
        let scanner          = Scanner(string: hexString as String)
        
        if hexString.hasPrefix("#") {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:1)
    }
}
