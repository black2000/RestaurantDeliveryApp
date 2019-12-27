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
        restaurantRate.settings.starSize = 25
        restaurantRate.settings.fillMode = .precise
        restaurantRate.settings.filledColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
         restaurantRate.backgroundColor = #colorLiteral(red: 0.9050763249, green: 0.9215643406, blue: 0.9342173338, alpha: 1)
        restaurantRate.text = "  (\(String(format: "%.1f",restaurantModel.numberOfStars))"
        
        restaurantRate.settings.updateOnTouch = false
        
    }
    
}
