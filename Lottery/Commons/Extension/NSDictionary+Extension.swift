//
//  NSDictionary+Extension.swift
//  
//
//  Created by Tristate Technology on 17/07/17.
//  Copyright © 2017 Tristate Technology. All rights reserved.
//

import UIKit

extension NSDictionary{

    //null to Blank
    @objc func dictionaryByReplacingNullsWithBlanks() -> [String : Any] {
        var replaced :  [String: Any] = (self as? [String : Any])!
        let nul : AnyObject = NSNull()
        let blank = ""
    
        for (key,value) in self {
            
            if  value as AnyObject? === nul {
                replaced[key as! String] =  blank
            }
            else if value is String {
                replaced[key as! String]  =  value as! String
            }else if value is Int {
                replaced[key as! String]  = "\(value as! Int)"// value as! String
            }else if value is Float {
                replaced[key as! String]  =  "\(value as! Float)"//  value as! String
            }
            else if value is NSNumber {
                replaced[key as! String]  =  String(describing: value as! NSNumber)
            }
            else if value is [String : AnyObject] {
                replaced[key as! String] = (value as AnyObject).dictionaryByReplacingNullsWithBlanks()
            }
            else if value is [AnyObject] {
                replaced[key as! String] = (value as! NSArray).arrayByReplacingNullsWithBlanks()
            }
            
        }
        return replaced as [String : Any]
    }
    
}

extension Dictionary {
    
    func dictionaryByReplacingNullsWithBlanks() -> [String : Any] {
        
        var replaced :  [String: Any] = (self as? [String : Any])!
        let nul : AnyObject = NSNull()
        let blank = ""
  
        for (key,value) in self {
            
            if  value as AnyObject? === nul {
                replaced[key as! String] =  blank
            }
            else if value is String {
                replaced[key as! String]  =  value as! String
            }else if value is Int {
                replaced[key as! String]  = "\(value as! Int)"// value as! String
            }else if value is Float {
                replaced[key as! String]  =  "\(value as! Float)"//  value as! String
            }
            else if value is NSNumber {
                replaced[key as! String]  =  String(describing: value as! NSNumber)
            }
            else if value is [String : AnyObject] {
                replaced[key as! String] = (value as AnyObject).dictionaryByReplacingNullsWithBlanks()
            }
            else if value is [AnyObject] {
                replaced[key as! String] = (value as! NSArray).arrayByReplacingNullsWithBlanks()
            }
        }
        return replaced as [String : Any]
    }
}
