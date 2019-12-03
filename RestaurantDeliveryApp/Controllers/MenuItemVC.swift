//
//  MenuItemVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/3/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class MenuItemVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var isRegularRestaurant: Bool?
    var selectedRestaurant : RestaurantModel?
    var menuItemArray : [MenuItemModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        loadMenuItems(isDishes: true)
    }
    
    
    private func loadMenuItems(isDishes : Bool) {
        
        self.menuItemArray.removeAll()
        
        if let restaurant = selectedRestaurant ,
            let isRegulardRestaurant = isRegularRestaurant {
            
            DataService.instance.loadRestaurantMenuItems(restaurantId: restaurant.id!, isRegularRestaurants: isRegulardRestaurant, isDishes: isDishes) { (error, data) in
                
                if let returnedArray = data {
                    self.menuItemArray = returnedArray
                    self.tableView.reloadData()
                }
                
            }
        }
    }
    
    
    
    
    
    @IBAction func segmentedControlValueChanged(_ sender: UISegmentedControl) {
        
        switch sender.selectedSegmentIndex {
        case 0:
            loadMenuItems(isDishes: true)
            break
        case 1:
            loadMenuItems(isDishes: false)
            break
        default :
            return
        }
        
        
    }
    
    
    @IBAction func cartBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toCartVC", sender: self)
    }
    
    @IBAction func backBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}

extension MenuItemVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItemArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "MenuItemCell", for: indexPath) as? MenuItemCell {
         
            let menuItem = menuItemArray[indexPath.row]
            cell.configureViews(menuItemModel: menuItem)
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toOrderVC", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "toOrderVC" {
            if let orderVC  = segue.destination as? OrderVC {
                
                if let selectedMenuItem = menuItemArray[tableView.indexPathForSelectedRow!.row] as? MenuItemModel {
                    orderVC.selectedRestaurant = selectedRestaurant!
                    orderVC.selectedMenuItem = selectedMenuItem
                }
                
                
            }
        }
    }
    
    
    
}
