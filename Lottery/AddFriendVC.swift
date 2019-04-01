//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit
class cellAddFriendVCList:UITableViewCell
{
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var lblGive: UILabel!
    @IBOutlet weak var lblGet: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var btnGive: UIButton!
    @IBOutlet weak var btnGet: UIButton!
}
class AddFriendVC: BaseViewController {
    var selectedTopIndex:Int = 0

    @IBOutlet weak var topCollectionView: UICollectionView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblAllGet: UILabel!
    @IBOutlet weak var lblAllGive: UILabel!
    
    @IBOutlet weak var lblSubTotal: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var conTblViewHeight: NSLayoutConstraint!
    //MARK: override methods
    var arrTbl:[[String:Any]] = [[String:Any]]()
    var arrWF:[[String:Any]] = [[String:Any]]()
    var arrFL:[[String:Any]] = [[String:Any]]()
    var arrAF:[[String:Any]] = [[String:Any]]()
    override func viewDidLoad() {
        super.viewDidLoad()
     getfriend()
      

    }
    func getfriend() {
        postapi(url: URL_NAME.friend_list, maindict:["user_id":users.id]) { (dict) in
            self.arrTbl = [[String:Any]]()
            self.arrAF = [[String:Any]]()
            self.arrWF = [[String:Any]]()
            self.arrFL = [[String:Any]]()
            if dict.count != 0
            {
                let ta = (dict["data"] as? [[String:Any]] ?? [])
                for a in ta
                {
                    if (a["type"] as? String ?? "") == "Add Friend"
                    {
                        if (a["agree_reject_status"] as? String ?? "") != "0"
                        {
                        self.arrAF.append(a)
                        }
                    }
                    else if (a["type"] as? String ?? "") == "WhatsApp Friend"
                    {
                        self.arrWF.append(a)
                    }
                    else
                    {
                        self.arrFL.append(a)
                    }
                }
                switch self.selectedTopIndex {
                case 2:
                    self.arrTbl = self.arrAF
                case 1:
                    self.arrTbl = self.arrFL
                default:
                    self.arrTbl = self.arrWF
                }
                self.tableView.reloadData()
            }
            self.lblSubTotal.text = "\(self.arrTbl.count)"
        }
    }
}

//MARK: actions

extension AddFriendVC{
    
    @IBAction func disMissPopup(_ sender: UIButton){
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: tableView delegatds

extension AddFriendVC: UITableViewDelegate, UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int
    {
        conTblViewHeight.constant = CGFloat((arrTbl.count == 0) ? 60 : arrTbl.count*60)
        conTblViewHeight.constant = CGFloat((conTblViewHeight.constant > self.view.frame.size.height-200) ? (self.view.frame.size.height-200) : conTblViewHeight.constant)
        tableView.backgroundView  = (arrTbl.count == 0) ? noDataView(str: Constant_String.No_Friend_To_Display,tableView: tableView) : nil
        return (arrTbl.count == 0) ? 0 : 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrTbl.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellAddFriendVCList", for: indexPath) as! cellAddFriendVCList
      
        cell.btnGet.isSelected = (selectedTopIndex == 2) ? true : false
        cell.btnGive.isSelected = (selectedTopIndex == 2) ? true : false
        cell.lblGet.text = (selectedTopIndex == 2) ? "AGREE" : "GET"
        cell.lblGive.text = (selectedTopIndex == 2) ? "REJECT" : "GIVE"
        cell.lblName.text = (arrTbl[indexPath.row]["friend_detail"] as? [String:Any] ?? [:])["name"] as? String ?? ""
        cell.imgProfilePic.kf.indicatorType = .activity
        cell.imgProfilePic.kf.setImage(with:  URL(string: (arrTbl[indexPath.row]["friend_detail"] as? [String:Any] ?? [:])["profile_pic"] as? String ?? ""))
        return cell
    }
}


//MARK: collectionView methods

extension AddFriendVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            lblAllGet.text = (indexPath.row == 2) ? "ALL AGREE" : "ALL GET"
            lblAllGive.text = (indexPath.row == 2) ? "ALL REJECT" : "ALL GIVE"
       
        
        selectedTopIndex = indexPath.row
        getfriend()
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellHomeViewPopPupOptionsCell", for: indexPath) as! cellHomeViewPopPupOptionsCell
        if selectedTopIndex == indexPath.row
        {
            cell.viewIndicator.backgroundColor = UIColor.init(hex: "0E7200")
            cell.lblTitle.textColor = UIColor.init(hex: "0E7200")
        }
        else
        {
            cell.viewIndicator.backgroundColor = UIColor.clear
            cell.lblTitle.textColor = UIColor.black
        }
        switch indexPath.row {
        case 0:
            cell.lblTitle.text = "WhatsApp Friend"
        case 1:
            cell.lblTitle.text = "Friend List"
        default:
            cell.lblTitle.text = "Add Friend"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.row == 0
        {
        let width = (collectionView.bounds.width/3)+20
        let height = collectionView.bounds.height
        return CGSize.init(width: width, height: height)
        }
        else
        {
            let width = (collectionView.bounds.width/3)-10
            let height = collectionView.bounds.height
            return CGSize.init(width: width, height: height)
        }
    }
}
