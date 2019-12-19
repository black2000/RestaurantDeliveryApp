//
//  UserReviewModel.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/19/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import Foundation

struct UserReviewModel {
    var id : String? = ""
    var userId :String
    var restaurantId : String
    var userEmail : String
    var message : String
    var numberOfStars : Double
}
