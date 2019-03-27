//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit
import Firebase
class LotteryPreviewOneCell:UITableViewCell {
    
    @IBOutlet weak var lblAmount: UILabel!
    @IBOutlet weak var lblLtteryName: UILabel!
    @IBOutlet weak var lblCountry: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgLottery: UIImageView!
}
class LotteryPreview1VC: BaseViewController,UITableViewDelegate, UITableViewDataSource,UINavigationControllerDelegate,UIImagePickerControllerDelegate {
    var selectLotteryType:Int = -1
    var imgLottery: LyEditImageView!
    @IBOutlet weak var imgLotterySuperView:UIView!
    @IBOutlet weak var viewLotteryType:UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var btnScan: UIButton!
    var mainDict:[String:Any] = [String:Any]()
    let arrTitle:[[String:String]] = [["title":"Fit the entire front ticket on the screen","btn":"Next"],["title":"Move the Box to fit the lottery number and result date inside for scan","btn":"Scan"],["title":"Fit the entire back ticket on the screen","btn":"Next"],["title":"Move the Box to fit the signature inside for scan","btn":"Scan"]]
    var arrImg:[UIImage] = [UIImage]()
    var arrTitleIndex:Int = 0
    var arrLotteryType:[[String:Any]] = [[String:Any]]()
    @IBOutlet weak var tblViewLotteryType: UITableView!
    @IBOutlet weak var conTblHeight: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()
        getLotteryType()
        lblTitle.text = arrTitle[arrTitleIndex]["title"]
        btnScan.setTitle(arrTitle[arrTitleIndex]["btn"], for: .normal)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
        if users.signature != "" && arrTitleIndex == 1
        {
            arrImg.append(imgLottery.getCroppedImage())
            arrTitleIndex += 1
            lblTitle.text = arrTitle[arrTitleIndex]["title"]
            btnScan.setTitle(arrTitle[arrTitleIndex]["btn"], for: .normal)
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = false
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    @IBAction func btnCancelClick(_ sender: Any) {
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func btnContinueClick(_ sender: Any) {
        if selectLotteryType == -1
        {
            
            self.view.makeToast("Select Any Lottery Type", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
        }
        else
        {
            mainDict = arrLotteryType[selectLotteryType]
            let vc = UIImagePickerController()
            vc.sourceType = .camera
            vc.allowsEditing = false
            vc.delegate = self
            present(vc, animated: true)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true)
        
        guard let image = info[.originalImage] as? UIImage else {
            print("No image found")
            return
        }
        viewLotteryType.isHidden = true
        imgLottery = LyEditImageView(frame:CGRect(x: 0, y: 0, width: imgLotterySuperView.frame.size.width, height: imgLotterySuperView.frame.size.height))
        imgLottery.initWithImage(image: image)
        for i in self.imgLotterySuperView.subviews
        {
            i.removeFromSuperview()
        }
        self.imgLotterySuperView.addSubview(imgLottery)
    }
    func getLotteryType() {
        getapi(url: URL_NAME.lottery_company_list) { (dict) in
            if dict.count != 0
            {
                self.arrLotteryType = dict["data"] as? [[String:Any]] ?? []
                //                self.arrHeaderImages = self.arrHeaderImages.filter({ (a) -> Bool in
                //                    return a["country"] as? String ?? "" != "Korea"
                //                })
                self.tblViewLotteryType.reloadData()
            }
        }
    }
    
    @IBAction func btnBackClicked(_ sender: UIButton) {
        let b = self.tabBarController?.viewControllers![0] as! UINavigationController
        b.popToRootViewController(animated: false)
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func btnScanClicked(_ sender: UIButton) {
        switch arrTitleIndex {
        case 0:
            arrImg.append(imgLottery.getCroppedImage())
            imgLottery.initWithImage(image:arrImg[0])
            self.imgLotterySuperView.addSubview(imgLottery)
            
            arrTitleIndex += 1
            lblTitle.text = arrTitle[arrTitleIndex]["title"]
            btnScan.setTitle(arrTitle[arrTitleIndex]["btn"], for: .normal)
        case 1:
            recognizeText(img: imgLottery.getCroppedImage())
            
        case 2:
            arrImg.append(imgLottery.getCroppedImage())
            imgLottery.initWithImage(image:arrImg[2])
            self.imgLotterySuperView.addSubview(imgLottery)
            
            arrTitleIndex += 1
            lblTitle.text = arrTitle[arrTitleIndex]["title"]
            btnScan.setTitle(arrTitle[arrTitleIndex]["btn"], for: .normal)
        default:
             recognizeText(img: imgLottery.getCroppedImage())

        }
        
    }
    func numberOfSections(in tableView: UITableView) -> Int
    {
        conTblHeight.constant = CGFloat((arrLotteryType.count == 0) ? 60 : arrLotteryType.count*75)
        conTblHeight.constant = CGFloat((conTblHeight.constant > self.view.frame.size.height-300) ? (self.view.frame.size.height-300) : conTblHeight.constant)
        tableView.backgroundView  = (arrLotteryType.count == 0) ? noDataView(str: Constant_String.No_Friend_To_Display,tableView: tableView) : nil
        return (arrLotteryType.count == 0) ? 0 : 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrLotteryType.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LotteryPreviewOneCell", for: indexPath) as! LotteryPreviewOneCell
        cell.imgLottery.kf.indicatorType = .activity
        cell.imgLottery.kf.setImage(with:  URL(string: arrLotteryType[indexPath.row]["image"] as? String ?? ""))
        var b = NSMutableAttributedString()
        b = cell.lblAmount.attributedText as! NSMutableAttributedString
        b.mutableString.setString("$\(arrLotteryType[indexPath.row]["amount"] as? String ?? "")")
        cell.lblAmount.attributedText = b
        
        b = cell.lblCountry.attributedText as! NSMutableAttributedString
        b.mutableString.setString( arrLotteryType[indexPath.row]["country"] as? String ?? "")
        cell.lblCountry.attributedText = b
        
        b = cell.lblLtteryName.attributedText as! NSMutableAttributedString
        b.mutableString.setString(arrLotteryType[indexPath.row]["name"] as? String ?? "")
        cell.lblLtteryName.attributedText = b
        
        
        b = cell.lblDate.attributedText as! NSMutableAttributedString
        b.mutableString.setString((arrLotteryType[indexPath.row]["result_date"] as? String ?? "").replacingOccurrences(of: " ", with: "\n"))
        cell.lblDate.attributedText = b
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        for i in 0..<arrLotteryType.count {
            
            let cell = tableView.cellForRow(at: IndexPath.init(row: i, section: indexPath.section))
            if i == indexPath.row
            {
                
                cell?.contentView.backgroundColor = selectLotteryType == i ? UIColor.init(hex: "ffffff", alpha: 1) :  UIColor.init(hex: "438352", alpha: 0.3)
                
            }
            else
            {
                cell?.contentView.backgroundColor =  UIColor.init(hex: "ffffff", alpha: 1)
            }
        }
        selectLotteryType = selectLotteryType == indexPath.row ? -1 : indexPath.row
    }
    func recognizeText(img:UIImage)
    {
        let vision = Vision.vision()
        let textRecognizer = vision.onDeviceTextRecognizer()
        let image = VisionImage(image:img)
        var b:[[String:Any]] = [[String:Any]]()
        textRecognizer.process(image) { result, error in
            guard error == nil, let result = result else {
                // ...
                return
            }
            let resultText = result.text
            print("text:-",resultText)
            for block in result.blocks {
                //                let blockText = block.text
                //                //   print("block:-",blockText)
                //                let blockConfidence = block.confidence
                //                let blockLanguages = block.recognizedLanguages
                //                let blockCornerPoints = block.cornerPoints
                //                let blockFrame = block.frame
                for line in block.lines {
                    //                    let lineText = line.text
                    //                    //   print("line:-",lineText)
                    //
                    //                    let lineConfidence = line.confidence
                    //                    let lineLanguages = line.recognizedLanguages
                    //                    let lineCornerPoints = line.cornerPoints
                    //                    let lineFrame = line.frame
                    for element in line.elements {
                        let elementText = element.text
                        
                        b.append(["e":elementText,"f":element.frame])
                        //                        let elementConfidence = element.confidence
                        //                        let elementLanguages = element.recognizedLanguages
                        //                        let elementCornerPoints = element.cornerPoints
                        //                        let elementFrame = element.frame
                    }
                }
            }
            b = b.sorted(by: { (g, h) -> Bool in
                (g["f"] as! CGRect).origin.y < (h["f"] as! CGRect).origin.y
            })
            var b1:[[String:Any]] = [[String:Any]]()
            var b2:[Any] = [Any]()
            
            for i in 0..<b.count
            {
                
                if i < b.count-1 && ((b[i]["f"] as! CGRect).origin.y + ((b[i]["f"] as! CGRect).size.height/2) < (b[i+1]["f"] as! CGRect).origin.y || (b[i]["f"] as! CGRect).origin.y - ((b[i]["f"] as! CGRect).size.height/2) > (b[i+1]["f"] as! CGRect).origin.y)
                {
                    b1.append(b[i])
                    b1 = b1.sorted(by: { (g, h) -> Bool in
                        (g["f"] as! CGRect).origin.x < (h["f"] as! CGRect).origin.x
                    })
                    b2.append(b1)
                    b1 = [[String:Any]]()
                }
                else if i == b.count-1
                {
                    b1.append(b[i])
                    b1 = b1.sorted(by: { (g, h) -> Bool in
                        (g["f"] as! CGRect).origin.x < (h["f"] as! CGRect).origin.x
                    })
                    b2.append(b1)
                }
                else
                {
                    b1.append(b[i])
                }
            }
            var arrFinal:[String] = []
            for i in 0..<b2.count
            {
                let tarr = b2[i] as? [[String:Any]] ?? []
                var tempStr:String = ""
                for j in 0..<tarr.count
                {
                    tempStr = "\(tempStr)\((tarr[j]["e"] as? String  ?? ""))"
                    
                }
                arrFinal.append(tempStr)
            }
            print(arrFinal)
            if self.arrTitleIndex == 1
            {
                self.checkForNumberAndDate(arrFinal: arrFinal)
            }
            else
            {
                self.checkForSign(arrFinal: arrFinal)
            }
            // Recognized text
        }
        
    }
    func checkForSign(arrFinal:[String])
    {
        var isSign:Bool = false

        for i in arrFinal {
            if i.contains("LSSLlottoclub")
            {
                isSign = true
            }
        }
        if isSign
        {
            arrImg.append(imgLottery.getCroppedImage())
            mainDict["lotteryImg"] = arrImg
            
                        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview2VC") as! LotteryPreview2VC
                     SecondVC.mainDict = mainDict
            self.navigationController?.pushViewController(SecondVC, animated: true)
        }
        else
        {
            self.view.makeToast("Scanning was not properly made. Please scan the signature again.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
        }
    }
    func checkForNumberAndDate(arrFinal:[String])
    {
        var date:String = ""
        var numberArr:[String] = []
        for i in arrFinal {
            var isDate:Bool = false
            if i.length > 9 && !isDate
            {
                for j in 0..<i.length-10 {
                    let dateFormatterGet = DateFormatter()
                    dateFormatterGet.dateFormat = "EMMMddYY"
                    let ss = i.subString(startIndex: j, endIndex: j+9)
                    if let _ = dateFormatterGet.date(from: ss) {
                        for (index, character) in ss.enumerated() {
                            date.append(String(character))
                            
                            if index == 2 || index == 7 {
                                date.append(" ")
                            }
                        }
                        
                        isDate = true
                    }
                }
            }
            let tempStr = i.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
            if tempStr.length == 12 && !isDate
            {
                numberArr.append(tempStr.separate(every:2, with: " "))
            }
        }
        if date == "" || numberArr.count == 0
        {
            self.view.makeToast("Scanning was not properly made. Please scan the  lottery number and result date again.", duration: 2, position:CGPoint(x:self.view.frame.size.width/2,y:self.view.frame.size.height-80))
        }
        else if users.signature == ""
            {
                let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "SignatureVC") as! SignatureVC
                
                self.navigationController?.pushViewController(SecondVC, animated: true)
            }
            else
            {
               mainDict["date"] = date
                mainDict["lotteryNumber"] = numberArr
                arrImg.append(imgLottery.getCroppedImage())
                
                arrTitleIndex += 1
                lblTitle.text = arrTitle[arrTitleIndex]["title"]
                btnScan.setTitle(arrTitle[arrTitleIndex]["btn"], for: .normal)
                let vc = UIImagePickerController()
                vc.sourceType = .camera
                vc.allowsEditing = false
                vc.delegate = self
                present(vc, animated: true)
            }
    }
}
