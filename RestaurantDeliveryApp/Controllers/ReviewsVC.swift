//
//  ReviewsVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/19/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import SwipeCellKit

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
                    self.reviewArray.removeAll()
                    print(self.reviewArray.count)
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {

        if segue.identifier == "toMakeReviewVC" {

            if let makeReviewVC = segue.destination as? MakeReviewVC {
                
                makeReviewVC.IsRegualrRestautarnt = isRegularRestaurant!
                makeReviewVC.restaurantId = restaurantId!
            }
        }else if segue.identifier == "toMakeReviewVCForEditing" {
            
            if let makeReviewVC = segue.destination as? MakeReviewVC {
                
                makeReviewVC.IsRegualrRestautarnt = isRegularRestaurant!
                
                if let selectedReview = sender as? UserReviewModel {
                    makeReviewVC.selectedReview = selectedReview
                }
                
                makeReviewVC.isUpdating = true
            }
        }
     }
    
}



extension ReviewsVC : UITableViewDelegate , UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reviewArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let id = reviewArray[indexPath.row].userId
        
            if let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell") as? ReviewCell  {
                
                let review = reviewArray[indexPath.row]
                cell.configureCells(userReviewModel: review)
                if UserConfigurations.currentUserID == id {
                    cell.delegate = self
                }
                return cell
                
            }else {
                return UITableViewCell()
            }
    
    }
}


extension ReviewsVC : SwipeTableViewCellDelegate {
    
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath, for orientation: SwipeActionsOrientation) -> [SwipeAction]? {
        guard orientation == .right else { return nil }
        
        let deleteAction = SwipeAction(style: .destructive, title: "Delete") { action, indexPath in
        
            let selectedReview = self.reviewArray[indexPath.row]
            
            DataService.instance.removeReview(isRegularRestaurant: self.isRegularRestaurant!, userReview: selectedReview, completion: { (error) in
                
                if error != nil {
                     print(error)
                }else {
                    self.reviewArray.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                }
                
            })
            
            
        }
        
        let editAction = SwipeAction(style: .destructive, title: "Edit") { action, indexPath in
            
            let selectedReview = self.reviewArray[indexPath.row]
            self.performSegue(withIdentifier: "toMakeReviewVCForEditing", sender: selectedReview)
        }
        
        
        // customize the action appearance
        deleteAction.title =  "Delete"
        deleteAction.backgroundColor = #colorLiteral(red: 0.5649692358, green: 0.08132855891, blue: 0, alpha: 1)
        
        editAction.title =  "Edit"
        editAction.backgroundColor = #colorLiteral(red: 0.1960784346, green: 0.3411764801, blue: 0.1019607857, alpha: 1)
        
        return [deleteAction , editAction]
    }
    
}



