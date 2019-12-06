//
//  CartVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/4/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import FirebaseAuth

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
        self.dismiss(animated: true, completion: nil)
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
            return cell
        
        }else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == UITableViewCell.EditingStyle.delete {
                let cart = cartItemArray[indexPath.row]
            DataService.instance.clearSpecificUserCartData(cartId: cart.id!) { (error) in
                
                if error != nil {
                    print("error deleting data due to \(error)")
                }else {
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toOrderVCForEdit" {
            
            if let orderVC  = segue.destination as? OrderVC {
                
                if let selectedCartItem = cartItemArray[tableView.indexPathForSelectedRow!.row] as? CartItemModel {
                    orderVC.cartItemForEditing = selectedCartItem
                    orderVC.isEditingCartItem = true
                }
            }
        
        }
        
        
    }
    
    
}