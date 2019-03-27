//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore
import GoogleSignIn
class SignupVC: BaseViewController,GIDSignInDelegate,GIDSignInUIDelegate {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func btnFacebookClicked(_ sender: UIButton) {
        getFacebookUserInfo()
    }
    @IBAction func btnGoogleClicked(_ sender: UIButton) {
        GIDSignIn.sharedInstance().delegate=self
        GIDSignIn.sharedInstance().uiDelegate=self
        GIDSignIn.sharedInstance().signIn()
    }
    @IBAction func btnOtherClicked(_ sender: UIButton) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "SignupOtherVC") as! SignupOtherVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    @IBAction func btnTermsClicked(_ sender: UIButton) {
        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "LegalMatterVC") as! LegalMatterVC
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    func getFacebookUserInfo(){
        let loginManager = LoginManager()
        loginManager.logIn(readPermissions: [.publicProfile], viewController: self)  { (result) in
            switch result{
            case .cancelled:
                print("Cancel button click")
            case .success:
                let params = ["fields" : "id, name, first_name, last_name, picture.type(large), email "]
                let graphRequest = FBSDKGraphRequest.init(graphPath: "/me", parameters: params)
                let Connection = FBSDKGraphRequestConnection()
                Connection.add(graphRequest) { (Connection, result, error) in
                    if error == nil
                    {
                    let info = result as! [String : AnyObject]
                        self.socialSignup(param: ["fb_profile_id":info["id"]!])
                    }
                }
                Connection.start()
            default:
                print("??")
            }
        }
    }
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if (error == nil) {
            self.socialSignup(param: ["google_profile_id":user.userID])
        } else {
            print("google error")
        }
    }
    func sign(_ signIn: GIDSignIn!,
              present viewController: UIViewController!) {
        self.present(viewController, animated: true, completion: nil)
    }
    func sign(_ signIn: GIDSignIn!,
              dismiss viewController: UIViewController!) {
        self.dismiss(animated: true, completion: nil)
    }
    func socialSignup(param:[String:Any])  {
        
        postapi(url: URL_NAME.loginWithSocialMedia, maindict:param) { (dict) in
            if dict.count != 0
            {
                users.inits(dict: dict["data"] as! Dictionary<String, Any>)
                
                UserDefaults.standard.set(dict["data"], forKey: "userInfo")
                
                let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "MainTabVC") as! MainTabVC
                self.navigationController?.pushViewController(secondVC, animated: true)
            }
        }
    }
}
