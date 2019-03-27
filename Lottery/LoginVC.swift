//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit

class LoginVC: BaseViewController {

    @IBOutlet weak var btnShare: UIButton!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var btnRemember: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
@IBAction func btnRememberClicked(_ sender: UIButton) {
    btnRemember.isSelected = !btnRemember.isSelected

    }
    @IBAction func btnShareClicked(_ sender: UIButton) {
        btnShare.isSelected = !btnShare.isSelected

    }
    @IBAction func btnLoginClicked(_ sender: UIButton) {
        if !isValidEmail(testStr: txtEmail.text!)
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Please enter valid email.")
        }
        else if (txtPassword.text?.length)! < 6
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Password must be 6 character.")
        }
        else
        {
        postapi(url: URL_NAME.login, maindict:["email":txtEmail.text!,"password":txtPassword.text!]) { (dict) in
            if dict.count != 0
            {
                users.inits(dict: dict["data"] as! Dictionary<String, Any>)
                if self.btnRemember.isSelected
                {
                UserDefaults.standard.set(dict["data"], forKey: "userInfo")
                }
                else
                {
                    UserDefaults.standard.removeObject(forKey: "userInfo")
                }
                        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
                        self.navigationController?.pushViewController(secondVC, animated: true)
            }
        }
        }
    }
}
