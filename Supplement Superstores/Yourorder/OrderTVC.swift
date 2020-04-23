//
//  OrderTVC.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderTVC: BaseViewController {

    var orders: [orderModel] = []
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Your Orders"
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        tableView.sectionFooterHeight = 0.0
        
        let nib = UINib(nibName: "headerView", bundle: nil)
        tableView.register(nib, forHeaderFooterViewReuseIdentifier: "headerView")
        
        let nib2 = UINib(nibName: "footerView", bundle: nil)
        tableView.register(nib2, forHeaderFooterViewReuseIdentifier: "footerView")
        
        let button1 = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logout))
        self.navigationItem.setRightBarButtonItems([button1], animated: true)
        getAllOrders()
                            
    }
    
    @objc func logout() {
        LoginUtils.sharedInstance.removeUserDefaults()
        AppDelegate.shared().setHomeAsRVC()
    }
        
    
    func getAllOrders() {
        
        OrderGetService.executeRequest(params: [:], successBlock: { (results) in
            if let results = results {
                self.orders = results.all?.reversed() ?? []
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }) { (errorMessage) in
            print(errorMessage)
        }
    }
}

extension OrderTVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.orders.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders[section].items?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrderCell
        cell.getProductImages(id:  self.orders[indexPath.section].items?[indexPath.row].item?.id ?? "")
//        cell.datelabel.text = "Order date: \n \(self.convertDateFormatter(orders[indexPath.section].created ?? ""))"
       // cell.orderIdLabel.text = "Order id: \(self.orders[indexPath.section].id ?? "")"
//        cell.totalAmountLabel.text = "Total Amount: \n \(self.orders[indexPath.section].total ?? "")"
            //  cell.productImage.text
        cell.productDescriptionLabel.text = self.orders[indexPath.section].items?[indexPath.row].item?.title
        cell.pricelabel.text = "Rs. \(self.orders[indexPath.section].items?[indexPath.row].item?.discounted_price ?? "")"
        cell.quantitylabel.text = "Qty: \(self.orders[indexPath.section].items?[indexPath.row].quantity ?? 0)"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
      func convertDateFormatter(_ date: String) -> String {
        
         let dateFormatter = DateFormatter()
         dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 0)
         let date = dateFormatter.date(from: date)
         dateFormatter.dateFormat = "E MMM dd hh:mm:ss"
         return  dateFormatter.string(from: date!)
     }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView" ) as! headerView
        //headerView.contentView.backgroundColor = .re
        headerView.orderlabel.text =  "Order Id: \(self.orders[section].id ?? "")"
        return headerView
        }

   
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
         
        let footerView = self.tableView.dequeueReusableHeaderFooterView(withIdentifier: "footerView" ) as! footerView
        footerView.backgroundColor = .yellow
        footerView.dateLabel.text =  "Order date: \n \(self.convertDateFormatter(orders[section].created ?? ""))"
        footerView.priceLabel.text = "Total Amount: \n \(self.orders[section].total ?? "")"
        return footerView
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
               return 50 // my custom height
           }
       
       func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 70
       }
    
}
