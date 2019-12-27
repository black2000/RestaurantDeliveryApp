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
        self.layer.borderWidth = CGFloat(5.0)
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.cornerRadius = CGFloat(10.0)
    }
    
    func configureCells(userReviewModel : UserReviewModel) {
        
        userEmailLbl.text = userReviewModel.userEmail
        userMessageLbl.text = userReviewModel.message
        
        
        
        userRate.rating = userReviewModel.numberOfStars
        userRate.settings.totalStars = 5
        userRate.settings.starSize = 25
        userRate.settings.fillMode = .precise
        userRate.settings.filledColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        userRate.backgroundColor = #colorLiteral(red: 0.9050763249, green: 0.9215643406, blue: 0.9342173338, alpha: 1)
        userRate.text = " (\(String(format: "%.1f",userReviewModel.numberOfStars))"
        userRate.settings.updateOnTouch = false
    }
    
    
    
}
