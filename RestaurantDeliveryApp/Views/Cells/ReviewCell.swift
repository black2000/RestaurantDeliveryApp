//
//  ReviewCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/19/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import Cosmos
import SwipeCellKit

class ReviewCell: SwipeTableViewCell {

   
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userMessageLbl: UILabel!
    @IBOutlet weak var userRate: CosmosView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.borderWidth = CGFloat(2.0)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = CGFloat(5.0)
    }
    
    func configureCells(userReviewModel : UserReviewModel) {
        
        userEmailLbl.text = userReviewModel.userEmail
        userMessageLbl.text = userReviewModel.message
        
        
        
        userRate.rating = userReviewModel.numberOfStars
        userRate.settings.totalStars = 5
        userRate.settings.starSize = 40
        userRate.settings.fillMode = .precise
        userRate.settings.filledColor = #colorLiteral(red: 0.3176470697, green: 0.07450980693, blue: 0.02745098062, alpha: 1)
        userRate.text = "  (\(userReviewModel.numberOfStars))"
        userRate.settings.updateOnTouch = false
    }
    
    
    
}
