//
//  NotificationSettingVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/6/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class NotificationSettingVC: BaseViewController {

    @IBOutlet var btnMessageNotification: UIButton!
    @IBOutlet var btnMessage: UIButton!
    @IBOutlet var btnPushNotification: UIButton!
    @IBOutlet var btnPush: UIButton!
    @IBOutlet var btnEventAnnounce: UIButton!
    @IBOutlet var btnEvent: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        btnMessageNotification.isSelected = (users.text_message == "0") ? false : true
        btnMessage.isSelected = (users.text_message == "0") ? false : true
        btnPushNotification.isSelected = (users.push_notification == "0") ? false : true
        btnPush.isSelected = (users.push_notification == "0") ? false : true
        btnEventAnnounce.isSelected = (users.email_notification == "0") ? false : true
        btnEvent.isSelected = (users.email_notification == "0") ? false : true
        // Do any additional setup after loading the view.
    }
    @IBAction func btnBackClick(_ sender: Any){
        backgroundpostapi(url: URL_NAME.notification_setting, maindict: ["user_id":users.id,"text_message":btnMessageNotification.isSelected,"push_notification":btnPushNotification.isSelected,"email_notification":btnEventAnnounce.isSelected]){ (dict) in
            if dict.count != 0
            {
                if UserDefaults.standard.value(forKey: "userInfo") != nil
                {
                    var tempDict1 = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
                    var tempDict = tempDict1["user"] as! Dictionary<String, String>
                    
                    tempDict["text_message"] = self.btnMessageNotification.isSelected ? "1" : "0"
                    tempDict["push_notification"] = self.btnPushNotification.isSelected ? "1" : "0"
                    tempDict["email_notification"] = self.btnEventAnnounce.isSelected ? "1" : "0"
                    tempDict1["user"] = tempDict
                    UserDefaults.standard.set(tempDict1, forKey: "userInfo")
                }
                users.text_message = self.btnMessageNotification.isSelected ? "1" : "0"
                users.push_notification = self.btnPushNotification.isSelected ? "1" : "0"
                users.email_notification = self.btnEventAnnounce.isSelected ? "1" : "0"
            }
        }
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnMessageNotificationClick(_ sender: UIButton) {
        btnMessageNotification.isSelected = !sender.isSelected
        btnMessage.isSelected = !sender.isSelected
        
    }
    @IBAction func btnPushNotificationClick(_ sender: UIButton) {
        btnPushNotification.isSelected = !sender.isSelected
        btnPush.isSelected = !sender.isSelected
    }
    @IBAction func btnEventClick(_ sender: UIButton) {
        btnEventAnnounce.isSelected = !sender.isSelected
        btnEvent.isSelected = !sender.isSelected
    }
    
}
