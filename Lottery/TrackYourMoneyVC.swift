//
//  TrackYourMoneyVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/6/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class Detail: NSObject {
    var title: String = ""
    var date: String = ""
    
    override init() {
        
    }
}
class TrackYourMoneyVC: BaseViewController {

    @IBOutlet var tblView: UITableView!
    @IBOutlet var cnstrntTblHeight: NSLayoutConstraint!
    
    var arrDetail: [Detail] = [Detail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let obj1 = Detail()
        obj1.title = "Winner finished collecting the money."
        obj1.date = "Mar.07.2018"
        arrDetail.append(obj1)
        
        let obj2 = Detail()
        obj2.title = "L$$L received share money from winner."
        obj2.date = "Mar.09.2018"
        arrDetail.append(obj2)
        
        let obj3 = Detail()
        obj3.title = "The due date is 7:00 pm today."
        obj3.date = "Mar.10.2018"
        arrDetail.append(obj3)
        
        self.tblView.delegate = self
        self.tblView.dataSource = self
        DispatchQueue.main.async {
            self.cnstrntTblHeight.constant = self.tblView.contentSize.height
        }
    }

    @IBAction func btnBackClick(_ sender: Any){
        self.navigationController?.popViewController(animated: true)
    }
}
//MARK: UITableView Delegates and Datasource
extension TrackYourMoneyVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrDetail.count
    }
    
  
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackDetailCell", for: indexPath) as! TrackDetailCell
        cell.lblTitle?.text = arrDetail[indexPath.row].title
        cell.lblDate.text = arrDetail[indexPath.row].date
        cell.selectionStyle = .none
        return cell
    }
  
}
