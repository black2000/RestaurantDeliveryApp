//
//  RestaurantCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class RestaurantCell: UITableViewCell {

   
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantTitleLbl: UILabel!
    @IBOutlet weak var restaurantDescriptionLbl: UILabel!
    
    
    func configureViews(restaurantModel : RestaurantModel) {
        restaurantImageView.image = UIImage(named : restaurantModel.imageUrl)
        restaurantTitleLbl.text = restaurantModel.title
        restaurantDescriptionLbl.text = restaurantModel.description
    }
    
}
