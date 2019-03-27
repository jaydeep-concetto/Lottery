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
            if tabBarController.selectedIndex == 2 && UserDefaults.standard.value(forKey: "isResultSeen") != nil
            {
                 let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultDetailVC") as! ResultDetailVC
                b.setViewControllers([SecondVC], animated: false)
            }
            else if tabBarController.selectedIndex == 3 && UserDefaults.standard.value(forKey: "isListLotterySeen") != nil
            {
                let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview1VC") as! LotteryPreview1VC
                b.setViewControllers([SecondVC], animated: false)
            }
            else
            {
            b.popToRootViewController(animated: false)
            }
        }
    }
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        
        let tabbar:UITabBar = self.tabBar
        let tabbaritem5:UITabBarItem = tabbar.items![4]
        
        if viewController is ProfileNC
        {
            tabbar.items![4].image = UIImage(named: "ic_user_active.png")?.withRenderingMode(.alwaysOriginal)
            self.tabBar.tintColor = UIColor.white
            let objPopup = self.storyboard?.instantiateViewController(withIdentifier: "ProfileNC") as! ProfileNC
            objPopup.modalTransitionStyle = .crossDissolve
            objPopup.modalPresentationStyle = .overFullScreen
            (tabBarController.viewControllers![tabBarController.selectedIndex] as! UINavigationController).present(objPopup, animated: true, completion: nil)
            return false
        }
        else
        {
            self.tabBar.tintColor = UIColor.init(red: 235/255.0
                , green: 91/255.0, blue: 51/255.0, alpha: 1)
            tabbar.items![4].image = UIImage(named: "ic_user.png")?.withRenderingMode(.alwaysOriginal)
            //  tabbaritem5.image = UIImage(named: "ic_user.png")?.withRenderingMode(.alwaysOriginal)
            return true
        }
    }
    
    // MARK: - override methods
    @objc func setToPeru(notification: NSNotification) {
        self.tabBar.tintColor = UIColor.init(red: 235/255.0
            , green: 91/255.0, blue: 51/255.0, alpha: 1)
        self.tabBar.items![4].image = UIImage(named: "ic_user.png")?.withRenderingMode(.alwaysOriginal)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(setToPeru(notification:)), name: Notification.Name("peru"), object: nil)
        imgArr = ["ic_home","ic_message","ic_check","ic_list","ic_user"]
        self.delegate = self
        for i in 0..<imgArr.count {
            self.tabBar.items?[i].image = UIImage(named: imgArr[i]+".png")?.withRenderingMode(.alwaysOriginal)
        }
        //        let ic_home = #imageLiteral(resourceName: "ic_home").withRenderingMode(.alwaysOriginal)
        //        let ic_home_active = #imageLiteral(resourceName: "ic_home_active").withRenderingMode(.alwaysOriginal)
        //        let ic_message = #imageLiteral(resourceName: "ic_message").withRenderingMode(.alwaysOriginal)
        //        let ic_message_active = #imageLiteral(resourceName: "ic_message_active").withRenderingMode(.alwaysOriginal)
        //        let ic_check = #imageLiteral(resourceName: "ic_check").withRenderingMode(.alwaysOriginal)
        //        let ic_check_active = #imageLiteral(resourceName: "ic_check_active").withRenderingMode(.alwaysOriginal)
        //        let ic_list = #imageLiteral(resourceName: "ic_list").withRenderingMode(.alwaysOriginal)
        //        let ic_list_active = #imageLiteral(resourceName: "ic_list_active").withRenderingMode(.alwaysOriginal)
        //        let ic_user = #imageLiteral(resourceName: "ic_user").withRenderingMode(.alwaysOriginal)
        //        let ic_user_active = #imageLiteral(resourceName: "ic_user_active").withRenderingMode(.alwaysOriginal)
        //
        //        var item1 = self.tabBar.items?[0]
        //        item1 = UITabBarItem(title: "", image: ic_home, selectedImage: ic_home_active)
        //
        //        var item2 = self.tabBar.items?[1]
        //        item2 = UITabBarItem(title: "", image: ic_message, selectedImage: ic_message_active)
        //
        //
        //        var item3 = self.tabBar.items?[2]
        //        item3 = UITabBarItem(title: "", image: ic_check, selectedImage: ic_check_active)
        //
        //        var item4 = self.tabBar.items?[3]
        //        item4 = UITabBarItem(title: "", image: ic_list, selectedImage: ic_list_active)
        //
        //        var item5 = self.tabBar.items?[4]
        //        item5 = UITabBarItem(title: "", image: ic_user, selectedImage: ic_user_active)
    }
    
    
}
