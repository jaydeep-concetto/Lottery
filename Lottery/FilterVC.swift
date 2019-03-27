//
//  FilterVC.swift
//  Lotery
//
//  Created by Bipin Patel on 1/31/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit
class MySlide: UISlider {
    
    @IBInspectable var height: CGFloat = 2
    override func trackRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(origin: bounds.origin, size: CGSize(width: bounds.width, height: height))
    }
}
class FilterVC: BaseViewController {
    
    @IBOutlet var cltView: UICollectionView!
    @IBOutlet var tblViewSortBy: UITableView!
    @IBOutlet var tblViewPostedWithin: UITableView!
    @IBOutlet var cnstrntClnHeight: NSLayoutConstraint!

    @IBOutlet weak var viewSlider: UIView!
    @IBOutlet weak var lblSlider: UILabel!
    @IBOutlet var slider: UISlider!{
        didSet{
            slider.setThumbImage(UIImage(named: "slider_img.png"), for: UIControl.State.normal)
            slider.setThumbImage(UIImage(named: "slider_img.png"), for: UIControl.State.highlighted)
        }
    }
    @IBAction func sliderAction(_ sender: UISlider, event: UIEvent) {
        setSliderLabel(slider: slider, lblView: viewSlider,lblSlider:lblSlider)
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print("handle drag began")
                break
            case .moved:
                print("handle drag moved")
                break
            case .ended:
                findClosest(values: [10,20,30,50,70], slider: sender)
                setSliderLabel(slider: slider, lblView: viewSlider,lblSlider:lblSlider)
                print("handle drag ended")
                break
            default:
                break
            }
        }
        
        
        
        
    }
    @IBAction func btnPostedCheckClicked(_ sender: UIButton) {
        for i in 0..<arrFilterPosted.count {
            arrFilterPosted[i]["isSelect"] = (i == sender.tag)
        }
        self.tblViewPostedWithin.reloadData()
    }
    @IBAction func btnSortCheckClicked(_ sender: UIButton) {
        for i in 0..<arrFilterSort.count {
            arrFilterSort[i]["isSelect"] = (i == sender.tag)
        }
        self.tblViewSortBy.reloadData()
    }
    var arrSelectedTypesOfLottery : [Int] = [Int]()
    var arrTypesOfLottery : [[String: Any]] = [[String : Any]]()
    var arrFilterSort : [[String : Any]] = [[String: Any]]()
    var arrFilterPosted : [[String : Any]] = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillArray()
        
        setSliderLabel(slider: slider, lblView: viewSlider,lblSlider:lblSlider)
        cltView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.cnstrntClnHeight.constant = self.cltView.contentSize.height
        }
        self.tblViewSortBy.reloadData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    func fillArray() {
        arrFilterSort.append(["title" : "My clubs first", "isSelect" : false])
        arrFilterSort.append(["title" : "Club : newly joined", "isSelect" : false])
        arrFilterSort.append(["title" : "Share % : high to low", "isSelect" : false])
        arrFilterSort.append(["title" : "Share % : low to high", "isSelect" : false])
        arrFilterSort.append(["title" : "Deadline : ending soonest", "isSelect" : false])
        arrFilterSort.append(["title" : "Members : highest first", "isSelect" : false])
        arrFilterSort.append(["title" : "Members : lowest first", "isSelect" : false])
 
        arrFilterPosted.append(["title" : "All Lists", "isSelect" : false])
        arrFilterPosted.append(["title" : "Active only", "isSelect" : false])
        arrFilterPosted.append(["title" : "The last 7days", "isSelect" : false])
        arrFilterPosted.append(["title" : "The last 15days", "isSelect" : false])
        arrFilterPosted.append(["title" : "The last 30days", "isSelect" : false])
        

    }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnResetClick(_ sender: Any) {
    }
    @IBAction func btnSaveClick(_ sender: Any) {
    }
    
}

//MARK: UICollectionView Delegates and Datasource
extension FilterVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrTypesOfLottery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfLotteryCell", for: indexPath) as! TypesOfLotteryCell
        cell.imgView.image = UIImage(named: "ic_flag_\((arrTypesOfLottery[indexPath.row]["country"] as? String ?? ""))")
        cell.lblTitle.text = (arrTypesOfLottery[indexPath.row]["name"] as! String)
        cell.lblTitle.textColor = arrSelectedTypesOfLottery.contains(indexPath.row) ? UIColor.init(hex: "fd5d0f") : UIColor.init(hex: "000000")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if !arrSelectedTypesOfLottery.contains(indexPath.row)
        {
        arrSelectedTypesOfLottery.append(indexPath.row)
        }
        else
        {
            arrSelectedTypesOfLottery = arrSelectedTypesOfLottery.filter { $0 != indexPath.row }

        }
        self.cltView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:( collectionView.bounds.width / 2), height: 55)
    }
}

//MARK: UITableView Delegates and Datasource
extension FilterVC: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return (tableView == tblViewSortBy) ? arrFilterSort.count : arrFilterPosted.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilterSortCell", for: indexPath) as! FilterSortCell
        cell.lblTitle?.text = (tableView == tblViewSortBy) ? (arrFilterSort[indexPath.row]["title"] as! String) : (arrFilterPosted[indexPath.row]["title"] as! String)
        cell.btnCheck.tag = indexPath.row
        cell.btnCheck.isSelected = (tableView == tblViewSortBy) ? arrFilterSort[indexPath.row]["isSelect"] as! Bool : arrFilterPosted[indexPath.row]["isSelect"] as! Bool
        return cell
    }
    
    
}

