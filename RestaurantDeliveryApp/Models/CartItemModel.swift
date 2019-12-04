//
//  CartItemModel.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import Foundation


struct CartItemModel {
    var id : String? = ""
    var restaurantImageUrl : String
    var restaurantTitle : String
    var menuItemImageUrl : String
    var menuItemTitle : String
    var countOfMenuItemSelected : Int
}
