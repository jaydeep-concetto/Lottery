//
//  WinningRewardVC.swift
//  Lotery
//
//  Created by Bipin Patel on 2/8/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class WinningRewardPopupOneVC: BaseViewController {

    @IBOutlet weak var lblChip: UILabel!
    var chipAmount:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
lblChip.text = chipAmount
        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnHelpClicked(_ sender: UIButton) {
    }
    

}
