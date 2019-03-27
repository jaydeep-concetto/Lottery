//
//  ListLotteryVC.swift
//  Lottery
//
//  Created by Vachhani Jaydeep on 12/02/19.
//  Copyright © 2019 Vachhani Jaydeep. All rights reserved.
//

import UIKit

class ListLotteryVC: BaseViewController {
    @IBOutlet var btnContinue: UIButton!
override func viewWillAppear(_ animated: Bool) {
        self.tabBarController?.tabBar.isHidden=false
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    @IBAction func btnContinueClick(_ sender: Any) {
        let CheckResultVC = self.storyboard?.instantiateViewController(withIdentifier: "CheckListLotteryVC") as! CheckListLotteryVC
        self.navigationController?.show(CheckResultVC, sender: nil)
    }
    @IBAction func btnSkipClick(_ sender: Any) {
        UserDefaults.standard.set(true, forKey: "isListLotterySeen")
        let CheckResultVC = self.storyboard?.instantiateViewController(withIdentifier: "LotteryPreview1VC") as! LotteryPreview1VC
        self.navigationController?.pushViewController(CheckResultVC, animated: true)
        
    }
}
