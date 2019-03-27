//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit
class myClubNumberCell:UITableViewCell
{
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var conSVWidth: NSLayoutConstraint!
    @IBOutlet weak var btnUser: UIButton!
    @IBOutlet weak var btnSign: UIButton!
}
class DetailVC: BaseViewController,UITableViewDelegate,UITableViewDataSource,ModalViewControllerDelegate {
    func sendData(clubid: String) {
        clubId = clubid
        viewWillAppear(true)
    }
    
    @IBOutlet weak var conTblMyNumberHeight: NSLayoutConstraint!
    @IBOutlet weak var conTblMyClubNumberHeight: NSLayoutConstraint!
    @IBOutlet weak var tblMyNumber: UITableView!
    @IBOutlet weak var tblMyClubNumber: UITableView!
    @IBOutlet weak var lblMakedBy: UILabel!
    @IBOutlet weak var lblClubNumber: UILabel!
    @IBOutlet weak var svFollowNumber: UIStackView!
    @IBOutlet weak var svUnfollowNumber: UIStackView!
    @IBOutlet weak var lblNumberOfMember: UILabel!
    @IBOutlet weak var lblShare: UILabel!
    @IBOutlet weak var lblPriceWhenIWon: UILabel!
    @IBOutlet weak var lblProbabilityWhenIWon: UILabel!
    @IBOutlet weak var lblPriceWhenClubWon: UILabel!
    @IBOutlet weak var lblProbabilityWhenClubWon: UILabel!
    @IBOutlet weak var imgClub: UIImageView!
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblSubAmount: UILabel!
    var clubId:String = ""
    var dictClubDetail:[String:Any] = [String:Any]()
    override func viewWillAppear(_ animated: Bool) {
        
        self.tabBarController?.tabBar.isHidden=true
        conTblMyNumberHeight.constant = 1*61
        conTblMyClubNumberHeight.constant = 0*61
        getClubDetail()
    }
    func getClubDetail()
    {
        postapi(url: URL_NAME.club_detail, maindict:["user_id":users.id,"club_id":clubId]) { (dict) in
            
            if dict.count != 0
            {
                self.dictClubDetail = dict["data"] as? [String:Any] ?? [:]
                self.setData()
                
            }
        }
    }
    func setData() {
        self.conTblMyClubNumberHeight.constant = CGFloat((self.dictClubDetail["user_list"] as? [Any] ?? []).count * 61)
        self.conTblMyClubNumberHeight.constant = (self.conTblMyClubNumberHeight.constant == 0) ? 61 : self.conTblMyClubNumberHeight.constant
        self.tblMyClubNumber.reloadData()
        lblMakedBy.text = "Maked by \(((self.dictClubDetail["club_creator"] as? [String:Any] ?? [:])["name"] as? String ?? ""))"
        lblClubNumber.text = "Club number : \((self.dictClubDetail["club_number"] as? String ?? ""))"
        lblDate.text = convertDatehhMMss(str: self.dictClubDetail["lottery_result_date"] as? String ?? "")
        lblAmount.text = "$\((self.dictClubDetail["lottery_amount"] as? String ?? ""))"
        imgClub.kf.indicatorType = .activity
        imgClub.kf.setImage(with:  URL(string: self.dictClubDetail["lottery_image"] as? String ?? ""))
        var tempArr = (self.dictClubDetail["follow_number"] as? String ?? "").components(separatedBy: " ")
        for i in 0..<svFollowNumber.subviews.count
        {
            (svFollowNumber.subviews[i].subviews[0] as! UILabel).text = tempArr[i]
        }
        tempArr = (self.dictClubDetail["unfollow_number"] as? String ?? "").components(separatedBy: " ")
        for i in 0..<svUnfollowNumber.subviews.count
        {
            (svUnfollowNumber.subviews[i].subviews[0] as! UILabel).text = tempArr[i]
        }
        lblNumberOfMember.text = "\(self.dictClubDetail["total_members"] as? String ?? "") / \(self.dictClubDetail["limit_members"] as? String ?? "")"
        lblShare.text = "\((self.dictClubDetail["share%"] as? String ?? ""))%"
        lblPriceWhenIWon.text = "$\((self.dictClubDetail["user_amount"] as? String ?? ""))"
        lblPriceWhenClubWon.text = "$\((self.dictClubDetail["club_amount"] as? String ?? ""))"
        lblProbabilityWhenIWon.text = "1:\((self.dictClubDetail["total_users"] as? String ?? ""))"
        lblProbabilityWhenClubWon.text = "1:\((self.dictClubDetail["total_active_club"] as? String ?? ""))"
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblMyNumber
        {
            return 1
        }
        return (dictClubDetail["user_list"] as? [Any] ?? []).count
    }
    
    @IBAction func btnSignClicked(_ sender: UIButton) {
//        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SignatureMainVC") as! SignatureMainVC
//        
//        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    @IBAction func btnChangeClubClicked(_ sender: UIButton) {
        postapi(url: URL_NAME.clubList, maindict:["user_id":users.id]) { (dict) in
            
            if dict.count != 0
            {
                var arrClubList = (dict["data"] as? [String:Any] ?? [:])["user_clubs"] as? [[String:Any]] ?? []
                for a in (dict["data"] as? [String:Any] ?? [:])["other_clubs"] as? [[String:Any]] ?? []
                {
                    arrClubList.append(a)
                }
                                arrClubList = arrClubList.filter({ (a) -> Bool in
                                    return a["club_number"] as? String ?? "" != self.dictClubDetail["club_number"] as? String ?? ""
                                })
                let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "ChangeClubVC") as! ChangeClubVC
                objPopup.strFromClub = self.lblClubNumber.text ?? ""
                objPopup.delegate = self
                objPopup.arrClubList = arrClubList
                objPopup.modalTransitionStyle = .crossDissolve
                objPopup.modalPresentationStyle = .overFullScreen
                self.navigationController?.present(objPopup, animated: true, completion: nil)
            }
        }
   
}
    @IBAction func btnCalculatorClicked(_ sender: UIButton) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "CalculatorVC") as! CalculatorVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:myClubNumberCell = tableView.dequeueReusableCell(withIdentifier: "myClubNumberCell", for: indexPath) as! myClubNumberCell
        if tableView == tblMyClubNumber
        {
            let tempDict = ((dictClubDetail["user_list"] as? [Any] ?? [])[indexPath.row]) as? [String:Any] ?? [:]
            SVSetValue(SV: cell.stackView)
            var tempArr = (tempDict["lottery_number"] as? String ?? "").components(separatedBy: " ")
            
            for i in 0..<cell.stackView.subviews.count
            {
                cell.stackView.subviews[i].isHidden = false
                
            }
            cell.conSVWidth.constant = CGFloat(35 * tempArr.count)-5
            for i in 0..<cell.stackView.subviews.count-tempArr.count
            {
                cell.stackView.subviews[i].isHidden = true
                
            }
            for i in 0..<tempArr.count
            {
                
                (cell.stackView.subviews[i+cell.stackView.subviews.count-tempArr.count].subviews[0] as! UILabel).text = tempArr[i]
            }
            cell.btnSign.isSelected = (tempDict["signature"] as? String ?? "") == ""
            cell.btnUser.isSelected = (tempDict["overseas"] as? String ?? "") != "1"
        }
        return cell
    }
    
    
}
