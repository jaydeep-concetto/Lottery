//
//  ChangeEmailVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/3/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ChangeEmailVC: BaseViewController {

    @IBOutlet weak var lblCurrentEmail: UILabel!
    @IBOutlet var txtEmail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        lblCurrentEmail.text = users.email
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnSaveClick(_ sender: UIButton) {
        if !isValidEmail(testStr: txtEmail.text!)
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Please enter valid email.")
        }
        else
        {
            postapi(url: URL_NAME.update_email, maindict:["email":txtEmail.text!,"user_id":users.id]) { (dict) in
                if dict.count != 0
                {
                    let alertWarning = UIAlertController(title: Constant_String.APP_NAME, message: (dict["message"] as! String), preferredStyle: .alert)
                  
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                        if UserDefaults.standard.value(forKey: "userInfo") != nil
                        {
                            var tempDict1 = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
                            var tempDict = tempDict1["user"] as! Dictionary<String, String>
                            
                            tempDict["email"] = self.txtEmail.text!
                            tempDict1["user"] = tempDict
                            UserDefaults.standard.set(tempDict1, forKey: "userInfo")
                        }
                        users.email = self.txtEmail.text!
                        
                        self.backButtonAction(sender: sender)
                    })
                    alertWarning.addAction(defaultAction)
                    self.present(alertWarning, animated: true, completion: nil)
                }
            }
        }
        
    }
    
}
