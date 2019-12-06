//
//  CustomTableViewCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/5/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = CGFloat(2.0)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = CGFloat(5.0)
    }

}
