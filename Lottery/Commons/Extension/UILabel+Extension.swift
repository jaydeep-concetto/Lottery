//
//  UILabel+Extension.swift
//  Restaurants
//
//  Created by Tristate on 03/04/18.
//  Copyright © 2018 Tristate. All rights reserved.
//

import UIKit

extension UILabel {
    @IBInspectable
    var textColour : UIColor? {
        get {
            if let color = self.textColor,color == UIColor.clear {
                return nil
            }else{
                return UIColor.textColor
            }
        }
        set {
            self.textColor =  UIColor.textColor
        }
    }
}

extension UIButton {
    
    
    @IBInspectable
    var textSelectedColour : UIColor? {
        
        get {
            if(self.isSelected) {
                if let color = self.titleLabel?.textColor,color == UIColor.clear {
                    return nil
                }else{
                    return UIColor.textColor
                }
            }else{
                return nil
            }
        }
        set {
            self.setTitleColor(UIColor.textColor, for: .selected)
        }
    }
    
    @IBInspectable
    var textColour : UIColor? {
        get {
            if let color = self.titleLabel?.textColor,color == UIColor.clear {
                return nil
            }else{
                return UIColor.textColor
            }
        }
        set {
            self.setTitleColor(UIColor.textColor, for: .normal)
            self.setTitleColor(UIColor.textColor, for: .selected)
        }
    }
    
}

extension UITextField {
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }
}


