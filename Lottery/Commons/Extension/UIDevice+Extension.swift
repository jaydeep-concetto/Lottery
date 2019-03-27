//
//  UIDevice+Extension.swift
//  
//
//  Created by TriState on 2/5/17.
//  Copyright © 2017 Tristate Technology. All rights reserved.
//

import UIKit

/// <#Description#>
extension UIDevice {

    /// <#Description#>
    enum DeviceType {
        case iPhone35
        case iPhone40
        case iPhone47
        case iPhone55
        case iPad
        case TV

        var isPhone: Bool {
            return [ .iPhone35, .iPhone40, .iPhone47, .iPhone55 ].contains(self)
        }
    }

    /// <#Description#>
    
    var deviceType: DeviceType? {
        switch UIDevice.current.userInterfaceIdiom {
        case .tv:
            return .TV

        case .pad:
            return .iPad

        case .phone:
            let screenSize = UIScreen.main.bounds.size
            let height = max(screenSize.width, screenSize.height)

            switch height {
            case 480:
                return .iPhone35 //4
            case 568:
                return .iPhone40 //5
            case 667:
                return .iPhone47 //6
            case 736:
                return .iPhone55 //6+
            default:
                return nil
            }

        case .unspecified:
            return nil
        default:
            return nil
        }
    }
}
