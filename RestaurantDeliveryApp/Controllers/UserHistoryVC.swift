//
//  UserHistoryVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/21/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class UserHistoryVC: UIViewController {

    var userHistoryArray = [UserOrderHistoryModel]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
        loadUserHistory()
    }
    
    private func loadUserHistory() {
    
        DataService.instance.loadUserOrderHistory { (error, data) in
            
            if error != nil {
                print(error!)
            }else {
                if let returnedHistoryData = data {
                    self.userHistoryArray = returnedHistoryData
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    @IBAction func signoutBtnPressed(_ sender: Any) {
        UserConfigurations.moveToLoginVC()
    }
    
}

extension UserHistoryVC : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userHistoryArray.count
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
       
        let orderDateLbl = UILabel()
        orderDateLbl.font = UIFont(name: "font name", size: 50)
        orderDateLbl.textAlignment = .center
        orderDateLbl.text = userHistoryArray[section].dateOrderCreated
        orderDateLbl.backgroundColor = #colorLiteral(red: 0.9960784314, green: 0.231372549, blue: 0.2941176471, alpha: 1)
        orderDateLbl.textColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return orderDateLbl
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(50)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userHistoryArray[section].cartArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        let cartArray = userHistoryArray[indexPath.section].cartArray
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "CartItemCell") as? CartItemCell {
            
            let cartItem = cartArray[indexPath.row]
            
            cell.configureViews(cartItemModel: cartItem)
            
            return cell
        }else {
            return UITableViewCell()
        }
        
        
    }
    
    
    
    
    
    
    
}



