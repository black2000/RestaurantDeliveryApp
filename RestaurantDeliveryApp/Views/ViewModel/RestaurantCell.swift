//
//  RestaurantCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import Cosmos

class RestaurantCell: CustomTableViewCell {

   
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantTitleLbl: UILabel!
    @IBOutlet weak var restaurantDescriptionLbl: UILabel!
    
    @IBOutlet weak var restaurantRate: CosmosView!
    
    
    override func prepareForReuse() {
        restaurantRate.prepareForReuse()
    }
    
    func configureViews(restaurantModel : RestaurantModel) {
        restaurantImageView.image = UIImage(named : restaurantModel.imageUrl)
        restaurantTitleLbl.text = restaurantModel.title
        restaurantDescriptionLbl.text = restaurantModel.description
        
        restaurantRate.rating = restaurantModel.numberOfStars
        restaurantRate.settings.totalStars = 5
        restaurantRate.settings.starSize = 40
        restaurantRate.settings.fillMode = .precise
        restaurantRate.settings.filledColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        restaurantRate.text = "  (\(restaurantModel.numberOfStars))"
        restaurantRate.settings.updateOnTouch = false
        
    }
    
}
