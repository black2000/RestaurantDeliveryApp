//
//  CartItemCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/4/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import SwipeCellKit



class CartItemCell: SwipeTableViewCell {

    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantTitleLbl: UILabel!
    @IBOutlet weak var menuItemTitleLbl: UILabel!
    @IBOutlet weak var numOfSelectedmenuitemLbl: UILabel!
    
    
    
   
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = CGFloat(2.0)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = CGFloat(5.0)
    }
    
    
    func configureViews(cartItemModel : CartItemModel) {
        
        restaurantImageView.image = UIImage(named: cartItemModel.restaurantImageUrl)
        
        restaurantTitleLbl.text = cartItemModel.restaurantTitle
        
        menuItemTitleLbl.text = cartItemModel.menuItemTitle
        
        numOfSelectedmenuitemLbl.text = "   \(cartItemModel.countOfMenuItemSelected) X "
        
    }
    
}
