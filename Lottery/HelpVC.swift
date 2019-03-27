//
//  HelpVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/6/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class HelpHeader: NSObject {
    var strHeader: String = ""
    var arrHelpDetail: [HelpDetail] = [HelpDetail]()
    override init() {
    }
}
class HelpDetail: NSObject {
    var strDetail: String = ""
}
class HelpVC: BaseViewController {
override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    @IBOutlet var viewSearch: UIView!{
        didSet{
            viewSearch.layer.cornerRadius = 20.0
            viewSearch.layer.borderColor = #colorLiteral(red: 1, green: 0.4, blue: 0, alpha: 1)
            viewSearch.layer.borderWidth = 1.0
        }
        
    }
    @IBOutlet var txtSearch: UITextField!{
        didSet{
            let img = UIImageView(frame: CGRect(x: 0, y: 0, width: 25, height: 25))
            img.image = #imageLiteral(resourceName: "search_orange")
            img.contentMode = .scaleAspectFit
            txtSearch.rightView = img
            txtSearch.rightViewMode = .always
        }
    }
    @IBOutlet var tblView: UITableView!
    
    var arrHelp: [HelpHeader] = [HelpHeader]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setArray()
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }
    
    func setArray() {
        let objHeader1: HelpHeader = HelpHeader()
        objHeader1.strHeader = "Popular Topics"
        
        let objDetail11: HelpDetail = HelpDetail()
        objDetail11.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader1.arrHelpDetail.append(objDetail11)
        
        let objDetail12: HelpDetail = HelpDetail()
        objDetail12.strDetail = "What should I do if think a L$$L user may"
        objHeader1.arrHelpDetail.append(objDetail12)
        
        let objDetail13: HelpDetail = HelpDetail()
        objDetail13.strDetail = "What should I do if think a L$$L user may"
        objHeader1.arrHelpDetail.append(objDetail13)
        arrHelp.append(objHeader1)
        
        let objHeader2: HelpHeader = HelpHeader()
        objHeader2.strHeader = "Getting Started"
        
        let objDetail21: HelpDetail = HelpDetail()
        objDetail21.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader2.arrHelpDetail.append(objDetail21)
        
        let objDetail22: HelpDetail = HelpDetail()
        objDetail22.strDetail = "What should I do if think a L$$L user may"
        objHeader2.arrHelpDetail.append(objDetail22)
        
        let objDetail23: HelpDetail = HelpDetail()
        objDetail23.strDetail = "What should I do if think a L$$L user may"
        objHeader2.arrHelpDetail.append(objDetail23)
        arrHelp.append(objHeader2)
        
        let objHeader3: HelpHeader = HelpHeader()
        objHeader3.strHeader = "Trust & Safety"
        
        let objDetail31: HelpDetail = HelpDetail()
        objDetail31.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader3.arrHelpDetail.append(objDetail31)
        
        let objDetail32: HelpDetail = HelpDetail()
        objDetail32.strDetail = "What should I do if think a L$$L user may"
        objHeader3.arrHelpDetail.append(objDetail32)
        
        let objDetail33: HelpDetail = HelpDetail()
        objDetail33.strDetail = "What should I do if think a L$$L user may"
        objHeader3.arrHelpDetail.append(objDetail33)
        arrHelp.append(objHeader3)
        
        let objHeader4: HelpHeader = HelpHeader()
        objHeader4.strHeader = "Your Account"
        
        let objDetail41: HelpDetail = HelpDetail()
        objDetail41.strDetail = "How do I edit my profile?"
        objHeader4.arrHelpDetail.append(objDetail41)
        
        let objDetail42: HelpDetail = HelpDetail()
        objDetail42.strDetail = "How do I change my signature?"
        objHeader4.arrHelpDetail.append(objDetail42)
        
        let objDetail43: HelpDetail = HelpDetail()
        objDetail43.strDetail = "How do I delete my account?"
        objHeader4.arrHelpDetail.append(objDetail43)
        arrHelp.append(objHeader4)
        
        let objHeader5: HelpHeader = HelpHeader()
        objHeader5.strHeader = "Who’s L$$L"
        
        let objDetail51: HelpDetail = HelpDetail()
        objDetail51.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader5.arrHelpDetail.append(objDetail51)
        
        let objDetail52: HelpDetail = HelpDetail()
        objDetail52.strDetail = "What should I do if think a L$$L user may"
        objHeader5.arrHelpDetail.append(objDetail52)
        
        let objDetail53: HelpDetail = HelpDetail()
        objDetail53.strDetail = "What should I do if think a L$$L user may"
        objHeader5.arrHelpDetail.append(objDetail53)
        arrHelp.append(objHeader5)
        
        let objHeader6: HelpHeader = HelpHeader()
        objHeader6.strHeader = "How to L$$L"
        
        let objDetail61: HelpDetail = HelpDetail()
        objDetail61.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader6.arrHelpDetail.append(objDetail61)
        
        let objDetail62: HelpDetail = HelpDetail()
        objDetail62.strDetail = "What should I do if think a L$$L user may"
        objHeader6.arrHelpDetail.append(objDetail62)
        
        let objDetail63: HelpDetail = HelpDetail()
        objDetail63.strDetail = "What should I do if think a L$$L user may"
        objHeader6.arrHelpDetail.append(objDetail63)
        arrHelp.append(objHeader6)
        
        let objHeader7: HelpHeader = HelpHeader()
        objHeader7.strHeader = "Listing your lottery on L$$L"
        
        let objDetail71: HelpDetail = HelpDetail()
        objDetail71.strDetail = "How do I post a listing on L$$L?"
        objHeader7.arrHelpDetail.append(objDetail71)
        
        let objDetail72: HelpDetail = HelpDetail()
        objDetail72.strDetail = "How do I edit a listing?"
        objHeader7.arrHelpDetail.append(objDetail72)
        
        let objDetail73: HelpDetail = HelpDetail()
        objDetail73.strDetail = "How do I delete listing I’ve posted?"
        objHeader7.arrHelpDetail.append(objDetail73)
        arrHelp.append(objHeader7)
        
        let objHeader8: HelpHeader = HelpHeader()
        objHeader8.strHeader = "Issues while join on L$$L"
        
        let objDetail81: HelpDetail = HelpDetail()
        objDetail81.strDetail = "How do I find listings I posted?"
        objHeader8.arrHelpDetail.append(objDetail81)
        
        let objDetail82: HelpDetail = HelpDetail()
        objDetail82.strDetail = "How do I change my listing’s club?"
        objHeader8.arrHelpDetail.append(objDetail82)
        
        let objDetail83: HelpDetail = HelpDetail()
        objDetail83.strDetail = "What should I do if think a L$$L user may"
        objHeader8.arrHelpDetail.append(objDetail83)
        arrHelp.append(objHeader8)
        
        let objHeader9: HelpHeader = HelpHeader()
        objHeader9.strHeader = "Issues after there is winner on L$$L"
        
        let objDetail91: HelpDetail = HelpDetail()
        objDetail91.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader9.arrHelpDetail.append(objDetail91)
        
        let objDetail92: HelpDetail = HelpDetail()
        objDetail92.strDetail = "What should I do if think a L$$L user may"
        objHeader9.arrHelpDetail.append(objDetail92)
        
        let objDetail93: HelpDetail = HelpDetail()
        objDetail93.strDetail = "What should I do if think a L$$L user may"
        objHeader9.arrHelpDetail.append(objDetail93)
        arrHelp.append(objHeader9)
        
        let objHeader10: HelpHeader = HelpHeader()
        objHeader10.strHeader = "Buv overseas  lottery"
        
        let objDetail101: HelpDetail = HelpDetail()
        objDetail101.strDetail = "What should I do if think a L$$L user may have broken the law?"
        objHeader10.arrHelpDetail.append(objDetail101)
        
        let objDetail102: HelpDetail = HelpDetail()
        objDetail102.strDetail = "What should I do if think a L$$L user may"
        objHeader10.arrHelpDetail.append(objDetail102)
        
        let objDetail103: HelpDetail = HelpDetail()
        objDetail103.strDetail = "What should I do if think a L$$L user may"
        objHeader10.arrHelpDetail.append(objDetail103)
        arrHelp.append(objHeader10)
    }
}
//MARK: UITableView Delegates and Datasource
extension HelpVC: UITableViewDataSource, UITableViewDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.arrHelp.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrHelp[section].arrHelpDetail.count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let width = UIScreen.main.bounds.width
        let view = UIView(frame: CGRect(x: 0, y: 0, width: width, height: 64))
        view.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        let lblHeader = UILabel(frame: CGRect(x: 16, y: 0, width: width - 36, height: 64))
        lblHeader.text = arrHelp[section].strHeader
        lblHeader.textColor = #colorLiteral(red: 1, green: 0.4, blue: 0, alpha: 1)
        
        view.addSubview(lblHeader)
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "HelpCell", for: indexPath) as! HelpCell
        cell.lblHelp?.text = arrHelp[indexPath.section].arrHelpDetail[indexPath.row].strDetail
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 64
    }
}
