//
//  MenuItemCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class MenuItemCell: UITableViewCell {

    @IBOutlet weak var menuItemImageView: UIImageView!
    
    @IBOutlet weak var menuItemTitleLbl: UILabel!
    
    @IBOutlet weak var menuItemDescriptionLbl: UILabel!
    
    
    
    func configureViews(menuItemModel : MenuItemModel) {
        menuItemImageView.image = UIImage(named : menuItemModel.imageUrl)
        menuItemTitleLbl.text = menuItemModel.title
        menuItemDescriptionLbl.text = menuItemModel.description
    }
}
