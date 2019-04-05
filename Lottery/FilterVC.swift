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
protocol FilterVCDelegate {
    func setData(selectedShare1 : String ,selectedSort1 : String,selectedPosted1 : String,arrSelectedTypesOfLottery1 : String)
}
class FilterVC: BaseViewController {
    var delegate: FilterVCDelegate! = nil
    

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
        indexPosted = sender.tag
        self.tblViewPostedWithin.reloadData()
    }
    @IBAction func btnSortCheckClicked(_ sender: UIButton) {
       
        indexSort = sender.tag
        self.tblViewSortBy.reloadData()
    }
    func indexFromSelected()
    {
        for i in 0..<arrFilterSort.count
        {
            indexSort = (arrFilterSort[i]["sort"] as! String == selectedSort) ? i : indexSort
        }
        self.tblViewSortBy.reloadData()
        for i in 0..<arrFilterPosted.count
        {
            indexPosted = (arrFilterPosted[i]["sort"] as! String == selectedPosted) ? i : indexPosted
        }
        self.tblViewPostedWithin.reloadData()
    }
    func SelectedFromIndex() {
        if indexSort != -1
        {
            selectedSort = arrFilterSort[indexSort]["sort"] as! String
        }
        if indexPosted != -1
        {
            selectedPosted = arrFilterPosted[indexPosted]["sort"] as! String
        }
        selectedShare = "\(Int(slider.value))"
    }
    var indexSort : Int = -1
    var indexPosted : Int = -1
    var selectedShare : String = ""
    var selectedSort : String = ""
    var selectedPosted : String = ""
    var arrSelectedTypesOfLottery : String = ""

    var arrTypesOfLottery : [[String: Any]] = [[String : Any]]()
    var arrFilterSort : [[String : Any]] = [[String: Any]]()
    var arrFilterPosted : [[String : Any]] = [[String: Any]]()

    override func viewDidLoad() {
        super.viewDidLoad()
        fillArray()
        slider.value = (selectedShare == "") ? slider.value : Float(selectedShare)!
        setSliderLabel(slider: slider, lblView: viewSlider,lblSlider:lblSlider)
        cltView.reloadData()
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.1) {
            self.cnstrntClnHeight.constant = self.cltView.contentSize.height
        }
       
        indexFromSelected()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=true
    }
    func fillArray() {
        
        arrFilterSort.append(["title" : "My clubs first","sort" : "MCF"])
        arrFilterSort.append(["title" : "Club : newly joined","sort" : "CNJ"])
        arrFilterSort.append(["title" : "Share % : high to low","sort" : "SHL"])
        arrFilterSort.append(["title" : "Share % : low to high","sort" : "SLH"])
        arrFilterSort.append(["title" : "Deadline : ending soonest","sort" : "DES"])
        arrFilterSort.append(["title" : "Members : highest first","sort" : "MHF"])
        arrFilterSort.append(["title" : "Members : lowest first","sort" : "MLF"])
 
        arrFilterPosted.append(["title" : "All Lists","sort" : "AL"])
        arrFilterPosted.append(["title" : "Active only","sort" : "AO"])
        arrFilterPosted.append(["title" : "The last 7days","sort" : "last7"])
        arrFilterPosted.append(["title" : "The last 15days","sort" : "last15"])
        arrFilterPosted.append(["title" : "The last 30days","sort" : "last30"])
        

    }
    
    @IBAction func btnCloseClick(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnResetClick(_ sender: Any) {
         indexSort = -1
        indexPosted = -1
        selectedShare = ""
        selectedSort = "DES"
        selectedPosted = "AL"
        arrSelectedTypesOfLottery = ""
        slider.value = 10
        findClosest(values: [10,20,30,50,70], slider: slider)
        setSliderLabel(slider: slider, lblView: viewSlider,lblSlider:lblSlider)
        cltView.reloadData()
        indexFromSelected()
    }
    @IBAction func btnSaveClick(_ sender: Any) {
        SelectedFromIndex()
        delegate.setData(selectedShare1: selectedShare, selectedSort1: selectedSort, selectedPosted1: selectedPosted, arrSelectedTypesOfLottery1: arrSelectedTypesOfLottery)
        
        self.dismiss(animated: true, completion: nil)
     
    }
    
}

//MARK: UICollectionView Delegates and Datasource
extension FilterVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrTypesOfLottery.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TypesOfLotteryCell", for: indexPath) as! TypesOfLotteryCell
        cell.imgView.image = UIImage(named: "flag_\((arrTypesOfLottery[indexPath.row]["country"] as? String ?? ""))")
        cell.lblTitle.text = (arrTypesOfLottery[indexPath.row]["name"] as! String)
        cell.lblTitle.textColor = (arrTypesOfLottery[indexPath.row]["id"] as! String) == arrSelectedTypesOfLottery ? UIColor.init(hex: "fd5d0f") : UIColor.init(hex: "000000")
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if (arrTypesOfLottery[indexPath.row]["id"] as! String) == arrSelectedTypesOfLottery
        {
            arrSelectedTypesOfLottery = ""
        }
        else
        {
            arrSelectedTypesOfLottery = (arrTypesOfLottery[indexPath.row]["id"] as! String)

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
        cell.btnCheck.isSelected = (tableView == tblViewSortBy) ? indexSort == indexPath.row : indexPosted == indexPath.row
        return cell
    }
}
