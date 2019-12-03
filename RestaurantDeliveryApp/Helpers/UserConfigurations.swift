//
//  UserConfigurations.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/2/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import FirebaseAuth



class UserConfigurations {
    static let currentUserID  = Auth.auth().currentUser?.uid
    static let userDefaultKey = "currentRestaurantId"
    
}
