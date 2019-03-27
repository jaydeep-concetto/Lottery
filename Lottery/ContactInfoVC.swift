//
//  ContactInfoVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/2/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ContactInfoVC: BaseViewController {

  
    @IBOutlet weak var lblFacebook: UILabel!
    @IBOutlet weak var lblMobileVerified: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmailVerified: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        lblEmail.text = users.email
        lblMobile.text = users.phone
        lblEmailVerified.isHidden = (users.email_verified == "1") ? false : true
        lblMobileVerified.isHidden = (users.otp_verified == "1") ? false : true
        lblFacebook.text = (users.fb_profile_id == "") ? "Not connected" : "Connected"
    }
    
    
    
    @IBAction func btnEmailClick(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangeEmailVC") as! ChangeEmailVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    @IBAction func btnPasswordClick(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangePasswordVC") as! ChangePasswordVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    @IBAction func btnMobileClick(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ChangeMobileVC") as! ChangeMobileVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    @IBAction func btnWireInfoClick(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "WireInformationVC") as! WireInformationVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    @IBAction func txtFacebookClick(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "FacebookVC") as! FacebookVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    @IBAction func btnSignatureClick(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SignatureVC") as! SignatureVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    
}
