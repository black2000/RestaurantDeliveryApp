//
//  CartItemCell.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/4/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

protocol cellSegueProtocol {
    func moveToOrderVCForEdit(_ sender : UIButton)
}



class CartItemCell: CustomTableViewCell {

    
    @IBOutlet weak var restaurantImageView: UIImageView!
    @IBOutlet weak var restaurantTitleLbl: UILabel!
    @IBOutlet weak var menuItemTitleLbl: UILabel!
    @IBOutlet weak var numOfSelectedmenuitemLbl: UILabel!
    
    @IBOutlet weak var editBtn: UIButton!
    
    var delegate : cellSegueProtocol?
    
    
    @IBAction func editBtnPressed(_ sender: Any) {
       
        guard delegate != nil else {return}
        delegate!.moveToOrderVCForEdit(sender as! UIButton)
    }
    
    
    
    
    func configureViews(cartItemModel : CartItemModel) {
        
        restaurantImageView.image = UIImage(named: cartItemModel.restaurantImageUrl)
        
        restaurantTitleLbl.text = cartItemModel.restaurantTitle
        
        menuItemTitleLbl.text = cartItemModel.menuItemTitle
        
        numOfSelectedmenuitemLbl.text = String(describing : cartItemModel.countOfMenuItemSelected) 
        
    }
    
}
