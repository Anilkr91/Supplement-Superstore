//
//  AddressTVC.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class AddressTVC: BaseTableViewController {

    @IBOutlet weak var nametextField: UITextField!
    @IBOutlet weak var addressLine1Textfield: UITextField!
    @IBOutlet weak var addressLine2Textfield: UITextField!
    @IBOutlet weak var cityTextfield: UITextField!
    @IBOutlet weak var stateTextfield: UITextField!
    @IBOutlet weak var countryTextfield: UITextField!
    @IBOutlet weak var pincodeTextfield: UITextField!
    var addresses: AddressModel?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "Address"
        
        if let address = addresses {
            self.nametextField.text = address.line_1
            self.addressLine1Textfield.text = address.line_2
            self.addressLine2Textfield.text = address.line_3
            self.cityTextfield.text = address.city
            self.stateTextfield.text = address.state
            self.countryTextfield.text = address.country
            self.pincodeTextfield.text = address.pincode
            
        }
    }
    
    @IBAction func submitButtonTapped(_ sender: Any) {
            
        let name = nametextField.text!.trimmingCharacters(in: .whitespaces)
        let address1 = addressLine1Textfield.text!.trimmingCharacters(in: .whitespaces)
        let adddress2 = addressLine2Textfield.text!.trimmingCharacters(in: .whitespaces)
        let city = cityTextfield.text!.trimmingCharacters(in: .whitespaces)
        let state = stateTextfield.text!.trimmingCharacters(in: .whitespaces)
        let country = countryTextfield.text!.trimmingCharacters(in: .whitespaces)
        let pincode = pincodeTextfield.text!.trimmingCharacters(in: .whitespaces)
                   
            if name.isEmpty {
                self.show(title: SSConstant.AppName, message: "Name is required")
            } else if address1.isEmpty {
                self.show(title: SSConstant.AppName, message: "Address Line 1 is required")
                
            } else if adddress2.isEmpty {
                self.show(title: SSConstant.AppName, message: "Address Line 2 is required")
                
            } else if city.isEmpty {
                self.show(title: SSConstant.AppName, message: "City is required")
                
            } else if state.isEmpty {
                self.show(title: SSConstant.AppName, message: "State is required")
                
            } else if country.isEmpty {
                self.show(title: SSConstant.AppName, message: "Country Line 2 is required")
                
            } else if pincode.isEmpty {
                self.show(title: SSConstant.AppName, message: "Pincode Line 2 is required")
                
        } else {
                                
               let param = [
                "line_1": name,
                "line_2": address1,
                "line_3": adddress2,
                "state": state,
                "city": city ,
                "country": country ,
                "pincode": pincode]
                
                if let address = addresses {
                    self.updateAddress(id: address.id ?? "", param: param)
                
                } else {
                     self.addAddress(param: param)
                }
            }
        }
        
        func show(title : String, message : String){
            let alertController     =       UIAlertController(title: title, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    
    func addAddress(param: [String: Any]) {
        AddressPostService.executeRequest(params: param, successBlock: { (result) in
           if let result = result {
             print(result)
              

            }
        }) { (error) in
             self.show(title: SSConstant.AppName, message: error ?? "")
        }
    }
    
    func updateAddress(id: String, param: [String: Any]) {
        AddressPutService.executeRequest(id: id, params: param, successBlock: { (result) in
             if let result = result {
                    print(result)

                }
        }) { (error) in
             self.show(title: SSConstant.AppName, message: error ?? "")
        }
    }
}

