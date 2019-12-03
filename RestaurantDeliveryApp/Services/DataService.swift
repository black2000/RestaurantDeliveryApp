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
let REGULAR_RESTAURANTS  = DB_REF.collection("restaurants")
let SWEET_RESTAURANTS  = DB_REF.collection("sweet_restaurants")



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
    
    func loadRestaurants(isRegularRestaurants : Bool , completion : @escaping (_ error : Error? ,_ restaurantArray : [RestaurantModel]? ) -> () ) {
        
        var restaurantCollectionReference =  isRegularRestaurants ? REGULAR_RESTAURANTS : SWEET_RESTAURANTS
        var restaurantArray = [RestaurantModel]()
        
        restaurantCollectionReference.getDocuments { (querySnapshot, error) in
            
            if error != nil {
                completion(error, nil )
            }else {
                for restaurantDocument in querySnapshot!.documents {
                    
                    let restaurantId = restaurantDocument.documentID
                    let restaurantDictionary = restaurantDocument.data()
                    
                    let restaurantTitle = restaurantDictionary["title"] as? String ?? "none"
                    let restaurantDescription =  restaurantDictionary["description"] as? String ?? "none"
                    let restaurantImageUrl = restaurantDictionary["imageUrl"] as? String ?? "restaurants"
                    
                    let restaurantModel = RestaurantModel(id: restaurantId, title: restaurantTitle, description: restaurantDescription, imageUrl: restaurantImageUrl)
                    
                    restaurantArray.append(restaurantModel)
                }
                completion(nil , restaurantArray)
            }
        }
    }
    
    
    func loadRestaurantMenuItems(restaurantId : String , isRegularRestaurants : Bool , isDishes : Bool , completion : @escaping (_ error : Error? ,_ menuItemArray : [MenuItemModel]? ) -> () ) {
        
        var restaurantCollectionReferenceById =  isRegularRestaurants ? REGULAR_RESTAURANTS.document(restaurantId) : SWEET_RESTAURANTS.document(restaurantId)
        
        var menuItemReference =  isDishes ?  restaurantCollectionReferenceById.collection("meals") :  restaurantCollectionReferenceById.collection("drinks")
        
        var menuItemArray = [MenuItemModel]()
        
        menuItemReference.getDocuments { (querySnapshot, error) in
            
            if error != nil {
                completion(error, nil )
            }else {
                for menuItemDocument in querySnapshot!.documents {
                    
                    let menuItemId = menuItemDocument.documentID
                    let menuItemDictionary = menuItemDocument.data()
                    
                    let menuItemTitle = menuItemDictionary["title"] as? String ?? "none"
                    let menuItemDescription =  menuItemDictionary["description"] as? String ?? "none"
                    let menuItemImageUrl = menuItemDictionary["imageUrl"] as? String ?? "restaurants"
                    
                    let menuModel = MenuItemModel(id: menuItemId, title: menuItemTitle, description: menuItemDescription, imageUrl: menuItemImageUrl)
                    
                    menuItemArray.append(menuModel)
                }
                completion(nil ,  menuItemArray)
            }
        }
    }
    
    
    func addMenuItemToCart(numberOFSelecteditem: Int ,restaurant : RestaurantModel ,menuItem : MenuItemModel , completion : @escaping (_ error : Error?) -> () ) {
        
        let cartItem = CartItemModel(id: "", restaurantTitle: restaurant.title, menuItemTitle: menuItem.title, countOfMenuItemSelected : numberOFSelecteditem)
        
        USERS.document(UserConfigurations.currentUserID!).collection("cart").addDocument(data: [
            "restaurant_title" :  cartItem.restaurantTitle,
            "menuItem_title" :  cartItem.menuItemTitle,
            "number_of_selected_menuitem" : cartItem.countOfMenuItemSelected
        ]) {
            error in
            if error != nil {
                completion(error)
            }else {
                completion(nil)
            }
        }
    }
    
    
    func clearAllUserCartData(completion : @escaping (_ error : Error?) -> ()){
        
        USERS.document(UserConfigurations.currentUserID!).collection("cart").getDocuments { (snapShot, error) in
            
            if error == nil {
                for document in snapShot!.documents {
                    document.reference.delete(completion: { (error) in
                        if error != nil {
                            completion(error)
                        }else {
                           
                        }
                    })
                }
                completion(nil)
            }
            else {
                completion(error)
            }
        }
    }
    
    
    
    
    func clearSpecificUserCartData(cartId : String ,completion : @escaping (_ error : Error?) -> ()){
        
        USERS.document(UserConfigurations.currentUserID!).collection("cart").getDocuments { (snapShot, error) in
            
            if error == nil {
                for document in snapShot!.documents {
                    
                    if document.documentID == cartId {
                        document.reference.delete(completion: { (error) in
                            if error != nil {
                                completion(error)
                            }else {
                                
                            }
                        })
                    }
    
                }
                completion(nil)
            }else {
                completion(error)
            }
        }
    }
    
    
    
    
    
    private func loadUserCartData(completion : @escaping (_ error : Error? ,_ carts : [CartItemModel]?) -> () ) {
        
        var cartArray = [CartItemModel]()
        
        USERS.document(UserConfigurations.currentUserID!).collection("cart").getDocuments { (snapShot, error) in
            if error != nil {
                completion(error,nil)
            }else {
                
                for document in snapShot!.documents {
                    
                    let id = document.documentID
                    
                    let cartDictionary = document.data()
                    
                    let restaurantName = cartDictionary["restaurant_title"] as? String ?? "none"
                    let menuItemName = cartDictionary["menuItem_title"] as? String ?? "none"
                    let count = cartDictionary["number_of_selected_menuitem"] as? Int ?? 0
                    
                    let cart = CartItemModel(id: id, restaurantTitle: restaurantName, menuItemTitle: menuItemName, countOfMenuItemSelected: count)
                    
                    
                    cartArray.append(cart)
                }
                
                completion(error , cartArray)
            }
        }
    }
    
    
    
    
    func MoveDataFromUserCartToUserHistory(completion : @escaping (_ error : Error?) -> () ) {
        
        loadUserCartData { (error, cartsArray) in
            if error != nil {
                completion(error)
            }else {
                USERS.document(UserConfigurations.currentUserID!).collection("history").addDocument(data: [
                "date_created" : Date() ,
                "carts" : cartsArray!
            ]) {
                error in
                if error != nil {
                    completion(error)
                }else {
                    self.clearAllUserCartData(completion: { (error) in
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
        
        
       
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
