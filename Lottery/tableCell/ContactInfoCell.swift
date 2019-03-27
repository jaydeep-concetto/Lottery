//
//  ContactInfoCell.swift
//  Lotery
//
//  Created by Bipin Patel on 2/2/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ContactInfoCell: UITableViewCell {

    @IBOutlet var lblTitle: UILabel!
    @IBOutlet var txtField: UITextField!
    @IBOutlet var lblVerified: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
