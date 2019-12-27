//
//  MakeReviewVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/20/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit
import Cosmos

class MakeReviewVC: UIViewController {
    @IBOutlet weak var userEmailLbl: UILabel!
    @IBOutlet weak var userRate: CosmosView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var addBtn: UIBarButtonItem!
    @IBOutlet weak var editBtn: UIBarButtonItem!
    
    var IsRegualrRestautarnt : Bool?
    var restaurantId : String?
    
    var isUpdating : Bool = false
    var selectedReview : UserReviewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userEmailLbl.text = UserConfigurations.currentUserEmail
       
        self.userRate.settings.starSize = 45
        self.userRate.backgroundColor = #colorLiteral(red: 0.9050763249, green: 0.9215643406, blue: 0.9342173338, alpha: 1)
        self.userRate.settings.totalStars = 5
        self.userRate.settings.filledColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        self.userRate.settings.starMargin = 25
        
        if isUpdating {
            configureViewsForUpdating()
        }else {
             configureViewsForAdding()
        }
        
    }
    
    
    private func configureViewsForAdding() {
        
        
        
        editBtn.title = ""
        editBtn.isEnabled = false
        userRate.rating = 0
       
    }
    
    private func configureViewsForUpdating() {
        
        addBtn.title = ""
        addBtn.isEnabled = false
        
        if let review = selectedReview {
            userRate.rating = review.numberOfStars
            messageTextView.text = review.message
        }
        
    }
    
    
    
    
    @IBAction func addBtnPressed(_ sender: Any) {
        
        
        guard messageTextView.text != "" && userRate.rating != 0 else {return }
        
        let review = UserReviewModel(id: "", userId: UserConfigurations.currentUserID!, restaurantId: restaurantId!, userEmail: UserConfigurations.currentUserEmail!, message: messageTextView.text, numberOfStars: userRate.rating)
        
        DataService.instance.addReview(isRegularRestaurant: IsRegualrRestautarnt!, userReview: review) { (error) in
            
            if error != nil {
               print(error!)
            }else {
              self.dismiss(animated: true, completion: nil)
            }
        }
        
        
        
    }
    
    
    @IBAction func editBtnPressed(_ sender: Any) {
        
        guard messageTextView.text != "" && userRate.rating != 0 else {return }
        
        let review = UserReviewModel(id: selectedReview!.id, userId: UserConfigurations.currentUserID!, restaurantId: selectedReview!.restaurantId, userEmail: UserConfigurations.currentUserEmail!, message: messageTextView.text, numberOfStars: userRate.rating)
        
        
        DataService.instance.editReview(isRegularRestaurant: IsRegualrRestautarnt!, previousRate: (selectedReview!.numberOfStars/10), userReview: review) { (error) in
            if error != nil {
                print(error!)
            }else {
                self.dismiss(animated: true, completion: nil)
            }
        }
        
        
    }
    
    
    @IBAction func cancelBtnPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
