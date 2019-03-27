//
//  UIView+Extension.swift
//  
//
//  Created by Pragnesh Dixit on 28/07/17.
//  Copyright © 2017 Tristate Technology. All rights reserved.
//

import Foundation
import UIKit

class BaseViewValue:UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
//        self.backgroundColor = UIColor(hex: "F04D58")
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}

extension UIView {
        var parentViewController: UIViewController? {
            var parentResponder: UIResponder? = self
            while parentResponder != nil {
                parentResponder = parentResponder!.next
                if let viewController = parentResponder as? UIViewController {
                    return viewController
                }
            }
            return nil
        }
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        path.lineWidth = 1.0
        path.stroke()
        
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        
        let borderLayer = CAShapeLayer()
        borderLayer.path = mask.path // Reuse the Bezier path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = UIColor.black.cgColor
        borderLayer.lineWidth = 1
        borderLayer.frame = self.bounds
        layer.addSublayer(borderLayer)
    }
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) -> Void {
        let gradient: CAGradientLayer = CAGradientLayer()
        self.layoutIfNeeded()
        self.layoutSubviews()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradient.endPoint = CGPoint(x: 1.0, y: 0.5)
        gradient.locations = locations
        self.layer.addSublayer(gradient)
    }
    
    func dottedBorder(_ color:String) {
        for layer in self.layer.sublayers! {
            if(layer is CAShapeLayer) {
                print("layout remove from layer")
                layer.removeFromSuperlayer()
            }
        }
        
        self.updateConstraints()
        
        self.layer.layoutSublayers()
        self.layer.layoutIfNeeded()
        self.layoutSubviews()
        self.layoutIfNeeded()
        self.setNeedsLayout()
        let yourViewBorder = CAShapeLayer()
        
        yourViewBorder.strokeColor = UIColor(hex: color).cgColor
        yourViewBorder.lineDashPattern = [1, 1]
        yourViewBorder.frame = self.bounds
        yourViewBorder.fillColor = nil
        let beziarPath = UIBezierPath(roundedRect: self.bounds, cornerRadius: 5)
        print("=== frame  \(self.bounds)")
        yourViewBorder.path = beziarPath.cgPath
        
        self.layer.addSublayer(yourViewBorder)
        self.updateConstraints()
        self.layer.layoutSublayers()
        self.layer.layoutIfNeeded()
        self.layoutSubviews()
        self.layoutIfNeeded()
        self.setNeedsLayout()
    }
    
    /*@IBInspectable
    var backColor : UIColor? {
        get {
            if let color = self.backgroundColor,color == UIColor.clear {
                return nil
            }else{
                return UIColor.headerBackground
            }
        }
        set {
            backgroundColor =  UIColor.headerBackground
        }
    }*/
    @IBInspectable
    var width_cornerRadius: Bool {
        get {
            return false
        }
        set {
            layer.cornerRadius = newValue ? self.frame.size.width/2 : 0
        }
    }
    @IBInspectable
    var height_cornerRadius: Bool {
        get {
            return false
        }
        set {
            layer.cornerRadius = newValue ? self.frame.height/2 : 0
        }
    }
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColorSet: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        set {
            layer.shadowOffset = newValue
        }
    }
    
    func dropShadow(_ color:UIColor ,_ cornerRadius : CGFloat) {
        self.layoutIfNeeded()
        self.layoutSubviews()
        layer.masksToBounds = false
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.16
        layer.shadowOffset = CGSize(width: 1, height: 1.5)
        layer.cornerRadius = cornerRadius
        layer.shadowRadius = 2.0
    }
    
    func setBottomViewCorner(view :UIView, radius:CGFloat) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = view.frame
        rectShape.position = view.center
        rectShape.path = UIBezierPath(roundedRect: view.bounds,    byRoundingCorners: [.bottomLeft , .bottomRight], cornerRadii: CGSize(width: 20, height: 20)).cgPath
        view.layer.backgroundColor = UIColor.green.cgColor
        view.layer.mask = rectShape
    }
    
    func setRoundView(){
        self.layer.cornerRadius = self.layer.frame.size.width/2
        self.layer.masksToBounds = true
    }
    
    func createGradientLayer(startcolor:UIColor, endcolor:UIColor) {
        var  gradientLayer: CAGradientLayer!
        self.layoutIfNeeded()
        self.layoutSubviews()
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.bounds
        gradientLayer.colors = [startcolor, endcolor]
        gradientLayer.locations = [CGPoint(x: 0.0, y: 0.5) as! NSNumber,CGPoint(x: 1.0, y: 0.5) as! NSNumber]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setView(hidden: Bool) {
        UIView.transition(with: self, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.isHidden = hidden
        })
    }

}
