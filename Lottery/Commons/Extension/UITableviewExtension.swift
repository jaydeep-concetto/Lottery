//
//  UITableviewExtension.swift
//  Restaurants
//
//  Created by Tristate on 08/12/17.
//  Copyright © 2017 Tristate. All rights reserved.
//

import UIKit

extension UITableView {
    
    func hasRowAtIndexPath(indexPath: IndexPath) -> Bool {
        
        return indexPath.section < self.numberOfSections && indexPath.row < self.numberOfRows(inSection: indexPath.section)
    }
    
    func scrollToTopView() {
        let indexPath = IndexPath(row: 0, section: 0)
        if self.hasRowAtIndexPath(indexPath: indexPath) {
            self.scrollToRow(at: indexPath, at: .top, animated: true)
        }
    }
}
