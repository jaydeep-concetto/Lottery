//
//  SignatureVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/5/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class Signature: NSObject {
    var font: String = ""
    var title: String = ""
    var isSelected: Bool = false
}
class SignatureVC: BaseViewController {

    @IBOutlet weak var conTopViewBottom: NSLayoutConstraint!
    @IBOutlet weak var scrContentView: UIView!
    @IBOutlet weak var conTopViewHeight: NSLayoutConstraint!
    @IBOutlet weak var viewNewSignature: UIView!
    @IBOutlet weak var conTopViewTop: NSLayoutConstraint!
    @IBOutlet weak var scrView: UIScrollView!
    @IBOutlet weak var viewMyOwn: UIView!
    var isNewSignature:Bool = false
    @IBOutlet var btnChoose: UIButton!
    @IBOutlet weak var txtGivenName: UITextField!
    @IBOutlet var btnMyOwn: UIButton!
    @IBOutlet var tblView: UITableView!
    var btnSelected:UIButton = UIButton()
    @IBOutlet var cnstrntTblHeight: NSLayoutConstraint!

    @IBOutlet weak var viewSignatureMain: EPSignatureView!
    
    @IBOutlet weak var btnaccept: UIButton!
    var arrList: [Signature] = [Signature]()
    @IBOutlet weak var imgSignatureNew: UIImageView!
    @IBOutlet weak var imgSignatureOld: UIImageView!
    @IBOutlet weak var txtFamilyName: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        isNewSignature = (users.signature == "") ? true : false
        imgSignatureOld.kf.indicatorType = .activity
        imgSignatureOld.kf.setImage(
            with: URL(string: users.signature))
        btnSelected = btnChoose
        NotificationCenter.default.addObserver(self, selector: #selector(beginsignature(notification:)), name: Notification.Name("beginsignature"), object: nil)
         NotificationCenter.default.addObserver(self, selector: #selector(newsignature(notification:)), name: Notification.Name("signature"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(endsignature(notification:)), name: Notification.Name("endsignature"), object: nil)
        conTopViewTop.constant = isNewSignature ? 0 : -90
        
        viewNewSignature.isHidden = isNewSignature
        let obj1: Signature = Signature()
        obj1.title = "EB_Garamond"
        obj1.isSelected = false
        obj1.font = "EB Garamond"
        arrList.append(obj1)
        
        let obj2: Signature = Signature()
        obj2.title = "DancingScript"
        obj2.isSelected = true
        obj2.font = "Dancing Script"
        arrList.append(obj2)
        
        let obj3: Signature = Signature()
        obj3.title = "Gloria_Hallelujah"
        obj3.isSelected = false
       obj3.font = "GloriaHallelujah"
        arrList.append(obj3)
        
        let obj4: Signature = Signature()
        obj4.title = "Homemade_Apple"
        obj4.isSelected = false
        obj4.font = "Homemade Apple"
        arrList.append(obj4)
        
        let obj5: Signature = Signature()
        obj5.title = "Satisfy"
        obj5.isSelected = false
        obj5.font = "Satisfy"
        arrList.append(obj5)
        
    
        DispatchQueue.main.async {
            if self.scrView.frame.size.height>self.conTopViewHeight.constant+239+CGFloat(self.arrList.count * 44)
            {
                let b = self.scrView.frame.size.height-(self.conTopViewHeight.constant+239+CGFloat(self.arrList.count * 44))
                self.cnstrntTblHeight.constant = CGFloat(self.arrList.count * 44) + b
            }
            else
            {
                self.cnstrntTblHeight.constant = CGFloat(self.arrList.count * 44)
            }
        }
      
      
        // Do any additional setup after loading the view.
    }
    @objc func newsignature(notification: NSNotification) {
        imgSignatureNew.image = viewSignatureMain.getSignatureAsImage()
    }
    @objc func beginsignature(notification: NSNotification) {
        scrView.isScrollEnabled = false
    }
    @objc func endsignature(notification: NSNotification) {
        scrView.isScrollEnabled = true
    }
   
    
    
    @IBAction func btnChooseClick(_ sender: UIButton) {
        sender.backgroundColor = UIColor.init(hex: "6ca400")
        sender.setTitleColor(UIColor.white, for: .normal)
btnSelected = sender
       if sender == btnChoose
       {
        
        _ = self.arrList.map{if ($0.isSelected)
        {
            imgSignatureNew.image = imageWith(name: txtGivenName.text!+" "+txtFamilyName.text!,imageView: imgSignatureNew,font: $0.font)
            //  textToImage(drawText: "Jaydeep", inImage: imgSignatureNew)
            }
        }
        
        btnMyOwn.backgroundColor = UIColor.init(hex: "cccccc")
        btnMyOwn.setTitleColor(UIColor.init(hex: "999999"), for: .normal)
        viewMyOwn.isHidden = true
        DispatchQueue.main.async {
           
            self.conTopViewHeight.constant = 316.5
            self.conTopViewTop.constant = self.isNewSignature ? 0 : -90
            if self.scrView.frame.size.height>self.conTopViewHeight.constant+239+CGFloat(self.arrList.count * 44)
            {
                let b = self.scrView.frame.size.height-(self.conTopViewHeight.constant+239+CGFloat(self.arrList.count * 44))
                self.cnstrntTblHeight.constant = CGFloat(self.arrList.count * 44) + b
            }
            else
            {
                self.cnstrntTblHeight.constant = CGFloat(self.arrList.count * 44)
            }
        }
        }
        else
       {
        viewSignatureMain.clear()
        self.view.endEditing(true)
        btnChoose.backgroundColor = UIColor.init(hex: "cccccc")
        btnChoose.setTitleColor(UIColor.init(hex: "999999"), for: .normal)
        viewMyOwn.isHidden = false
        DispatchQueue.main.async {
            self.conTopViewHeight.constant = self.isNewSignature ? 226.5 : 140
            self.conTopViewTop.constant = 0

            if self.scrView.frame.size.height>self.conTopViewHeight.constant+409
            {
                let b = self.scrView.frame.size.height-(self.conTopViewHeight.constant+409)
                self.cnstrntTblHeight.constant = 170 + b
            }
            else
            {
                self.cnstrntTblHeight.constant = 170
            }
        }
        }
    }
    @IBAction func btnClearClicked(_ sender: UIButton) {
        viewSignatureMain.clear()
    }
    @IBAction func btnAcceptClick(_ sender: UIButton) {
    btnaccept.isSelected = !btnaccept.isSelected
    }
    @IBAction func btnCreateSignatureClicked(_ sender: UIButton) {
        if !btnaccept.isSelected {
            showAlertWithTitle(title: Constant_String.APP_NAME, string: "Please accept the terms of disclosure.")
        }
        else if imgSignatureNew.image != nil
        {
            uploadimageapi(url: URL_NAME.uploadSignature, maindict: ["user_id":users.id], imageKey: "signature", imageValue: imgSignatureNew.image!) { (dict) in
                if dict.count != 0
                {
                
                    let alertWarning = UIAlertController(title: Constant_String.APP_NAME, message: (dict["message"] as! String), preferredStyle: .alert)
                    
                    let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { (a) in
                        if UserDefaults.standard.value(forKey: "userInfo") != nil
                        {
                            var tempDict1 = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
                            var tempDict = tempDict1["user"] as! Dictionary<String, String>
                            
                            tempDict["signature"] = (dict["data"] as! Dictionary<String, String>) ["signature"]
                            tempDict1["user"] = tempDict
                            UserDefaults.standard.set(tempDict1, forKey: "userInfo")
                        }
                        users.signature = (dict["data"] as! Dictionary<String, String>) ["signature"]!
                        
                        self.backButtonAction(sender: sender)
                    })
                    alertWarning.addAction(defaultAction)
                    self.present(alertWarning, animated: true, completion: nil)
                }
            }
        }
    }
    func textToImage(drawText text: String, inImage image: UIImageView) {
        let textColor = UIColor.white
        let textFont = UIFont(name: "Helvetica Bold", size: 12)!
        
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(image.frame.size, false, scale)
        
        let textFontAttributes = [
            NSAttributedString.Key.font: textFont,
            NSAttributedString.Key.foregroundColor: textColor,
            ] as [NSAttributedString.Key : Any]
        image.image?.draw(in: CGRect(origin: CGPoint.zero, size: image.frame.size))
        
        let rect = CGRect(origin: CGPoint(x: 10, y: 10), size: CGSize(width: image.frame.size.width-20, height: image.frame.size.height-20))
        text.draw(in: rect, withAttributes: textFontAttributes)

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        image.image = newImage
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        _ = self.arrList.map{if ($0.isSelected)
        {
            imgSignatureNew.image = imageWith(name: txtGivenName.text!+" "+txtFamilyName.text!,imageView: imgSignatureNew,font: $0.font)
            //  textToImage(drawText: "Jaydeep", inImage: imgSignatureNew)
            }}
    }
        func imageWith(name: String?,imageView:UIImageView,font:String) -> UIImage? {
            var name = name
            let l = (name?.length)!
            if l < 12
            {
                for _ in 0..<12-l
                {
                    name = "\(name ?? "") "
                }
            }
            let frame = CGRect(x: 10, y: 0, width: 0, height: 0)
            let nameLabel = UILabel(frame: frame)
            nameLabel.textAlignment = .center
            nameLabel.backgroundColor = .white
            nameLabel.textColor = .black
            nameLabel.font = UIFont(name: font, size: 30)
            nameLabel.text = name
                let fontAttributes = [NSAttributedString.Key.font: nameLabel.font]
                
            let size = name!.size(withAttributes: fontAttributes as [NSAttributedString.Key : Any])
                nameLabel.frame = CGRect(x: 10, y: 0, width: size.width+20, height: size.height)

            UIGraphicsBeginImageContext(CGSize(width:size.width+20, height: size.height))
            if let currentContext = UIGraphicsGetCurrentContext() {
                nameLabel.layer.render(in: currentContext)
                let nameImage = UIGraphicsGetImageFromCurrentImageContext()
                return nameImage
            }
            return nil
        }
}

//MARK: UITableView Delegates and Datasource
extension SignatureVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return arrList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "SignatureCell", for: indexPath) as! SignatureCell
        cell.lblTitle?.text = arrList[indexPath.row].title
        cell.btnCheck.isSelected = arrList[indexPath.row].isSelected
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 44
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        _ = self.arrList.map{$0.isSelected = false}
        self.arrList[indexPath.row].isSelected = !self.arrList[indexPath.row].isSelected
        _ = self.arrList.map{if ($0.isSelected)
        {
            imgSignatureNew.image = imageWith(name: txtGivenName.text!+" "+txtFamilyName.text!,imageView: imgSignatureNew,font: $0.font)
          //  textToImage(drawText: "Jaydeep", inImage: imgSignatureNew)
            }
        }
        self.tblView.reloadData()
    }

    
}
