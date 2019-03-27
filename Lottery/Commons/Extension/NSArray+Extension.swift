//
//  NSArray+Extension.swift
//  
//
//  Created by Tristate Technology on 17/07/17.
//  Copyright © 2017 Tristate Technology. All rights reserved.
//

import UIKit

extension NSArray {

    //change null to Blank
    @objc func arrayByReplacingNullsWithBlanks() -> [AnyObject] {
        var replaced :  [AnyObject] = (self as [AnyObject])
        let nul : AnyObject = NSNull()
        let blank = ""
  
        for index in 0..<replaced.count {
            let object = replaced[index] as AnyObject
            
            if  object === nul {
                replaced[index] =  blank as AnyObject
            }
            else if object is String {
                replaced[index]  =  object as AnyObject
            }else if object is Int {
                replaced[index]  = "\(object as! Int)" as AnyObject// object as! String
            }else if object is Float {
                replaced[index]  =  "\(object as! Float)" as AnyObject//  object as! String
            }
            else if object is NSNumber {
                replaced[index]  =  String(describing: object as! NSNumber) as AnyObject
            }
            else if object is [String : AnyObject] {
                replaced[index] = (object as! NSDictionary).dictionaryByReplacingNullsWithBlanks() as AnyObject
            }
            else if object is [AnyObject] {
                replaced[index] = (object as AnyObject).arrayByReplacingNullsWithBlanks as AnyObject
            }
        }
        return replaced as [AnyObject]
    }

}
