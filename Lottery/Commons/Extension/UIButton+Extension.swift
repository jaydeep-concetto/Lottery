//
//  UIButton+Extension.swift
//  NowConfer
//
//  Created by Tristate on 24/04/18.
//  Copyright © 2018 Tristate. All rights reserved.
//

import UIKit

@IBDesignable final class AZHorizontalGradientView: UIView {
    
    @IBInspectable var leftColor: UIColor = UIColor.clear
    @IBInspectable var rightColor: UIColor = UIColor.clear
    
    override func draw(_ rect: CGRect) {
        
        let gradient = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = [leftColor.cgColor, rightColor.cgColor]
        gradient.startPoint = CGPoint(x: 0, y: 0)
        gradient.endPoint = CGPoint(x: 1, y: 0)
        self.layer.addSublayer(gradient)
        
        
    }
    
}
extension UIButton {
    
    func btnWithDoubleGradient(arrColor:Array<Any>,lineWidth: Float,startX:Double,startY:Double,endX:Double,endY:Double) {
        
        self.layer.cornerRadius = self.frame.size.height / 2
        let gradient1 = CAGradientLayer()
        gradient1.frame =  CGRect(origin: CGPoint(x: 0, y: 0), size: self.frame.size)
        gradient1.colors = arrColor
        gradient1.startPoint = CGPoint(x:startX, y:startY)
        gradient1.endPoint = CGPoint(x: endX, y: endY)
        /*let shape = CAShapeLayer()
        shape.lineWidth = CGFloat(lineWidth)//8
        shape.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.frame.size.height / 2).cgPath
        //shape.strokeColor = UIColor.black.cgColor
        //shape.fillColor = UIColor.clear.cgColor
        gradient1.mask = shape*/
        self.clipsToBounds = true
        self.layer.addSublayer(gradient1)
        
    }
    
}

class GradientButton: UIButton {
    let gradientLayer = CAGradientLayer()
    
    @IBInspectable
    var topGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    @IBInspectable
    var bottomGradientColor: UIColor? {
        didSet {
            setGradient(topGradientColor: topGradientColor, bottomGradientColor: bottomGradientColor)
        }
    }
    
    private func setGradient(topGradientColor: UIColor?, bottomGradientColor: UIColor?) {
        if let topGradientColor = topGradientColor, let bottomGradientColor = bottomGradientColor {
            gradientLayer.frame = bounds
            gradientLayer.colors = [topGradientColor.cgColor, bottomGradientColor.cgColor]
            gradientLayer.borderColor = layer.borderColor
            gradientLayer.borderWidth = layer.borderWidth
            gradientLayer.cornerRadius = layer.cornerRadius
            layer.insertSublayer(gradientLayer, at: 0)
        } else {
            gradientLayer.removeFromSuperlayer()
        }
    }
}

