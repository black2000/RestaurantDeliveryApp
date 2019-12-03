//
//  OrderVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class OrderVC: UIViewController {

    var selectedRestaurant : RestaurantModel?
    var selectedMenuItem : MenuItemModel?
   

    @IBOutlet weak var menuItemImageView: UIImageView!
    @IBOutlet weak var menuItemTitleLbl: UILabel!
    @IBOutlet weak var selectedItemCountLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if  let menuItem = selectedMenuItem {
             configureViews(menuItemModel: menuItem)
        }
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
    
    
    private func modifyCount(isIncreasing : Bool) {
        
        var count = Int(selectedItemCountLbl.text!)
        
        if isIncreasing {
            count = count! + 1
        }else {
            guard count! >= 2 else {return }
            count = count! - 1
        }
        
        selectedItemCountLbl.text = String(describing : count! )
        
    }

    @IBAction func minusBtnPressed(_ sender: Any) {
        modifyCount(isIncreasing: false)
    
    }
    
    @IBAction func addBtnPressed(_ sender: Any) {
        modifyCount(isIncreasing: true)
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
        performSegue(withIdentifier: "toCartVC", sender: self)
    }
    
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
}
