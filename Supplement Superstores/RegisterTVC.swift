//
//  RegisterTVC.swift
//  Supplement Superstores
//
//  Created by mac on 18/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class RegisterTVC: BaseTableViewController {

    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    @IBOutlet weak var nameTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Register"
         self.rightButtonItems(isenabled: false)
    }

    @IBAction func submitButtonTapped(_ sender: Any) {
        
        let name = nameTextfield.text!.trimmingCharacters(in: .whitespaces)
        let phone = phoneNumberTextfield.text!.trimmingCharacters(in: .whitespaces)
        let password = passwordtextField.text!.trimmingCharacters(in: .whitespaces)
               
        if name.isEmpty {
            self.show(title: SSConstant.AppName, message: "Name is required")
        } else if phone.isEmpty {
            self.show(title: SSConstant.AppName, message: "Phone Number is required")
            
        } else if password.isEmpty {
            self.show(title: SSConstant.AppName, message: "Password is required")
            
        } else {
            
           let param = [
            "first_name": name,
            "last_name": "",
            "mobile": phone,
            "password1": password,
            "password2": password ]
        
            RegisterPostService.executeRequest(params: param, successBlock: { (result) in
               if let result = result {
                  LoginUtils.sharedInstance.saveUserToDefaults(login: result)
                    AppDelegate.shared().setHomeAsRVC()
                    
                }
            }) { (error) in
                 self.show(title: SSConstant.AppName, message: error ?? "")
            }
        }        
    }
    
    
    @IBAction func loginButtonTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func show(title : String, message : String){
        let alertController     =       UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}
