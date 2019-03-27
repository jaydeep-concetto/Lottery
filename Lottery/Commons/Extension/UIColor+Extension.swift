//
//  UIColor+Extension.swift
//  Appetite24
//
//  Created by Pragnesh Dixit on 20/07/17.
//  Copyright © 2017 Tristate Technology. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    //MARK:- Cell Back Ground Color
    static let cellBackground = UIColor (red: 241/255, green: 241/255, blue: 241/255, alpha: 1)
    
    static let fontColorText = UIColor (red: 230/255, green: 111/255, blue: 43/255, alpha: 1)

    
    //MARK:- Shoping Cart Badge
    
    
    static let badgeColorWhite =  UIColor(red:0.00, green:0.00, blue:0.00, alpha:0.25)
    //MARK:- Database Name:
    static let dbName:String = "PhoneCodes_old.rdb"
    //MARK:- Button Or NavigationBar Color
    
    
    static let btnColor:UIColor = UIColor(hex: "F04D58")
    //UIColor(hex: "38896B") //park tarven
    //UIColor(red:0.94, green:0.30, blue:0.35, alpha:1.0) regular color
    static let badgeColorRed = UIColor(hex: "F04D58")
    //UIColor(hex: "38896B")
    //UIColor(red:0.90, green:0.25, blue:0.33, alpha:1.0)
    static let headerBackground = UIColor(hex: "F04D58")
    //UIColor(hex: "38896B")
    //UIColor(hex: "F04D58")  //38896B
    
    static let textColor = UIColor(hex: "F04D58")
    //UIColor(hex: "38896B")
    
    convenience init(hex: String) {
        self.init(hex: hex, alpha:1)
    }
    
    /// Convenience initalizer for hex strings
    ///
    /// - Parameters:
    ///   - hex: hex value
    ///   - alpha: alpha value
    convenience init(hex: String, alpha: CGFloat) {
        var hexWithoutSymbol = hex
        if hexWithoutSymbol.hasPrefix("#") {
            hexWithoutSymbol = hex.substringFrom(1)
        }
        
        let scanner = Scanner(string: hexWithoutSymbol)
        var hexInt: UInt32 = 0x0
        scanner.scanHexInt32(&hexInt)
        
        var r: UInt32!, g: UInt32!, b: UInt32!
        switch (hexWithoutSymbol.length) {
        case 3: // #RGB
            r = ((hexInt >> 4) & 0xf0 | (hexInt >> 8) & 0x0f)
            g = ((hexInt >> 0) & 0xf0 | (hexInt >> 4) & 0x0f)
            b = ((hexInt << 4) & 0xf0 | hexInt & 0x0f)
            break
        case 6: // #RRGGBB
            r = (hexInt >> 16) & 0xff
            g = (hexInt >> 8) & 0xff
            b = hexInt & 0xff
            break
        default:
            // TODO:ERROR
            break
        }
        
        self.init(
            red: (CGFloat(r)/255),
            green: (CGFloat(g)/255),
            blue: (CGFloat(b)/255),
            alpha:alpha)
    }
    
}
