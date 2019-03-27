//
//  ChangeMobileVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/3/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ChangeMobileVC: BaseViewController {

    @IBOutlet var txtPhoneNumber: UITextField!
    
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet var btnCheck: UIButton!
    var countryCode:String = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        btnCheck.isSelected = (users.text_message == "0") ? false : true
        do {
            if let file = Bundle.main.url(forResource: "country", withExtension: "json") {
                let data = try Data(contentsOf: file)
                let json = try JSONSerialization.jsonObject(with: data, options: []) as! [[String:Any]]
                
                txtCountry.text = (json.count == 0) ? "" : json[0]["name"] as? String ?? ""
                let tempStr = ((json.count == 0) ? "" : json[0]["name"] as? String ?? "").components(separatedBy: " +")
                
               countryCode = (tempStr.count == 2) ? tempStr[1] : ""
                txtCountry.loadDropdownDataFromDictionaryArray(data: json , keyForValue: "name", toolbarColor: UIColor.init(hex: "FD5D0F")) { (a) in
                    if a.count == 0
                    {
                        self.countryCode = ""
                    }
                    else
                    {
                        let tempStr = (a["name"] as? String ?? "").components(separatedBy: " +")
                        
                        self.countryCode = (tempStr.count == 2) ? tempStr[1] : ""
                    }
                }
            }
        } catch {
            print(error.localizedDescription)
        }
        // Do any additional setup after loading the view.
    }
    

    
   
    @IBAction func btnContinueClick(_ sender: Any) {
        if txtCountry.text! == ""
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Please select the country.")
        }
        else if !validatePhone(txtPhoneNumber.text!)
        {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Please enter the 10 digit number.")
        }
        else
        {
        postapi(url: URL_NAME.update_phone, maindict:["phone":"\(countryCode)\(txtPhoneNumber.text!)","user_id":users.id,"text_message":btnCheck.isSelected]) { (dict) in
            if dict.count != 0
            {
                if UserDefaults.standard.value(forKey: "userInfo") != nil
                {
                    var tempDict1 = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
                    var tempDict = tempDict1["user"] as! Dictionary<String, String>
                    
                    tempDict["phone"] = "\(self.countryCode)\(self.txtPhoneNumber.text!)"
                    tempDict["text_message"] = self.btnCheck.isSelected ? "1" : "0"
                    tempDict1["user"] = tempDict
                    
                    UserDefaults.standard.set(tempDict1, forKey: "userInfo")
                }
                users.phone = "\(self.countryCode)\(self.txtPhoneNumber.text!)"
                users.text_message = self.btnCheck.isSelected ? "1" : "0"
                let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ConfirmMobileNumberVC") as! ConfirmMobileNumberVC
                SecondVC.countryCode = self.countryCode
                SecondVC.phoneNumber = self.txtPhoneNumber.text!
                SecondVC.btnCheck = self.btnCheck.isSelected

                self.navigationController?.pushViewController(SecondVC, animated: true)
            }
        }
        }
    }
    @IBAction func btnEnableClick(_ sender: UIButton) {
        btnCheck.isSelected = !sender.isSelected
    
        
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
