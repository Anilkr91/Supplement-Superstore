//
//  OrderTVC.swift
//  Supplement Superstores
//
//  Created by mac on 18/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CartTVC: BaseViewController {

    var addresses: [AddressModel] = []
    var cart: [CartModel] = []
    
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var namePhoneLabel: UILabel!
    @IBOutlet weak var addressLine2: UILabel!
    @IBOutlet weak var addressLine3: UILabel!
    @IBOutlet weak var tableView: UITableView!
    var total  = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        self.title = "Cart"
        self.cart = self.getCartProductInfo()
        getAllAddresses()
        
        for i in 0..<cart.count {

            let price = Double(cart[i].price!)!
            total += price * Double(cart[i].quantity!)
        }
        self.totalLabel.text = "Total \(total)"
    }
    
    @objc func logout() {
        LoginUtils.sharedInstance.removeUserDefaults()
        AppDelegate.shared().setHomeAsRVC()
    }
    
    @IBAction func addUpdateButtonTapped(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddressTVC") as! AddressTVC
        vc.addresses = addresses[0]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func getAllAddresses() {
        
        AddressGetService.executeRequest(params: [:], successBlock: { (results) in
            if let results = results {
                self.addresses = results.all
                
                DispatchQueue.main.async {
                    self.namePhoneLabel.text = self.addresses[0].line_1
                    self.addressLine2.text = self.addresses[0].line_2
                    self.addressLine3.text = self.addresses[0].line_3
                }
                
            }
            
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
    
     func getCartProductInfo() -> [CartModel] {
           let defaults = UserDefaults.standard
           var cart: [CartModel]? = []
           if let cartObjects = defaults.data(forKey: "Cart"){
           
          // object(forKey: "Cart") as? Data {
               let decoder = JSONDecoder()
               let loadedCartObj = try? decoder.decode([CartModel].self, from: cartObjects)
                     cart = loadedCartObj
           }
           return cart ?? []
       }
}

extension CartTVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "CartTVCell", for: indexPath) as! CartTVCell
        cell.updateCell(cart: cart[indexPath.row])
        return cell
    }
    
}
