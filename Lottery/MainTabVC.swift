//
//  MainTabVC.swift
//  Lotery
//
//  Created by Kavi Patel on 11/01/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class MainTabVC: UITabBarController,UITabBarControllerDelegate{
    var imgArr :[String] = [String]()
   
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController)
    {
        if ((tabBarController.viewControllers?.count)! > tabBarController.selectedIndex )
        {
            let b = tabBarController.viewControllers![tabBarController.selectedIndex] as! UINavigationController
            if tabBarController.selectedIndex == 3 && UserDefaults.standard.value(forKey: "isResultSeen") != nil
            {
                 let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultDetailVC") as! ResultDetailVC
                b.setViewControllers([SecondVC], animated: false)
            }
//            else if tabBarController.selectedIndex == 2 && UserDefaults.standard.value(forKey: "isListLotterySeen") != nil
//            {
//                let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview1VC") as! LotteryPreview1VC
//                b.setViewControllers([SecondVC], animated: false)
//            }
            else
            {
            b.popToRootViewController(animated: false)
            }
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let tabbar:UITabBar = self.tabBar
        
        if viewController is ProfileVC
        {
        tabbar.items![2].image = UIImage(named: "ic_list.png")?.withRenderingMode(.alwaysOriginal)
            
            tabbar.items![4].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 253/255.0, green: 93/255.0, blue: 15/255.0, alpha: 1)], for: .normal)
            tabbar.items![2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(red: 199/255.0
                , green: 199/255.0, blue: 205/255.0, alpha: 1)], for: .normal)
            self.tabBar.tintColor = UIColor.init(red: 199/255.0
                , green: 199/255.0, blue: 205/255.0, alpha: 1)
          //  self.tabBar.tintColor = UIColor.init(red: 253/255.0, green: 93/255.0, blue: 15/255.0, alpha: 1)
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "ProfileVC") as! ProfileVC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            (tabBarController.viewControllers![tabBarController.selectedIndex] as! UINavigationController).present(objPopup, animated: true, completion: nil)
            return false
        }
        else if viewController is LotteryPreview1VC
        {
                tabbar.items![2].image = UIImage(named: "ic_list_active.png")?.withRenderingMode(.alwaysOriginal)
            
            tabbar.items![2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.init(red: 253/255.0, green: 93/255.0, blue: 15/255.0, alpha: 1)], for: .normal)
            tabbar.items![4].setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(red: 199/255.0
                , green: 199/255.0, blue: 205/255.0, alpha: 1)], for: .normal)
            self.tabBar.tintColor = UIColor.init(red: 199/255.0
                , green: 199/255.0, blue: 205/255.0, alpha: 1)
            //  self.tabBar.tintColor = UIColor.init(red: 253/255.0, green: 93/255.0, blue: 15/255.0, alpha: 1)
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview1VC") as! LotteryPreview1VC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            (tabBarController.viewControllers![tabBarController.selectedIndex] as! UINavigationController).present(objPopup, animated: true, completion: nil)
            return false
        }
        else
        {
            tabbar.items![2].image = UIImage(named: "ic_list.png")?.withRenderingMode(.alwaysOriginal)
            self.tabBar.tintColor = UIColor.init(red: 235/255.0
                , green: 91/255.0, blue: 51/255.0, alpha: 1)
            tabbar.items![4].setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(red: 199/255.0
                , green: 199/255.0, blue: 205/255.0, alpha: 1)], for: .normal)
            tabbar.items![2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(red: 199/255.0
                , green: 199/255.0, blue: 205/255.0, alpha: 1)], for: .normal)
            return true
        }
    }
    
    // MARK: - override methods
    @objc func setToPeru(notification: NSNotification) {
        self.tabBar.tintColor = UIColor.init(red: 235/255.0
            , green: 91/255.0, blue: 51/255.0, alpha: 1)
      //  self.tabBar.items![4].image = UIImage(named: "ic_user.png")?.withRenderingMode(.alwaysOriginal)
     
        self.tabBar.items![4].setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(red: 199/255.0
            , green: 199/255.0, blue: 205/255.0, alpha: 1)], for: .normal)
    }
    @objc func setToPeru2(notification: NSNotification) {
        self.tabBar.tintColor = UIColor.init(red: 235/255.0
            , green: 91/255.0, blue: 51/255.0, alpha: 1)
          self.tabBar.items![2].image = UIImage(named: "ic_list.png")?.withRenderingMode(.alwaysOriginal)
        
        self.tabBar.items![2].setTitleTextAttributes([NSAttributedString.Key.foregroundColor:UIColor.init(red: 199/255.0
            , green: 199/255.0, blue: 205/255.0, alpha: 1)], for: .normal)
    }
    @objc func setToPeru1(notification: NSNotification) {
        let t:UIImageView = UIImageView()
        
        t.kf.setImage(with: URL(string: users.profile_pic), placeholder: nil, options: nil, progressBlock: { (a, b) in
            
        }) { (img, error,cac, a) in
            if img != nil
            {
            self.tabBar.items![4].image = self.maskRoundedImage(image: img!).withRenderingMode(.alwaysOriginal)
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru(notification:)), name: Notification.Name("peru"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru1(notification:)), name: Notification.Name("peru1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru2(notification:)), name: Notification.Name("peru2"), object: nil)
        imgArr = ["ic_home","ic_message","ic_list","ic_check","ic_user"]
        self.delegate = self
        for i in 0..<imgArr.count-1 {
            self.tabBar.items?[i].image = UIImage(named: imgArr[i]+".png")?.withRenderingMode(.alwaysOriginal)
          
        }
        let tempArr = users.name.components(separatedBy: " ")
        if tempArr.count != 0
        {
        self.tabBar.items?[4].title = tempArr[0]
        }
        let t:UIImageView = UIImageView()
        
        t.kf.setImage(with: URL(string: users.profile_pic), placeholder: nil, options: nil, progressBlock: { (a, b) in
            
        }) { (img, error,cac, a) in
            if img != nil
            {
            self.tabBar.items![4].image = self.maskRoundedImage(image: img!).withRenderingMode(.alwaysOriginal)
            }
        }
        

    }
    func maskRoundedImage(image: UIImage) -> UIImage {
        let imageView: UIImageView = UIImageView(image: image)
        let layer = imageView.layer
        layer.masksToBounds = true
        layer.cornerRadius = 16
        imageView.contentMode = .scaleAspectFill
imageView.frame = CGRect(x: 0, y: 0, width: 32, height: 32)
        UIGraphicsBeginImageContext(imageView.bounds.size)
        layer.render(in: UIGraphicsGetCurrentContext()!)
        let roundedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return roundedImage!
    }
  
    
}
