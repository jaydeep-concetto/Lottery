//
//  FacebookVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/5/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
import FacebookLogin
import FBSDKLoginKit
import FacebookCore
class FacebookVC: BaseViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnFacebookClick(_ sender: Any) {
        getFacebookUserInfo()
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
                        self.socialSignup(param: ["fb_profile_id":info["id"]!,"user_id":users.id])
                    }
                }
                Connection.start()
            default:
                print("??")
            }
        }
    }

    func socialSignup(param:[String:Any])  {
        
        postapi(url: URL_NAME.socialAccountMap, maindict:param) { (dict) in
            if dict.count != 0
            {
                let alertWarning = UIAlertController(title: Constant_String.APP_NAME, message: (dict["message"] as! String), preferredStyle: .alert)

                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                    if UserDefaults.standard.value(forKey: "userInfo") != nil
                    {
                        var tempDict1 = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
                        var tempDict = tempDict1["user"] as! Dictionary<String, String>

                        tempDict["fb_profile_id"] = param["fb_profile_id"] as? String ?? ""
                        tempDict1["user"] = tempDict
                        UserDefaults.standard.set(tempDict1, forKey: "userInfo")
                    }
                    users.fb_profile_id = param["fb_profile_id"] as? String ?? ""
                    
                    self.backButtonAction(sender: UIButton())
                })
                alertWarning.addAction(defaultAction)
                self.present(alertWarning, animated: true, completion: nil)
            }
        }
    }
}
