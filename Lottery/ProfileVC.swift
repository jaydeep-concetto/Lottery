//
//  ProfileVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/2/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ProfileVC: BaseViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    @IBOutlet weak var number_of_third_user: UILabel!
    @IBOutlet weak var number_of_fifth_user: UILabel!
    @IBOutlet weak var number_of_wins_user: UILabel!
    @IBOutlet weak var number_of_fourth_user: UILabel!
    @IBOutlet weak var highest_win_club: UILabel!
    @IBOutlet weak var number_of_wins_club: UILabel!
    @IBOutlet weak var number_of_second_user: UILabel!
    @IBOutlet weak var highest_win_user: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblProfileMoney: UILabel!
    @IBOutlet weak var viewDrawer: UIView!
    @IBOutlet weak var constDrawerTraling: NSLayoutConstraint!
    @IBOutlet weak var btnDrawer: UIButton!
    @IBOutlet var view1: UIView!{
        didSet{
//            view1.layer.borderWidth = 1.0
//            view1.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
           view1.roundCorners(corners: [.topLeft, .bottomLeft, .bottomRight], radius: 15.0)
        }
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.constDrawerTraling.constant = 260
        self.tabBarController?.tabBar.isHidden=false
        let a = self.viewDrawer.frame
        UIView.animate(withDuration: 0.3, animations: {
            
            self.btnDrawer.alpha=1
            self.viewDrawer.frame = CGRect(x: a.minX-260, y: a.minY, width: a.width, height: a.height)
        }) { (a) in
            self.constDrawerTraling.constant = 0
        }
        imgProfile.kf.indicatorType = .activity
        imgProfile.kf.setImage(with: URL(string: users.profile_pic), placeholder: UIImage(named: ""), options: nil, progressBlock: nil)
    //    imgProfile.kf.setImage( with: URL(string: users.profile_pic))
        lblName.text = users.name
        lblCity.text = users.email
        number_of_third_user.text = users.number_of_third_user
        number_of_fifth_user.text = users.number_of_fifth_user
        number_of_wins_user.text = users.number_of_wins_user
        number_of_fourth_user.text = users.number_of_fourth_user
        highest_win_club.text = users.highest_win_club
        number_of_wins_club.text = users.number_of_wins_club
        number_of_second_user.text = users.number_of_second_user
        highest_win_user.text = users.highest_win_user
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
     @IBAction func btnDrawerClick(_ sender: Any) {
        let a = self.viewDrawer.frame
        UIView.animate(withDuration: 0.3, animations: {
            
            self.btnDrawer.alpha=0
            self.viewDrawer.frame = CGRect(x: a.minX+260, y: a.minY, width: a.width, height: a.height)
        }) { (a) in
            self.constDrawerTraling.constant = 260
            NotificationCenter.default.post(name: Notification.Name("peru"), object: nil)

            self.dismiss(animated: true, completion: nil)

        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    @IBAction func btnAccountClick(_ sender: Any) {
      
      
        let shareSportVC = self.storyboard?.instantiateViewController(withIdentifier: "AccountVC") as! AccountVC
        self.navigationController?.show(shareSportVC, sender: nil)
    }
    @IBAction func btnHelpClick(_ sender: Any) {
        
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HelpVC") as! HelpVC
        self.navigationController?.show(vc, sender: nil)
    }
    
    @IBAction func btnProfileClick(_ sender: UIButton) {
        let alert = UIAlertController(title: "Choose Image", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: { _ in
            self.openGallery()
        }))
        
        alert.addAction(UIAlertAction.init(title: "Cancel", style: .cancel, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    func openGallery()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func openCamera()
    {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage]! as! UIImage
        uploadimageapi(url: URL_NAME.uploadProfilePic, maindict: ["user_id":users.id], imageKey: "profile_pic", imageValue: image) { (dict) in
            if dict.count != 0
            {
                self.showAlertWithTitle(title: Constant_String.APP_NAME, string: dict["message"] as! String)
                
                    if UserDefaults.standard.value(forKey: "userInfo") != nil
                    {
                        var tempDict1 = UserDefaults.standard.value(forKey: "userInfo") as! Dictionary<String, Any>
                        var tempDict = tempDict1["user"] as! Dictionary<String, String>
                        
                        tempDict["profile_pic"] = (dict["data"] as! Dictionary<String, String>) ["profile_pic"]
                        tempDict1["user"] = tempDict
                        UserDefaults.standard.set(tempDict1, forKey: "userInfo")
                    }
                    users.profile_pic = (dict["data"] as! Dictionary<String, String>) ["profile_pic"]!
                    self.imgProfile.image = image
                NotificationCenter.default.post(name: Notification.Name("peru1"), object: nil)
                }
            
            }
        
        picker.dismiss(animated: true, completion: nil)
    }
    @IBAction func btnAddClick(_ sender: UIButton) {
        view1.isHidden = !view1.isHidden
    }
}
