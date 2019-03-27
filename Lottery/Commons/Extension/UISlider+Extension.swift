//
//  UISlider+Extension.swift
//  NowConfer
//
//  Created by Tristate on 09/05/18.
//  Copyright © 2018 Tristate. All rights reserved.
//

import Foundation
import UIKit

class CustomUISlider : UISlider {
    @IBInspectable var trackHeight: CGFloat = 2

    override func trackRect(forBounds bounds: CGRect) -> CGRect {

        //keeps original origin and width, changes height, you get the idea
        let customBounds = CGRect(x: bounds.origin.x, y: (bounds.size.height-trackHeight)/2, width: bounds.size.width, height: trackHeight)
        
        super.trackRect(forBounds: customBounds)
        return customBounds
    }
    
    //while we are here, why not change the image here as well? (bonus material)
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
}
