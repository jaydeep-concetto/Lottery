//
//  MailBoxVC.swift
//  Lotery
//
//  Created by Kavi Patel on 26/01/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class MailBoxCell: UITableViewCell {
    @IBOutlet weak var btnCell: UIButton!
    @IBOutlet var imgChip: UIImageView!
    @IBOutlet weak var lblChip: UILabel!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var lblFrom: UILabel!
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var imgGet: UIImageView!
    
}
class MailBoxVC: BaseViewController {

    @IBOutlet var tblView: UITableView!
    @IBOutlet weak var txtMsgCount: UILabel!
    var arrMailList = [[String:Any]]()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        getMail()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    
    @IBAction func btnCellCliked(_ sender: UIButton) {
        switch self.arrMailList[sender.tag]["from_committee"] as? String {
        case "Love Committee":
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "MailBoxPopupThreeVC") as! MailBoxPopupThreeVC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            self.navigationController?.present(objPopup, animated: true, completion: nil)
        case "Reward Committee":
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "WinningRewardPopupOneVC") as! WinningRewardPopupOneVC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            objPopup.chipAmount = self.arrMailList[sender.tag]["item_amount"] as? String ?? ""
            self.navigationController?.present(objPopup, animated: true, completion: nil)
        default:
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "WinningRewardPopupTwoVC") as! WinningRewardPopupTwoVC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            objPopup.nav = self.navigationController!
            self.navigationController?.present(objPopup, animated: true, completion: nil)
            
        }
        readMail(index: sender.tag)
        
    }
  
    @IBAction func btnAllGetClicked(_ sender: UIButton) {
        for i in 0..<self.arrMailList.count {
            readMail(index: i)
        }
    }
    
    func readMail(index:Int)  {
        if self.arrMailList[index]["is_read"] as? String != "1" {
            backgroundpostapi(url: URL_NAME.mailbox_read_item, maindict: ["mailbox_id":self.arrMailList[index]["id"] as? String ?? ""]){ (dict) in
                if dict.count != 0
                {
                    self.arrMailList[index]["is_read"] = "1"
                    self.tblView.reloadData()
                }
            }
        }
    }
    
    func getMail()  {
        postapi(url: URL_NAME.mailbox_item_list, maindict:["user_id":users.id]) { (dict) in
            if dict.count != 0
            {
                self.arrMailList  = dict["data"] as! [[String:Any]]
                let unreadMail = self.arrMailList.filter({ (dic) -> Bool in
                    return dic["is_read"] as! String == "0"
                })
                self.txtMsgCount.text = "\(unreadMail.count) / \(self.arrMailList.count)"
               self.tblView.reloadData()
            }
        }
    }
    
}

extension MailBoxVC: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrMailList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "MailBoxCell", for: indexPath) as! MailBoxCell
        
        switch self.arrMailList[indexPath.row]["from_committee"] as? String {
        case "Club Committee":
            cell.imgChip.image = UIImage(named: "speaker")
        case "Love Committee":
            cell.imgChip.image = UIImage(named: "heart")
        case "Reward Committee":
            cell.imgChip.image = UIImage(named: "chip_bg_gray")
           
        default:
            cell.imgChip.image = UIImage(named: "cone")
        }
        switch self.arrMailList[indexPath.row]["from_committee"] as? String {
        case "Reward Committee":
            cell.imgGet.image = UIImage(named: (self.arrMailList[indexPath.row]["is_read"] as? String) == "1" ? "get_correct" : "get")
            cell.lblChip.text = self.arrMailList[indexPath.row]["item_amount"] as? String ?? ""

        default:
            cell.imgGet.image = UIImage(named: (self.arrMailList[indexPath.row]["is_read"] as? String) == "1" ? "read" : "unread")
            cell.lblChip.text = ""

        }
        cell.lblTitle.text = "Title: " + ((self.arrMailList[indexPath.row]["title"] as? String)!)
        cell.lblFrom.text = "From: " + ((self.arrMailList[indexPath.row]["from_committee"] as? String)!)
        cell.lblDate.text = "Date: " + ((self.arrMailList[indexPath.row]["updated_at"] as? String)!)
       // cell.imgGet.image = self.arrMailList[indexPath.row].get
        cell.btnCell.tag = indexPath.row
        cell.selectionStyle = .none
        return cell
    }
   
    
}

