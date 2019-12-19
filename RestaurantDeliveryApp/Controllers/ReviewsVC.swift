//
//  ReviewsVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/19/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class ReviewsVC: UIViewController {

    var reviewArray = [UserReviewModel]()
    var isRegularRestaurant : Bool?
    var restaurantId : String?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        loadReviews()
    }
    
    
    private func loadReviews() {
        
        DataService.instance.LoadRestaurantReviews(isRegularRestaurant: isRegularRestaurant!, restaurantId: restaurantId!) { (error, data) in
            
            if error != nil {
                print(error)
            }else {
                if let returnedReviewArray = data {
                    self.reviewArray = returnedReviewArray
                    self.tableView.reloadData()
                }
            }
        }
    }
    
    
    @IBAction func backBtnPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func addReviewBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toMakeReviewVC", sender: self)
    }
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//
//        if segue.identifier == "toMakeReviewVC" {
//
//            if let makeReviewVC = segue.destination as?
//
//
//
//        }
//
//
//    }
    

}



extension ReviewsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as? ReviewCell  {
            
            let review = reviewArray[indexPath.row]
            cell.configureCells(userReviewModel: review)
            return cell
            
        }else {
            return UITableViewCell()
        }
    }
    
}
