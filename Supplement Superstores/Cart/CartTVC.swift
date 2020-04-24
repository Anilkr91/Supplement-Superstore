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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAllAddresses()
        tableView.tableFooterView = UIView()
        self.title = "Cart"
        self.cart = self.getCartProductInfo()
        self.totalLabel.text = "Total \(self.getTotalAmount())"
        
        
    }
    
    @objc func logout() {
        LoginUtils.sharedInstance.removeUserDefaults()
        AppDelegate.shared().setHomeAsRVC()
    }
    
    @IBAction func addUpdateButtonTapped(_ sender: Any) {
        
        if let user = LoginUtils.sharedInstance.getUserToDefaults() {
            let vc = storyboard?.instantiateViewController(withIdentifier: "AddressTVC") as! AddressTVC
         
         if addresses.count == 0 {
             vc.addresses = nil
         
         } else {
             vc.addresses = addresses[0]
         }
         self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginTVC") as! LoginTVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
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
    
    @IBAction func placeOrderTapped(_ sender: Any) {
        
        let carts = self.getCartProductInfo()
        
        var orders: [[String: Any]] = []
       
        for i in 0..<carts.count {
            let discounted_price = Int(Double(carts[i].discounted_price!)!)
            let price = Int(Double(carts[i].price!)!)
            let order = PlaceOrderModel(discounted_price: discounted_price, price: price, title: carts[i].title, description: carts[i].description, productId: carts[i].productId, quantity: carts[i].quantity).dictionary
            orders.append(order)
           
        }
        
        if addresses.count == 0 {
            print("Add address")
            
        } else {
            let param = ["address": addresses[0].id ?? "",
                         "items": orders
                        ] as [String : Any]
                   print(param)
        }
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
        cell.delegate = self
        cell.updateCell(cart: cart[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

extension CartTVC: CartDelegate {
    func didDelteCell(cell: CartTVCell) {
        
        let indexPath = tableView.indexPath(for: cell)
        print(indexPath)
        
        var carts = self.getCartProductInfo()
             
              for i in 0..<carts.count {
                
                if i == indexPath?.row {
               
                DispatchQueue.main.async {
                    self.cart.remove(at: indexPath!.row)
                    self.tableView.deleteRows(at: [indexPath!], with: .automatic)
                    carts.remove(at: i)
                    self.addToCart(orders: carts)
                    self.cart = self.getCartProductInfo()
                    self.tableView.reloadData()
                     self.totalLabel.text = "Total \(self.getTotalAmount())"
                }
            }
        }
    }
    
        func addToCart(orders: [CartModel]) {
            
            let cartArray = orders
            let defaults = UserDefaults.standard
            let encoder = JSONEncoder()
                                     
            if let encoded = try? encoder.encode(cartArray) {
                defaults.set(encoded, forKey: "Cart")
                defaults.synchronize()
        }
    }
    
    func getTotalAmount() -> Double {
        var total  = 0.0
        for i in 0..<cart.count {

            let price = Double(cart[i].price!)!
            total += price * Double(cart[i].quantity!)
        }
        return total
    }
}
