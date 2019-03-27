//
//  ResultVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/7/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ResultVC: BaseViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
  
    @IBAction func btnContinueClick(_ sender: Any) {
        let CheckResultVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckResultVC") as! CheckResultVC
        self.navigationController?.pushViewController(CheckResultVC, animated: true)
        
    }
    
    @IBAction func btnSkipClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isResultSeen")
        let CheckResultVC = self.storyboard?.instantiateViewController(withIdentifier: "ResultDetailVC") as! ResultDetailVC
        self.navigationController?.pushViewController(CheckResultVC, animated: true)
        
    }
}
