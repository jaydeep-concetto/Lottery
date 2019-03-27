//
//  PaidMemberVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/6/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class NSAttributedStringHelper {
    static func createBulletedList(fromStringArray strings: [String]) -> NSAttributedString {
        
        let fullAttributedString = NSMutableAttributedString()
        let attributesDictionary: [NSAttributedString.Key: Any]
        
      
        attributesDictionary = [NSAttributedString.Key: Any]()
       
        
        for index in 0..<strings.count {
            let bulletPoint: String = "\u{2022}"
            var formattedString: String = "\(bulletPoint) \(strings[index])"
            
            if index < strings.count - 1 {
                formattedString = "\(formattedString)\n"
            }
            
            let attributedString: NSMutableAttributedString = NSMutableAttributedString(string: formattedString, attributes: attributesDictionary)
            let paragraphStyle = NSAttributedStringHelper.createParagraphAttribute()
            attributedString.addAttributes([NSAttributedString.Key.paragraphStyle: paragraphStyle], range: NSMakeRange(0, attributedString.length))
            fullAttributedString.append(attributedString)
        }
        
        return fullAttributedString
    }
    
    private static func createParagraphAttribute() -> NSParagraphStyle {
        let paragraphStyle: NSMutableParagraphStyle = NSParagraphStyle.default.mutableCopy() as! NSMutableParagraphStyle
        paragraphStyle.tabStops = [NSTextTab(textAlignment: .left, location: 15, options: NSDictionary() as! [NSTextTab.OptionKey : Any])]
        paragraphStyle.defaultTabInterval = 15
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = 8
        return paragraphStyle
    }
}
class PaidMemberVC: BaseViewController {

    @IBOutlet var viewGreen: UIView!{
        didSet{
            viewGreen.layer.cornerRadius = 15.0
        }
    }
    @IBOutlet var viewOrange: UIView!{
        didSet{
            viewOrange.layer.cornerRadius = 15.0
        }
    }
    @IBOutlet var lblValue1: UILabel!
    @IBOutlet var lblValue2: UILabel!
    @IBOutlet var lblGuid1: UILabel!
    @IBOutlet var lblGuid2: UILabel!
    @IBOutlet var lblDays: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()

        lblGuid1.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: ["Activate all features","100 CHIP per day","Special event available","You can get one more lucky number"])
        lblGuid2.attributedText = NSAttributedStringHelper.createBulletedList(fromStringArray: ["Activate all features","100 CHIP per day","Special event available","You can get one more lucky number","It will be full refund, when your club won."])
       
        
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBackClick(_ sender: UIButton){
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnChargeClick(_ sender: Any) {
    }
}
