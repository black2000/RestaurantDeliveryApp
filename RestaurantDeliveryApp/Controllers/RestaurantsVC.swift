//
//  RestaurantsVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import FirebaseAuth

class RestaurantsVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var restaurantArray : [RestaurantModel] = []
    var isRegularRestaurant : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadRestaurants(isRegularRestaurants: isRegularRestaurant)
    }
    
    func loadRestaurants(isRegularRestaurants : Bool) {
        
        self.restaurantArray.removeAll()
        DataService.instance.loadRestaurants(isRegularRestaurants: isRegularRestaurants) { (error, data) in
            
            if let returnedArray =  data {
                 self.restaurantArray = returnedArray
                 self.tableView.reloadData()
            }
        }
    }
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            isRegularRestaurant = true
            loadRestaurants(isRegularRestaurants: isRegularRestaurant)
            break
        case 1:
            isRegularRestaurant = false
            loadRestaurants(isRegularRestaurants: isRegularRestaurant)
            break
        default:
            return
        }
        
    }
    
    
    @IBAction func signOutBtnPressed(_ sender: UIBarButtonItem) {
        
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


extension RestaurantsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return restaurantArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "RestaurantCell", for: indexPath) as? RestaurantCell {
            
         let restaurant = restaurantArray[indexPath.row]
         cell.configureViews(restaurantModel: restaurant)
         return cell
            
       }else {
             return UITableViewCell()
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toMenuItemVC", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toMenuItemVC" {
            if let menuItemVC  = segue.destination as? MenuItemVC {
                
                if let selectedRestaurant = restaurantArray[tableView.indexPathForSelectedRow!.row] as? RestaurantModel {
                    menuItemVC.isRegularRestaurant = isRegularRestaurant
                    menuItemVC.selectedRestaurant = selectedRestaurant
                }
                
                
            }
        }
    }
    
    
    
    
}




