//
//  LoginTVC.swift
//  Supplement Superstores
//
//  Created by mac on 17/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class LoginTVC: BaseTableViewController {

    
    @IBOutlet weak var passwordtextField: UITextField!
    @IBOutlet weak var phoneNumberTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Login"
        self.rightButtonItems(isenabled: false)
    }

    @IBAction func submitTapped(_ sender: Any) {
            
            let phone = phoneNumberTextfield.text!.trimmingCharacters(in: .whitespaces)
            let password = passwordtextField.text!.trimmingCharacters(in: .whitespaces)
                   
           if phone.isEmpty {
                self.show(title: SSConstant.AppName, message: "Phone Number is required")
                
            } else if password.isEmpty {
                self.show(title: SSConstant.AppName, message: "Password is required")
                
            } else {
            
               let param = [
                "mobile": phone,
                "password": password]
            
                ActivityIndicator.shared.showActivityIndicator(onCenter: true, VC: self)
                LoginPostService.executeRequest(params: param, successBlock: { (result) in
                    if let result = result {
                        ActivityIndicator.shared.hideActivityindicator()
                      LoginUtils.sharedInstance.saveUserToDefaults(login: result)
                        AppDelegate.shared().setHomeAsRVC()
                        
                    }
                    
                }) { (error) in
                    ActivityIndicator.shared.hideActivityindicator()
                    self.show(title: SSConstant.AppName, message: error ?? "")
                }
            }
            
        }
    @IBAction func registerTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "RegisterTVC") as! RegisterTVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func show(title : String, message : String){
        let alertController     =       UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
}
