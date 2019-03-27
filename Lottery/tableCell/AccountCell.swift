//
//  AccountCell.swift
//  Lotery
//
//  Created by Bipin Patel on 2/2/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class AccountCell: UITableViewCell {

    @IBOutlet var imgView: UIImageView!
    @IBOutlet var imgArrow: UIImageView!
    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var btnSwitch: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func btnSwitchClick(_ sender: UIButton) {
        btnSwitch.isSelected = !sender.isSelected
    }
    
}
