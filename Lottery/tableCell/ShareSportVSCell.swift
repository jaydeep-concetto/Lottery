//
//  ShareSportVSCell.swift
//  Lotery
//
//  Created by Bipin Patel on 2/1/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import UIKit

class ShareSportVSCell: UITableViewCell {
    @IBOutlet var subView1: UIView!{
        didSet{
            subView1.layer.cornerRadius = 5.0
            subView1.layer.borderColor = #colorLiteral(red: 0.6862745098, green: 0.2823529412, blue: 0.003921568627, alpha: 1)
            subView1.layer.borderWidth = 0.5
        }
    }
    @IBOutlet var subView2: UIView!{
        didSet{
            subView2.layer.cornerRadius = 5.0
            subView2.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
            subView2.layer.borderWidth = 0.5
        }
    }
    @IBOutlet var lblDate: UILabel!
    @IBOutlet var lblTeam: UILabel!
    @IBOutlet var imgTeam1: UIImageView!
    @IBOutlet var lblTeamTitle1: UILabel!
    @IBOutlet var imgTeam2: UIImageView!
    @IBOutlet var lblTeamTitle2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
