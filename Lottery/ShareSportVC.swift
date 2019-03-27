//
//  ShareSportVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/1/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class Team: NSObject {
    var strDate: String = ""
    var imageTeam1: UIImage!
    var imageTeam2: UIImage!
    var strTeamTitle1: String = ""
    var strTeamTitle2: String = ""
    var strTeam: String = ""
    var color: UIColor!
    override init() {
        
    }
}
class ShareSportVC: BaseViewController {

    @IBOutlet var clnView: UICollectionView!
    @IBOutlet var tblView: UITableView!
    
    var arrTeam: [Team]! = [Team]()
    var arrSport: [Any]! = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
      
        
        
        let objTeam1: Team = Team()
        objTeam1.strDate = "4:30PM, SEP 02, 2018"
        objTeam1.imageTeam1 = #imageLiteral(resourceName: "hou")
        objTeam1.imageTeam2 = #imageLiteral(resourceName: "lad")
        objTeam1.strTeamTitle1 = "HOU"
        objTeam1.strTeamTitle2 = "LAD"
        objTeam1.strTeam = "Betting Team : LA DAggers"
        objTeam1.color = #colorLiteral(red: 0.2784313725, green: 0.6196078431, blue: 0.1607843137, alpha: 1)
        arrTeam.append(objTeam1)
        
        let objTeam2: Team = Team()
        objTeam2.strDate = "4:30PM, SEP 02, 2018"
        objTeam2.imageTeam1 = #imageLiteral(resourceName: "nyy")
        objTeam2.imageTeam2 = #imageLiteral(resourceName: "bos")
        objTeam2.strTeamTitle1 = "NYY"
        objTeam2.strTeamTitle2 = "BOS"
        objTeam2.strTeam = "Please select a team"
        objTeam2.color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)
        arrTeam.append(objTeam2)
        
        arrSport.append(#imageLiteral(resourceName: "sport1"))
        arrSport.append(#imageLiteral(resourceName: "sport2"))
        arrSport.append(#imageLiteral(resourceName: "sport3"))
        arrSport.append(#imageLiteral(resourceName: "sport4"))
        self.clnView.delegate = self
        self.clnView.dataSource = self
        self.tblView.delegate = self
        self.tblView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
   
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    //MARK:- Common Navigation Button Action Method
    @objc func navRightButtonAction_Clicked(sender: UIButton) {
    }
    @IBAction func btnRightClick(_ sender: Any) {
    }
    @IBAction func btnLeftClick(_ sender: Any) {
    }
}


//MARK: UICollectionView Delegates and Datasource
extension ShareSportVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrSport.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SHareSportHeaderCell", for: indexPath) as! SHareSportHeaderCell
        cell.btnSport.setImage((arrSport[indexPath.item] as! UIImage), for: .normal) 
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:75, height: 75)
    }
}

//MARK: UITableView Delegates and Datasource
extension ShareSportVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrTeam.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ShareSportVSCell", for: indexPath) as! ShareSportVSCell
        cell.lblDate.text = arrTeam[indexPath.row].strDate
        cell.imgTeam1.image = arrTeam[indexPath.row].imageTeam1
        cell.imgTeam2.image = arrTeam[indexPath.row].imageTeam2
        cell.lblTeamTitle1.text = arrTeam[indexPath.row].strTeamTitle1
        cell.lblTeamTitle2.text = arrTeam[indexPath.row].strTeamTitle2
        cell.lblTeam.text = arrTeam[indexPath.row].strTeam
        cell.subView2.backgroundColor = arrTeam[indexPath.row].color
        return cell
    }
    
  
}
