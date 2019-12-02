//
//  AuthService.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/2/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import FirebaseAuth


class AuthService{
    static let instance = AuthService()
    
    
    func LoginUser(user : UserModel , completion : @escaping (_ error : Error?) -> () ) {
        
        Auth.auth().signIn(withEmail: user.email, password: user.password!) { (data, error) in
            if error != nil {
                completion(error)
            }else {
                completion(nil)
            }
        }
    }
    
    
    func registerUser(user : UserModel , completion : @escaping (_ error : Error?) ->()) {
        
        Auth.auth().createUser(withEmail: user.email, password: user.password!) { (data, error) in
            
            if error != nil {
                completion(nil)
            }else {
                let newlyAddedUser = UserModel(id:data!.user.uid, email: user.email, password: user.password!, phone: user.phone!)
                DataService.instance.addUser(user: newlyAddedUser
                    , completion: { (error) in
                        
                        if error != nil {
                            completion(error)
                        }else {
                            completion(nil)
                        }
                })
            }
        }
    }
    
    
    
}



