//
//  ViewController.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/2/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {

    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func loginBtnPressed(_ sender: Any) {
        
        if userEmailTextField.text != "" && userPasswordTextField.text != "" {
            
            let user = UserModel(id: "", email: userEmailTextField.text!, password:userPasswordTextField.text!, phone: "")
            
            AuthService.instance.LoginUser(user: user) { (error) in
                if error == nil {
                    UserConfigurations.moveToRestaurantVC()
                }else {
                    print("couldnot login due to error \(error!)")
                }
            }
        }
        
        
        
    }
    
    


}

