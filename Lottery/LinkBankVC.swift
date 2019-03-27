//
//  LinkBankVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/5/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class LinkBankVC: BaseViewController {

    @IBOutlet var clnView: UICollectionView!
    @IBOutlet var txtACNumber: UITextField!
    @IBOutlet var txtRoutingNumber: UITextField!
    @IBOutlet var txtYourName: UITextField!
    @IBOutlet var txtReceive: UITextField!
    @IBOutlet var btnSave: UIButton!{
        didSet{
            btnSave.layer.cornerRadius = 30.0
        }
    }
    
    var arrBank: [UIImage]! = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        clnView.delegate = self
        clnView.dataSource = self
        
        arrBank.append(#imageLiteral(resourceName: "america"))
        arrBank.append(#imageLiteral(resourceName: "chase"))
        arrBank.append(#imageLiteral(resourceName: "citibank"))
        arrBank.append(#imageLiteral(resourceName: "wells"))
        arrBank.append(#imageLiteral(resourceName: "kb"))
        arrBank.append(#imageLiteral(resourceName: "mufg"))
        arrBank.append(#imageLiteral(resourceName: "cbank"))
        arrBank.append(#imageLiteral(resourceName: "hsbc"))
        arrBank.append(#imageLiteral(resourceName: "deutsche"))
        arrBank.append(#imageLiteral(resourceName: "rbc"))
        arrBank.append(#imageLiteral(resourceName: "sabtander"))
        arrBank.append(#imageLiteral(resourceName: "agricole"))
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnBAckClick(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnSaveClick(_ sender: Any) {
    }
    
    

}
//MARK: UICollectionView Delegates and Datasource
extension LinkBankVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return arrBank.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "BanckCell", for: indexPath) as! BanckCell
        cell.imgBank.image = (arrBank[indexPath.item] as! UIImage)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize.init(width:100, height: 100)
    }
}
