//
//  cellCollection.swift
//  Lotery
//
//  Created by Kavi Patel on 11/01/19.
//  Copyright © 2019 Kavi Patel. All rights reserved.
//

import Foundation
import UIKit

class cellHomeUpperCollection: UICollectionViewCell {
    @IBOutlet weak var lblPrice: UILabel!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var imgTag: UIImageView!
}

class cellHomeStaticOptionList: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}
class LotteryPreviewTopTwoCell: UICollectionViewCell {
    @IBOutlet weak var imageView: UIImageView!
}

//MARK: cell for HomePopUp collection

class cellHomeViewPopPupOptionsCell: UICollectionViewCell {
    
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var viewIndicator: UIView!{
        didSet{
            viewIndicator.layer.cornerRadius = 1.5
            viewIndicator.layer.masksToBounds = true
        }
    }
}
