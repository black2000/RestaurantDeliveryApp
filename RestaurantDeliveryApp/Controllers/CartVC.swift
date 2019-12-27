//
//  CartVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/4/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwipeCellKit

class CartVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var checkOutBtn: UIButton!

    
    var cartItemArray = [CartItemModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        loadCartItems()
    }
    
  
    
    private func checkViews() {
        self.checkOutBtn.isHidden = cartItemArray.count > 0 ? false : true
    }
    
    private func loadCartItems() {
        DataService.instance.loadUserCartData { (error, data) in
            
            if error != nil {
                print("couldnot load cart items due to error \(error!)")
            }else {
                if let returnedArray =  data {
                    self.cartItemArray = returnedArray
                    self.tableView.reloadData()
                    self.checkViews()
                }
            }
        }
    }
    
    
    
    @IBAction func signOutBtnPressed(_ sender: Any) {
       UserConfigurations.moveToLoginVC()
    }
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func checkOutBtnPressed(_ sender: Any) {
        DataService.instance.MoveDataFromUserCartToUserHistory { (error) in
            
            if error != nil {
                print("couldnot checkout due to error \(error!)")
            }else {
                DataService.instance.clearAllUserCartData(completion: { (error) in
                    if error != nil {
                        print("erorr deleting all cart data due to \(error!)")
                    }else {
                        
                        UserDefaults.standard.set(nil, forKey: UserConfigurations.userDefaultKey)
                        
                        self.loadCartItems()
                        
                        let alert = UIAlertController(title: "Congrats", message: "Checkout Success", preferredStyle: .alert)
                        
                        let moveBackToRestaurantVCAction =  UIAlertAction(title: "return to Restaurants Screen", style: .default, handler: { (_) in
                            
                            let storyBoard = UIStoryboard(name: "Main", bundle: nil)
                            let restaurantVC  = storyBoard.instantiateViewController(withIdentifier: "main")
                            let window = (UIApplication.shared.delegate as! AppDelegate).window
                            window?.rootViewController = restaurantVC
                            window?.makeKeyAndVisible()
                        })
                        
                        alert.addAction(moveBackToRestaurantVCAction)
                        self.present(alert, animated: true)
                    }
                })
            }
        }
    }
}

extension CartVC : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return  cartItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       if let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell", for: indexPath) as? CartItemCell {
            
            let cart = cartItemArray[indexPath.row]
            cell.configureViews(cartItemModel: cart)
            cell.delegate = self
            return cell
        
        }else {
            return UITableViewCell()
        }
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toOrderVCForEdit" {
            
            if let orderVC  = segue.destination as? OrderVC {
                
                if let selectedCartItem = sender as? CartItemModel {
                    orderVC.cartItemForEditing = selectedCartItem
                    orderVC.isEditingCartItem = true
                }
            }
        }
    }
    
}


extension CartVC : SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
            
            let cart = self.cartItemArray[indexPath.row]
            
            DataService.instance.clearSpecificUserCartData(cartId: cart.id!) { (error) in
                
                if error != nil {
                    print("error deleting data due to \(error!)")
                }else {
                    self.cartItemArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    self.checkViews()
                }
            }
        }
        
        
        let editAction = SwipeAction(style: .default, title: "Edit") { action, indexPath in
            
            let cart = self.cartItemArray[indexPath.row]
            self.performSegue(withIdentifier: "toOrderVCForEdit", sender: cart)
        }
        
        
        // customize the action appearance
        deleteAction.title =  "Delete"
        deleteAction.backgroundColor = #colorLiteral(red: 0.5649692358, green: 0.08132855891, blue: 0, alpha: 1)
        
        editAction.title =  "Edit"
        editAction.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        return [deleteAction , editAction]
    }
    
}


