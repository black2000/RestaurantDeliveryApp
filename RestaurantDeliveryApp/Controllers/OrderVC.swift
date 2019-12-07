//
//  OrderVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class OrderVC: UIViewController  {

    var selectedRestaurant : RestaurantModel?
    var selectedMenuItem : MenuItemModel?
    
    //for editing
    var isEditingCartItem : Bool = false
    var cartItemForEditing : CartItemModel?
    
    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemTitleLbl: UILabel!
    @IBOutlet weak var selectedItemCountLbl: UILabel!
    
    
    
    @IBOutlet weak var backBarBtn: UIBarButtonItem!
    @IBOutlet weak var cartBarBtn: UIBarButtonItem!
    
    @IBOutlet weak var addToCartBtn: UIButton!
    @IBOutlet weak var updateView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if isEditingCartItem {
            if let existingCartItem = cartItemForEditing {
                configureButtons(isEditingMode: isEditingCartItem)
                configureViewsForEditing(cartItemModel: existingCartItem)
            }
        }else {
            if  let menuItem = selectedMenuItem {
                configureButtons(isEditingMode: isEditingCartItem)
                configureViews(menuItemModel: menuItem)
            }
        }
    }
    
    
    
    
    
    
    private func configureButtons(isEditingMode : Bool) {
            addToCartBtn.isHidden = isEditingMode ? true : false
            addToCartBtn.isEnabled = isEditingMode ? false : true
            updateView.isHidden = isEditingMode ? false : true
        
        backBarBtn.title = isEditingMode ? "" : "< Back"
        cartBarBtn.image = isEditingMode ? nil : UIImage(named : "cart")
        
        backBarBtn.isEnabled = isEditingMode ? false : true
        cartBarBtn.isEnabled = isEditingMode ? false : true
    }
    
    
    
    
    
    private func configureViewsForEditing(cartItemModel : CartItemModel) {
        menuItemImageView.image = UIImage(named : cartItemModel.menuItemImageUrl)
        menuItemTitleLbl.text = cartItemModel.menuItemTitle
        selectedItemCountLbl.text = String(describing: cartItemModel.countOfMenuItemSelected)
    }
    
    
    private func configureViews(menuItemModel : MenuItemModel) {
        menuItemImageView.image = UIImage(named : menuItemModel.imageUrl)
        menuItemTitleLbl.text = menuItemModel.title
    }
    
    
    
    private func addToCart(count : Int ,restaurant : RestaurantModel , menuItem : MenuItemModel) {
        
        DataService.instance.addMenuItemToCart(numberOFSelecteditem: count, restaurant: restaurant, menuItem: menuItem) { (error) in
            if error != nil {
                print("error")
            }else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    
//    private func modifyCount(isIncreasing : Bool) -> Int {
//
//        if isIncreasing {
//            count = count! + 1
//        }else {
//            guard count! >= 2 else {return count!}
//            count = count! - 1
//        }
//
//         return count!
//    }

    @IBAction func minusBtnPressed(_ sender: Any) {
       var num = Int(selectedItemCountLbl.text!)
       guard num! >= 2 else {return}
       num = num! - 1
       selectedItemCountLbl.text = String(describing: num!)
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        var num = Int(selectedItemCountLbl.text!)
        num = num! + 1
        selectedItemCountLbl.text = String(describing: num!)
    }
    
    
    
    
    
    
    @IBAction func addToCartBtnPressed(_ sender: Any) {
        let currentRestaurantId = UserDefaults.standard.string(forKey: UserConfigurations.userDefaultKey)
        
        if let restaurant = selectedRestaurant ,
           let menuItem = selectedMenuItem,
           let count = Int(selectedItemCountLbl.text!){
            
            if currentRestaurantId == nil {
                UserDefaults.standard.set(restaurant.id!, forKey: UserConfigurations.userDefaultKey)
                addToCart(count: count, restaurant: restaurant, menuItem: menuItem)
            }else {
                if currentRestaurantId == restaurant.id {
                    addToCart(count: count, restaurant: restaurant, menuItem: menuItem)
                } else {
                    
                    let alert = UIAlertController(title: "warning", message: "you orderd from a different restastaurant there are 3 options", preferredStyle: .alert)
                    
                    let cancel = UIAlertAction(title: "cancel", style: .cancel) { (_) in
                        self.dismiss(animated: true, completion: nil)
                    }
                    
                    let clearCart = UIAlertAction(title: "clear cart and add new ", style: .default) { (_) in
                        DataService.instance.clearAllUserCartData(completion: { (error) in
                            if error != nil {
                                print("canot clear cart due to \(error!)")
                            }else {
                                UserDefaults.standard.set(restaurant.id!, forKey: UserConfigurations.userDefaultKey)
                                self.addToCart(count: count, restaurant: restaurant, menuItem: menuItem)
                            }
                        })
                    }
                    
                    let goToCart = UIAlertAction(title: "Go To Cart", style: .default) { (_) in
                        self.performSegue(withIdentifier: "toCartVC", sender: self)
                    }
                    
                    alert.addAction(cancel)
                    alert.addAction(clearCart)
                    alert.addAction(goToCart)
                    
                    self.present(alert, animated: true)
                    
                }
            }
        }
    }
    
    @IBAction func cartBtnPressed(_ sender: Any) {
        UserConfigurations.moveToCartVC()
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateBtnPressed(_ sender: Any) {
        guard isEditingCartItem  else {
            return
        }
        
        if let existingCartItem = cartItemForEditing ,
           let count =  Int(selectedItemCountLbl.text!) {
            DataService.instance.updateUserCartData(cartId: existingCartItem.id!, numberOfItemSelected: count) { (error) in
                
                if error != nil {
                    print("error updating data due to error \(error!)")
                }else {
                    UserConfigurations.moveToCartVC()
                }
            }
        }
    }
    
    
    
    @IBAction func cancelUpdateBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "backToCartVC", sender: self)
    }
    
    
}
