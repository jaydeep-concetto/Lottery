//
//  HomeVC.swift
//  Lotery
//
//  Created by Kavi Patel on 11/01/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
import MarqueeLabel
class HomeVC: BaseViewController {
    
    @IBOutlet weak var lblMarquee: MarqueeLabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
   
    @IBOutlet weak var collectionViewStaticOptions: UICollectionView!
    
    @IBOutlet weak var viewBaseForTable: UIView!
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
       
        getClubList()
    }
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func btnListLotterypress(_ sender: Any) {
        if ((tabBarController!.viewControllers?.count)! > 4 )
        {
            let b = tabBarController!.viewControllers![3] as! UINavigationController
            if  UserDefaults.standard.value(forKey: "isListLotterySeen") != nil
            {
                let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview1VC") as! LotteryPreview1VC
                b.setViewControllers([SecondVC], animated: false)
            }
            else
            {
                let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ListLotteryVC") as! ListLotteryVC
                b.setViewControllers([SecondVC], animated: false)
            }
        }
        self.tabBarController?.selectedIndex = 3
    }
    var arrSearchImages: [UIImage]! = [UIImage]()
    var arrHeaderImages:[[String:Any]] = [[String:Any]]()
    var arrClubList:[[String:Any]] = [[String:Any]]()

    // MARK: - override methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
        
        arrSearchImages.append(#imageLiteral(resourceName: "ic_search"))
        arrSearchImages.append(#imageLiteral(resourceName: "ic_usa_flag"))
        arrSearchImages.append(#imageLiteral(resourceName: "ic_add_user"))
        self.collectionViewStaticOptions.reloadData()
//        arrSearchImages.append(#imageLiteral(resourceName: "ic_tv"))
//        arrSearchImages.append(#imageLiteral(resourceName: "ic_sport"))
      
       
    }
    func getClubList() {
      
        postapi(url: URL_NAME.clubListFilter, maindict:["user_id":users.id]) { (dict) in
             self.getLotteryType()
            if dict.count != 0
            {
                self.arrClubList = (dict["data"] as? [String:Any] ?? [:])["user_clubs"] as? [[String:Any]] ?? []
                for a in (dict["data"] as? [String:Any] ?? [:])["other_clubs"] as? [[String:Any]] ?? []
                {
                self.arrClubList.append(a)
                }
                self.tableView.reloadData()
            }
        }
    }
    func getLotteryType() {
        getapi(url: URL_NAME.lottery_company_list) { (dict) in
            if dict.count != 0
            {
                self.arrHeaderImages = dict["data"] as? [[String:Any]] ?? []
//                self.arrHeaderImages = self.arrHeaderImages.filter({ (a) -> Bool in
//                    return a["country"] as? String ?? "" != "Korea"
//                })
                self.collectionView.reloadData()
            }
        }
    }
}


//MARK: collectionView delegates

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.collectionViewStaticOptions{
            return arrSearchImages.count
        }
        return arrHeaderImages.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.collectionView{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellHomeUpperCollection", for: indexPath) as! cellHomeUpperCollection
            cell.imgTag.kf.indicatorType = .activity
            cell.imgTag.kf.setImage(with:  URL(string: arrHeaderImages[indexPath.row]["image"] as? String ?? ""))
            cell.lblPrice.text = "$\(arrHeaderImages[indexPath.row]["amount"] as? String ?? "")"
            cell.lblDate.text = convertDateMMMd(str:arrHeaderImages[indexPath.row]["result_date"] as? String ?? "")
            return cell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellHomeStaticOptionList", for: indexPath) as! cellHomeStaticOptionList
        cell.imageView.image = arrSearchImages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == self.collectionView{
            return CGSize.init(width:( collectionView.bounds.width / 3), height: collectionView.bounds.height)
        }
        return CGSize.init(width:( collectionView.bounds.height-5), height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == self.collectionView{
        }
        else{
            if indexPath.item == 2{
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "AddFriendVC") as! AddFriendVC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            self.present(objPopup, animated: true, completion: nil)
            }
//            else if indexPath.item == 3{
//                let shareSportVC = self.storyboard?.instantiateViewController(withIdentifier: "ShareSportVC") as! ShareSportVC
//                self.navigationController?.show(shareSportVC, sender: nil)
//
//            }
            else if indexPath.item == 0{
                let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "FilterVC") as! FilterVC
                objPopup.arrTypesOfLottery = arrHeaderImages
                self.present(objPopup, animated: true, completion: nil)
            }
        }
    }
}


//MARK: tableView delegates

extension HomeVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrClubList.count
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailVC") as! DetailVC
        
       SecondVC.clubId = arrClubList[indexPath.row]["id"] as? String ?? ""
    self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellHomeBottomList", for: indexPath) as! cellHomeBottomList
        cell.imgMainView.kf.indicatorType = .activity
        cell.imgMainView.kf.setImage(with:  URL(string: arrClubList[indexPath.row]["lottery_image"] as? String ?? ""))
        cell.lblClubWon.text = "\((arrClubList[indexPath.row]["share%"] as? String ?? ""))%"
        cell.lblJoined.text = "\((arrClubList[indexPath.row]["total_members"] as? String ?? ""))/\((arrClubList[indexPath.row]["join_limit"] as? String ?? ""))"
        cell.lblDeadLine.text = convertDatehhMMss(str:arrClubList[indexPath.row]["lottery_result_date"] as? String ?? "")
        if indexPath.item < 3{
            cell.imgShape.isHidden = false
        }
        cell.imgShape.isHidden = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let cellHeader = tableView.dequeueReusableCell(withIdentifier: "cellHomeBottomHeader") as! cellHomeBottomHeader

        return cellHeader.contentView
    }
   
}