//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit
class LotteryPreviewThreeCell:UITableViewCell {
    @IBOutlet weak var imgLotteryType: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var conSVWidth: NSLayoutConstraint!
    @IBOutlet weak var btnLotteryNumber: UIButton!
}
class LotteryPreviewThreeNoCell: UICollectionViewCell {
    @IBOutlet weak var lblno: UILabel!
}
class LotteryPreview3VC: BaseViewController,UITableViewDelegate, UITableViewDataSource, AKPickerViewDataSource, AKPickerViewDelegate,UICollectionViewDataSource,UICollectionViewDelegate {
    
    
    var arrClubList:[[String:Any]] = [[String:Any]]()
    var selectedLotteryNumber: String = ""
    var strShare: String = ""
    var strDay: String = ""
    @IBOutlet weak var lblMyNumber: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var contblViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnAccept: UIButton!
    @IBOutlet weak var conViewClubJoin: NSLayoutConstraint!
    @IBOutlet weak var conViewOverseas: NSLayoutConstraint!
    @IBOutlet var pickerViewunfollow: AKPickerView!
    @IBOutlet var pickerViewfollow: AKPickerView!
    @IBOutlet var clnViewunfollow: UICollectionView!
    @IBOutlet var clnViewfollow: UICollectionView!
    var mainDict:[String:Any] = [:]
    var arrunfollow:[String] = []
    var arrfollow:[String] = []
    var arrlotteryNumber:[String] = []
    var requestDict:[String:Any] = [:]
    @IBOutlet weak var viewSliderClubJoin: UIView!
    @IBOutlet weak var lblSliderClubJoin: UILabel!
    @IBOutlet var sliderClubJoin: UISlider!{
        didSet{
            sliderClubJoin.setThumbImage(UIImage(named: "slider_img1.png"), for: UIControl.State.normal)
            sliderClubJoin.setThumbImage(UIImage(named: "slider_img1.png"), for: UIControl.State.highlighted)
        }
    }
    @IBAction func sliderClubJoinAction(_ sender: UISlider, event: UIEvent) {
        setSliderLabel2(slider: sliderClubJoin, lblView: viewSliderClubJoin,lblSlider:lblSliderClubJoin)
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print("handle drag began")
                break
            case .moved:
                print("handle drag moved")
                break
            case .ended:
                findClosest(values: [0,10,30,50,70,100], slider: sender)
                setSliderLabel2(slider: sliderClubJoin, lblView: viewSliderClubJoin,lblSlider:lblSliderClubJoin)
                print("handle drag ended")
                break
            default:
                break
            }
        }
    }
    @IBOutlet weak var viewSliderOverseas: UIView!
    @IBOutlet weak var lblSliderOverseas: UILabel!
    @IBOutlet var sliderOverseas: UISlider!{
        didSet{
            sliderOverseas.setThumbImage(UIImage(named: "slider_img.png"), for: UIControl.State.normal)
            sliderOverseas.setThumbImage(UIImage(named: "slider_img.png"), for: UIControl.State.highlighted)
        }
    }
    @IBAction func sliderOverseasAction(_ sender: UISlider, event: UIEvent) {
        setSliderLabel1(slider: sliderOverseas, lblView: viewSliderOverseas,lblSlider:lblSliderOverseas)
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print("handle drag began")
                break
            case .moved:
                print("handle drag moved")
                break
            case .ended:
                findClosest(values: [0.5,1,2,3], slider: sender)
                setSliderLabel1(slider: sliderOverseas, lblView: viewSliderOverseas,lblSlider:lblSliderOverseas)
                print("handle drag ended")
                break
            default:
                break
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        mainDict = ["result_date": "2019-02-23 10:00:00", "image": "http://aimtechnowebs.com/lotteryapp/images/mega_million.png", "count": 0, "clubs": 0, "date": "TUE OCT30 18", "next_result_date": "2019-03-01 19:00:00", "created_at": "2019-02-12 12:29:18", "updated_at": "f", "name": "US Mega Millions", "status": "Active", "id": 2, "amount": "2.00M", "lotteryNumber": ["13 27 35 46 48 16", "20 31 39 46 49 01", "18 30 38 65 67 10"], "country": "USA"]
        getClub()
        arrlotteryNumber = mainDict["lotteryNumber"] as! [String]
        lblMyNumber.text = "1/\(arrlotteryNumber.count)"
        selectedLotteryNumber = arrlotteryNumber[0]
        tblView.reloadData()
        contblViewHeight.constant = CGFloat(70 * arrlotteryNumber.count)
        setSliderLabel2(slider: sliderClubJoin, lblView: viewSliderClubJoin,lblSlider:lblSliderClubJoin)
        setSliderLabel1(slider: sliderOverseas, lblView: viewSliderOverseas,lblSlider:lblSliderOverseas)
        pickerViewunfollow.delegate = self
        pickerViewunfollow.dataSource = self
        
        pickerViewunfollow.font = UIFont(name: "HelveticaNeue-Light", size: 12)!
        pickerViewunfollow.highlightedFont = UIFont(name: "HelveticaNeue", size: 15)!
        pickerViewunfollow.pickerViewStyle = .wheel
        pickerViewunfollow.maskDisabled = false
        pickerViewunfollow.reloadData()
        
        pickerViewfollow.delegate = self
        pickerViewfollow.dataSource = self
        
        pickerViewfollow.font = UIFont(name: "HelveticaNeue-Light", size: 12)!
        pickerViewfollow.highlightedFont = UIFont(name: "HelveticaNeue", size: 15)!
        pickerViewfollow.pickerViewStyle = .wheel
        pickerViewfollow.maskDisabled = false
        pickerViewfollow.reloadData()
        btnOverseasClicked(self.view.viewWithTag(4001) as! UIButton)
        btnClubJoinClicked(self.view.viewWithTag(3001) as! UIButton)
        btnDayClicked(self.view.viewWithTag(2001) as! UIButton)
        btnShareClicked(self.view.viewWithTag(1001) as! UIButton)
        
        // Do any additional setup after loading the view.
    }
    @IBAction func btnAcceptClicked(_ sender: UIButton) {
        btnAccept.isSelected = !btnAccept.isSelected
    }
    @IBAction func btnOverseasClicked(_ sender: UIButton) {
        for i in 4001..<4003
        {
            (self.view.viewWithTag(i) as! UIButton).isSelected = false
        }
        conViewOverseas.constant = (sender.tag == 4001) ? 190 : 0
        sender.isSelected = true
    }
    @IBAction func btnClubJoinClicked(_ sender: UIButton) {
        for i in 3001..<3003
        {
            (self.view.viewWithTag(i) as! UIButton).isSelected = false
        }
        conViewClubJoin.constant = (sender.tag == 3001) ? 370 : 0
        sender.isSelected = true
    }
    @IBAction func btnDayClicked(_ sender: UIButton) {
        for i in 2001..<2005
        {
            (self.view.viewWithTag(i) as! UIButton).isSelected = false
        }
        switch sender.tag {
        case 1002:
            strDay = "5-7"
        case 1003:
            strDay = "7-9"
        case 1004:
            strDay = "9-14"
            
        default:
            strDay = "3-5"
        }
        sender.isSelected = true
        
    }
    @IBAction func btnShareClicked(_ sender: UIButton) {
        for i in 1001..<1006
        {
            (self.view.viewWithTag(i) as! UIButton).isSelected = false
        }
        switch sender.tag {
        case 1002:
            strShare = "20"
        case 1003:
            strShare = "30"
        case 1004:
            strShare = "40"
        case 1005:
            strShare = "50"
        default:
            strShare = "10"
        }
        sender.isSelected = true
    }
    @IBAction func btnLotteryNumberClicked(_ sender: UIButton) {
        for i in 501..<501+arrlotteryNumber.count
        {
            (self.view.viewWithTag(i) as! UIButton).isSelected = false
        }
        selectedLotteryNumber = arrlotteryNumber[sender.tag-501]
        sender.isSelected = true
    }
    @IBAction func btnSave(_ sender: UIButton) {
        if (self.view.viewWithTag(3001) as! UIButton).isSelected
        {
            if arrfollow.count == 0
            {
                self.view.makeToast("Please select the follow number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if arrunfollow.count == 0
            {
                self.view.makeToast("Please select the unfollow number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if Int(sliderClubJoin.value) == 0
            {
                self.view.makeToast("Please set the limit of member", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else
            {
                requestDict[selectedLotteryNumber] = ["share":strShare,"day": strDay,"club": "new","new_club": ["limit": Int(sliderClubJoin.value),"unfollow": arrunfollow.joined(separator: " "),"follow": arrfollow.joined(separator: " ")],"overseas":(self.view.viewWithTag(4001) as! UIButton).isSelected]
                if (self.view.viewWithTag(4001) as! UIButton).isSelected
                {
                    var td = requestDict[selectedLotteryNumber] as! [String:Any]
                    td["overseas_value"] = sliderOverseas.value
                    requestDict[selectedLotteryNumber] = td
                }
                arrlotteryNumber = arrlotteryNumber.filter({ (a) -> Bool in
                    return a != selectedLotteryNumber
                })
                selectedLotteryNumber = arrlotteryNumber.count != 0 ? arrlotteryNumber[0] : ""
                tblView.reloadData()
                contblViewHeight.constant = CGFloat(70 * arrlotteryNumber.count)
                if arrlotteryNumber.count == 0
                {
                    uploadTicket()
                }
            }
        }
        else
        {
            var checkClub:Bool = true
            var clubid:String = ""
            for i in arrClubList
            {
                
                if clubid == ""
                {
                    checkClub = ((i["share%"] as? String ?? "") != strShare) ? false : checkClub
                    checkClub = (Int(i["join_limit"] as? String ?? "0")! <= Int(i["total_members"] as? String ?? "0")!) ? false : checkClub
                    checkClub = ((i["is_user_belongs_club"] as? String ?? "") == "1") ? false : checkClub
                    var ta = (i["follow_number"] as? String ?? "").components(separatedBy: " ")
                    for j in ta
                    {
                        if !selectedLotteryNumber.components(separatedBy: " ").contains(j)
                        {
                            checkClub = false
                        }
                    }
                    ta = (i["unfollow_number"] as? String ?? "").components(separatedBy: " ")
                    for j in ta
                    {
                        if selectedLotteryNumber.components(separatedBy: " ").contains(j)
                        {
                            checkClub = false
                        }
                    }
                    clubid = checkClub ? (i["id"] as? String ?? "") : ""
                }
            }
            if clubid == ""
            {
                let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "NoClubVC") as! NoClubVC
                objPopup.modalTransitionStyle = .crossDissolve
                objPopup.modalPresentationStyle = .overFullScreen
               
                self.navigationController?.present(objPopup, animated: true, completion: nil)
            }
            else
            {
                requestDict[selectedLotteryNumber] = ["share":strShare,"day": strDay,"club": "join","join_club":clubid,"overseas":(self.view.viewWithTag(4001) as! UIButton).isSelected]
                if (self.view.viewWithTag(4001) as! UIButton).isSelected
                {
                    var td = requestDict[selectedLotteryNumber] as! [String:Any]
                    td["overseas_value"] = sliderOverseas.value
                    requestDict[selectedLotteryNumber] = td
                }
                arrlotteryNumber = arrlotteryNumber.filter({ (a) -> Bool in
                    return a != selectedLotteryNumber
                })
                
                selectedLotteryNumber = arrlotteryNumber.count != 0 ? arrlotteryNumber[0] : ""
                tblView.reloadData()
                contblViewHeight.constant = CGFloat(70 * arrlotteryNumber.count)
                if arrlotteryNumber.count == 0
                {
                    uploadTicket()
                }
            }
        }
    }
    func makeRequest()
    {
        if (self.view.viewWithTag(3001) as! UIButton).isSelected
        {
            if arrfollow.count == 0
            {
                self.view.makeToast("Please select the follow number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if arrunfollow.count == 0
            {
                self.view.makeToast("Please select the unfollow number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if Int(sliderClubJoin.value) == 0
            {
                self.view.makeToast("Please set the limit of member", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else
            {
                requestDict[selectedLotteryNumber] = ["share":strShare,"day": strDay,"club": "new","new_club": ["limit": Int(sliderClubJoin.value),"unfollow": arrunfollow.joined(separator: " "),"follow": arrfollow.joined(separator: " ")],"overseas":(self.view.viewWithTag(4001) as! UIButton).isSelected]
                if (self.view.viewWithTag(4001) as! UIButton).isSelected
                {
                    var td = requestDict[selectedLotteryNumber] as! [String:Any]
                    td["overseas_value"] = sliderOverseas.value
                    requestDict[selectedLotteryNumber] = td
                }
                arrlotteryNumber = arrlotteryNumber.filter({ (a) -> Bool in
                    return a != selectedLotteryNumber
                })
                selectedLotteryNumber = arrlotteryNumber.count != 0 ? arrlotteryNumber[0] : ""
                tblView.reloadData()
                contblViewHeight.constant = CGFloat(70 * arrlotteryNumber.count)
                if arrlotteryNumber.count == 0
                {
                    uploadTicket()
                }
                else
                {
                    makeRequest()
                }
            }
        }
        else
        {
            var checkClub:Bool = true
            var clubid:String = ""
            for i in arrClubList
            {
                
                if clubid == ""
                {
                    checkClub = ((i["share%"] as? String ?? "") != strShare) ? false : checkClub
                    checkClub = (Int(i["join_limit"] as? String ?? "0")! <= Int(i["total_members"] as? String ?? "0")!) ? false : checkClub
                    checkClub = ((i["is_user_belongs_club"] as? String ?? "") == "1") ? false : checkClub
                    var ta = (i["follow_number"] as? String ?? "").components(separatedBy: " ")
                    for j in ta
                    {
                        if !selectedLotteryNumber.components(separatedBy: " ").contains(j)
                        {
                            checkClub = false
                        }
                    }
                    ta = (i["unfollow_number"] as? String ?? "").components(separatedBy: " ")
                    for j in ta
                    {
                        if selectedLotteryNumber.components(separatedBy: " ").contains(j)
                        {
                            checkClub = false
                        }
                    }
                    clubid = checkClub ? (i["id"] as? String ?? "") : ""
                }
            }
            if clubid == ""
            {
                let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "NoClubVC") as! NoClubVC
                objPopup.modalTransitionStyle = .crossDissolve
                objPopup.modalPresentationStyle = .overFullScreen
                
                self.navigationController?.present(objPopup, animated: true, completion: nil)
            }
            else
            {
                requestDict[selectedLotteryNumber] = ["share":strShare,"day": strDay,"club": "join","join_club":clubid,"overseas":(self.view.viewWithTag(4001) as! UIButton).isSelected]
                if (self.view.viewWithTag(4001) as! UIButton).isSelected
                {
                    var td = requestDict[selectedLotteryNumber] as! [String:Any]
                    td["overseas_value"] = sliderOverseas.value
                    requestDict[selectedLotteryNumber] = td
                }
                arrlotteryNumber = arrlotteryNumber.filter({ (a) -> Bool in
                    return a != selectedLotteryNumber
                })
                
                selectedLotteryNumber = arrlotteryNumber.count != 0 ? arrlotteryNumber[0] : ""
                tblView.reloadData()
                contblViewHeight.constant = CGFloat(70 * arrlotteryNumber.count)
                if arrlotteryNumber.count == 0
                {
                    uploadTicket()
                }
                else
                {
                    makeRequest()
                }
            }
        }
    }
    func uploadTicket() {
        uploadmultipleimageapi(url: URL_NAME.add_lottery_ticket, maindict: ["user_id":"94","lottery_id":mainDict["id"]!,"lottery_result_date":mainDict["next_result_date"]!,"lottery_number[]":requestDict], imageKey: ["lottery_sign_image","lottery_image[0]","lottery_image[1]","lottery_image[2]"], imageValue: [(mainDict["lotteryImg"] as! [UIImage])[3],(mainDict["lotteryImg"] as! [UIImage])[0],(mainDict["lotteryImg"] as! [UIImage])[1],(mainDict["lotteryImg"] as! [UIImage])[2]]) { (dict) in
            
            if dict.count != 0
            {
                let alertWarning = UIAlertController(title: Constant_String.APP_NAME, message: (dict["message"] as! String), preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                    let b = self.tabBarController?.viewControllers![0] as! UINavigationController
                    b.popToRootViewController(animated: false)
                    self.tabBarController?.selectedIndex = 0
                })
                alertWarning.addAction(defaultAction)
                self.present(alertWarning, animated: true, completion: nil)
            }
        }
    }
    @IBAction func btnSameSave(_ sender: UIButton) {
        makeRequest()
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrlotteryNumber.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LotteryPreviewThreeCell", for: indexPath) as! LotteryPreviewThreeCell
        var tempArr = (arrlotteryNumber[indexPath.row]).components(separatedBy: " ")
        
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
        
        cell.imgLotteryType.kf.indicatorType = .activity
        cell.imgLotteryType.kf.setImage(with: URL(string: mainDict["image"] as! String), placeholder: UIImage(named: ""), options: nil, progressBlock: nil)
        SVSetValue(SV:cell.stackView)
        
        cell.btnLotteryNumber.tag = 501+indexPath.row
        cell.btnLotteryNumber.isSelected = selectedLotteryNumber == arrlotteryNumber[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (collectionView == clnViewunfollow) ?arrunfollow.count : arrfollow.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LotteryPreviewThreeNoCell", for: indexPath) as! LotteryPreviewThreeNoCell
        cell.lblno.text = (collectionView == clnViewunfollow) ? arrunfollow[indexPath.row] : arrfollow[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (collectionView == clnViewunfollow)
        {
            arrunfollow.remove(at: indexPath.row)
            clnViewunfollow.reloadData()
        }
        else
        {
            arrfollow.remove(at: indexPath.row)
            clnViewfollow.reloadData()
        }
    }
    func numberOfItemsInPickerView(_ pickerView: AKPickerView) -> Int {
        return 71
    }
    func pickerView(_ pickerView: AKPickerView, titleForItem item: Int) -> String {
        return String(item)
    }
    
    func pickerView(_ pickerView: AKPickerView, imageForItem item: Int) -> UIImage {
        return UIImage(named: String(item))!
    }
    
    // MARK: - AKPickerViewDelegate
    
    func pickerView(_ pickerView: AKPickerView, didSelectItem item: Int) {
        print("Your favorite city is \(item)")
    }
    func pickerView(_ pickerView: AKPickerView, tap item: Int) {
        if (pickerView == pickerViewunfollow)
        {
            if arrunfollow.contains(String(item))
            {
                self.view.makeToast("You can not add same number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if arrunfollow.count == 3
            {
                self.view.makeToast("You can add only 3 number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if arrfollow.contains(String(item))
            {
                self.view.makeToast("Follow and Unfollow number are not same.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else
            {
                arrunfollow.append(String(item))
                clnViewunfollow.reloadData()
            }
        }
        else
        {
            if arrfollow.contains(String(item))
            {
                self.view.makeToast("You can not add same number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if arrfollow.count == 3
            {
                self.view.makeToast("You can add only 3 number.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else if arrunfollow.contains(String(item))
            {
                self.view.makeToast("Follow and Unfollow number are not same.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
            }
            else
            {
                arrfollow.append(String(item))
                clnViewfollow.reloadData()
            }
        }
    }
    func getClub() {
        backgroundpostapi(url: URL_NAME.clubList, maindict:["user_id":"94","lottery_id":mainDict["id"]!]) { (dict) in
         
            if dict.count != 0
            {
                self.arrClubList = (dict["data"] as? [String:Any] ?? [:])["user_clubs"] as? [[String:Any]] ?? []
                for a in (dict["data"] as? [String:Any] ?? [:])["other_clubs"] as? [[String:Any]] ?? []
                {
                    self.arrClubList.append(a)
                }
               
            }
        }
    }
}
