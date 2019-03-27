//
//  LotteryPreview1VC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 13/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit
class LotteryPreviewTwoCell:UITableViewCell {
    @IBOutlet weak var imgLotteryType: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var conSVWidth: NSLayoutConstraint!

    
}
class LotteryPreview2VC: BaseViewController,UITableViewDelegate, UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var lblTotalNumber: UILabel!
    @IBOutlet weak var clnView: UICollectionView!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var contblViewHeight: NSLayoutConstraint!
    var mainDict:[String:Any] = [:]

    override func viewDidLoad() {
        super.viewDidLoad()
        lblTotalNumber.text = "total : \((mainDict["lotteryNumber"] as! [String]).count)"
        contblViewHeight.constant = CGFloat((mainDict["lotteryNumber"] as! [String]).count * 70)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnMorePhotoClicked(_ sender: UIButton) {
        self.tabBarController?.selectedIndex = 0
    }
    @IBAction func btnNextClicked(_ sender: UIButton) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview3VC") as! LotteryPreview3VC
       SecondVC.mainDict = mainDict
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return (mainDict["lotteryNumber"] as! [String]).count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         
            let cell = tableView.dequeueReusableCell(withIdentifier: "LotteryPreviewTwoCell", for: indexPath) as! LotteryPreviewTwoCell
            var tempArr = ((mainDict["lotteryNumber"] as! [String])[indexPath.row]).components(separatedBy: " ")
            
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
           SVSetValue(SV:cell.stackView)
cell.imgLotteryType.kf.indicatorType = .activity
            cell.imgLotteryType.kf.setImage(with: URL(string: mainDict["image"] as! String), placeholder: UIImage(named: ""), options: nil, progressBlock: nil)
            return cell
        }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (mainDict["lotteryImg"] as! [UIImage]).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LotteryPreviewTopTwoCell", for: indexPath) as! LotteryPreviewTopTwoCell
        cell.imageView.image = (mainDict["lotteryImg"] as! [UIImage])[indexPath.row]
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.size.width-20)/4, height: 90)
    }

}
