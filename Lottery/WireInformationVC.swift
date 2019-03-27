//
//  WireInformationVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/4/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class WireInformationVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func btnBack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    @IBAction func btnEnterBack(_ sender: Any) {
        let SecondVC = self.storyboard?.instantiateViewController(withIdentifier: "LinkBankVC") as! LinkBankVC
        
        self.navigationController?.pushViewController(SecondVC, animated: true)
    }
}
