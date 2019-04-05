//
//  AccountVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/2/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class List: NSObject {
    var listIcon: UIImage!
    var title: String!
    var isSwitch: Bool!
    
    override init() {
        
    }
}
class AccountVC: BaseViewController {

    @IBOutlet var tblView: UITableView!
    var arraList: [List]! = [List]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       
        getArray()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnLogoutClicked(_ sender: UIButton) {
        UserDefaults.standard.removeObject(forKey: "userInfo")
        UserDefaults.standard.removeObject(forKey: "isResultSeen")
        UserDefaults.standard.removeObject(forKey: "isListLotterySeen")
    let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "OldWayVC") as! OldWayVC
    self.navigationController?.pushViewController(secondVC, animated: false)
    }
    func getArray()  {
        let objUser = List()
        objUser.listIcon = #imageLiteral(resourceName: "ac_user")
        objUser.title = "Contact info"
        objUser.isSwitch = false
        arraList.append(objUser)
        
        let objPaid = List()
        objPaid.listIcon = #imageLiteral(resourceName: "ac_paid")
        objPaid.title = "Paid member"
        objPaid.isSwitch = false
        arraList.append(objPaid)
        
        let objNotification = List()
        objNotification.listIcon = #imageLiteral(resourceName: "ac_notification")
        objNotification.title = "Notification setting"
        objNotification.isSwitch = false
        arraList.append(objNotification)
        
        let objDollar = List()
        objDollar.listIcon = #imageLiteral(resourceName: "ac_dollar")
        objDollar.title = "Track your money"
        objDollar.isSwitch = false
        arraList.append(objDollar)
        
        let objAd = List()
        objAd.listIcon = #imageLiteral(resourceName: "ac_ad")
        objAd.title = "Ad for guide"
        objAd.isSwitch = true
        arraList.append(objAd)
    }
    
    
    
}

//MARK: UITableView Delegates and Datasource
extension AccountVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arraList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath) as! AccountCell
        cell.lblTitle?.text = arraList[indexPath.row].title
        cell.imgView.image = arraList[indexPath.row].listIcon
        cell.imgArrow.isHidden = arraList[indexPath.row].isSwitch == true ? true : false
        cell.btnSwitch.isHidden = arraList[indexPath.row].isSwitch == true ? false : true
        cell.selectionStyle = .none
        return cell
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            let shareSportVC = self.storyboard?.instantiateViewController(withIdentifier: "ContactInfoVC") as! ContactInfoVC
            self.navigationController?.show(shareSportVC, sender: nil)
        }else if indexPath.row == 1{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "PaidMemberVC") as! PaidMemberVC
            self.navigationController?.show(vc, sender: nil)
        }else if indexPath.row == 2{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "NotificationSettingVC") as! NotificationSettingVC
            self.navigationController?.show(vc, sender: nil)
        }else if indexPath.row == 3{
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "TrackYourMoneyVC") as! TrackYourMoneyVC
            self.navigationController?.show(vc, sender: nil)
        }
    }
}
