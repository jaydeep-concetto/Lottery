//
//  WinningRewardTwoVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/9/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

extension String {
    func attributedStringWithColor(_ strings: [String], color: UIColor, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttribute(NSAttributedString.Key.foregroundColor, value: color, range: range)
            let underLineStyle = NSUnderlineStyle.single.rawValue
           
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: underLineStyle, range: range)
        }
        
        guard let characterSpacing = characterSpacing else {return attributedString}
        
        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))
        
        return attributedString
    }
}
class WinningRewardPopupTwoVC: BaseViewController {
    var nav:UINavigationController = UINavigationController()
    @IBAction func btnTrackClicked(_ sender: UIButton) {
//       self.dismiss(animated: true) {
//        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrackYourMoneyVC") as! TrackYourMoneyVC
//        self.nav.pushViewController(vc, animated: true)
//        }
    }
    @IBOutlet weak var lblAgreeToTerms: UILabel!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        let attributedWithTextColor: NSAttributedString = "        Congratulations.\nMar. 7. 2018 Powerball Winning Results\n– you have\n1 th winner in your club(KB7465)\n\nWe will call you in 48hours.\nAnd we provide you a tracking system\nfor your money".attributedStringWithColor(["tracking system"], color: UIColor.init(hex: "f66100"))
        
        lblAgreeToTerms.attributedText = attributedWithTextColor
      
    }
    @IBAction func btnHelpClicked(_ sender: UIButton) {
    }
   
}
