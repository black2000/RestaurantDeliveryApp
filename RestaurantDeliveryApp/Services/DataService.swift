//
//  DataService.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/2/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import FirebaseFirestore



let DB_REF =  Firestore.firestore()
let USERS  = DB_REF.collection("users")

class DataService {
    static let instance = DataService()
    
    
    
    func addUser(user : UserModel , completion : @escaping (_ error : Error?) -> () )  {
        USERS.addDocument(data: [
            "email" : user.email,
            "phone" : user.phone
        ]) {
            error in
            if error != nil {
                completion(error)
            }else {
                completion(nil)
            }
        }
        
    }
    
    
}
