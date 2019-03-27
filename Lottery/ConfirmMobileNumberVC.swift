//
//  ConfirmMobileNumberVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/3/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ConfirmMobileNumberVC: BaseViewController {

    @IBOutlet var lblPlease: UILabel!
    @IBOutlet var txtCode: UITextField!
    var countryCode:String = ""
    var phoneNumber:String = ""
    var btnCheck:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()

        lblPlease.text = "Please enter the 4-digit code send to\n+\(countryCode) \(phoneNumber)"
       // +1 222-222-2222 
    }
    

   
    @IBAction func btnContinueClick(_ sender: Any) {
        postapi(url: URL_NAME.verify_otp, maindict:["user_id":users.id,"otp":txtCode.text!]) { (dict) in
            if dict.count != 0
            {
                let alertWarning = UIAlertController(title: Constant_String.APP_NAME, message: (dict["message"] as! String), preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                    for controller in self.navigationController!.viewControllers as Array {
                        if controller.isKind(of: ContactInfoVC.self) {
                            _ =  self.navigationController!.popToViewController(controller, animated: true)
                            break
                        }
                    }
                })
                    alertWarning.addAction(defaultAction)
                    self.present(alertWarning, animated: true, completion: nil)
            }
        }
       
    }
    @IBAction func btnResendClick(_ sender: Any) {
        postapi(url: URL_NAME.update_phone, maindict:["phone":"\(countryCode)\(phoneNumber)","user_id":users.id,"text_message":btnCheck]) { (dict) in
            if dict.count != 0
            {
               
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
