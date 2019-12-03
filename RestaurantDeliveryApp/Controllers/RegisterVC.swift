//
//  RegisterVC.swift
//  RestaurantDeliveryApp
//
//  Created by tarek on 12/2/19.
//  Copyright © 2019 tarek. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController {

    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    @IBOutlet weak var userConfirmPasswordTextField: UITextField!
    @IBOutlet weak var userPhoneTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    
    @IBAction func registerBtnPressed(_ sender: Any) {
        
       if userEmailTextField.text != "" &&
          userPasswordTextField.text == userConfirmPasswordTextField.text &&
          userPhoneTextField.text?.count == 11  {
        
            let user = UserModel(id: "", email: userEmailTextField.text!, password: userPasswordTextField.text!, phone: userPhoneTextField.text!)
        
            AuthService.instance.registerUser(user: user) { (error) in
                if error != nil {
                    
                }else {
                    
                }
                
                
            }
        }
    }
    
}
