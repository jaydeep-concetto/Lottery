//
//  WinningRewardTwoVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/9/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
protocol ModalViewControllerDelegate
{
    func sendData(clubid: String)
}
class ChangeClubVC: BaseViewController {
    @IBOutlet weak var txtFromClub: UITextField!
    @IBOutlet weak var txtToClub: UITextField!
    var strFromClub:String = ""
    var selectedClubId:String = ""
    var delegate:ModalViewControllerDelegate!

    var arrClubList:[[String:Any]] = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        txtFromClub.text = strFromClub
        if arrClubList.count != 0
        {
            selectedClubId = arrClubList[0]["id"] as? String ?? ""
        self.txtToClub.text = "Club number : \((arrClubList[0]["club_number"] as? String ?? "")), \((arrClubList[0]["total_members"] as? String ?? ""))/\((arrClubList[0]["join_limit"] as? String ?? ""))"
        }
        txtToClub.loadDropdownDataFromDictionaryArray(data: arrClubList, keyForValue: "club_number", toolbarColor: UIColor.init(hex: "FD5D0F")) { (a) in
            if a.count == 0
            {
                self.selectedClubId = ""
                self.txtToClub.text = ""
            }
            else
            {
                self.selectedClubId = a["id"] as? String ?? ""
            self.txtToClub.text = "Club number : \((a["club_number"] as? String ?? "")), \((a["total_members"] as? String ?? ""))/\((a["join_limit"] as? String ?? ""))"
            }
        }
    }
    @IBAction func btnChangeClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
      
        delegate.sendData(clubid: selectedClubId)
    }
   
}
