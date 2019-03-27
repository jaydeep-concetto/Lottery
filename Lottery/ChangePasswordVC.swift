//
//  ChangePasswordVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/3/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ChangePasswordVC: BaseViewController {

    @IBOutlet var txtNewPassword: UITextField!
    @IBOutlet var txtConfirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func btnSaveClick(_ sender: UIButton) {
        if (txtNewPassword.text?.length)! < 6
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Password must be 6 character.")
        }
        else if txtNewPassword.text! != txtConfirmPassword.text!
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Password does not match.")
        }
        else
        {
            postapi(url: URL_NAME.update_password, maindict:["new_password":txtNewPassword.text!,"user_id":users.id]) { (dict) in
                if dict.count != 0
                {
                    let alertWarning = UIAlertController(title: Constant_String.APP_NAME, message: (dict["message"] as! String), preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                        
                        
                        self.backButtonAction(sender: sender)
                    })
                    alertWarning.addAction(defaultAction)
                    self.present(alertWarning, animated: true, completion: nil)
                }
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
