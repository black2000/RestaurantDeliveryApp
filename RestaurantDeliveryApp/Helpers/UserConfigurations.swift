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
    
    
    static func moveToRestaurantVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let restaurantVC  = storyBoard.instantiateViewController(withIdentifier: "main")
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.rootViewController = restaurantVC
        window?.makeKeyAndVisible()
    }
    
    
    
    static func moveToCartVC() {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let cartVC  = storyBoard.instantiateViewController(withIdentifier: "cart")
        let window = (UIApplication.shared.delegate as! AppDelegate).window
        window?.rootViewController = cartVC
        window?.makeKeyAndVisible()
    }
    
    
    static func moveToLoginVC() {
        
        do {
            try Auth.auth().signOut()
            
            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC  = storyBoard.instantiateInitialViewController()
            let window = (UIApplication.shared.delegate as! AppDelegate).window
            window?.rootViewController = loginVC
            window?.makeKeyAndVisible()
        }catch {
            
        }
    }
    
}
