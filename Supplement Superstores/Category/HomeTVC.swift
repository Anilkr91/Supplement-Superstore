//
//  HomeTVC.swift
//  Supplement Superstores
//
//  Created by mac on 13/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class HomeTVC: BaseTableViewController {

    var products = [CategoryModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Supplement Superstores"
        self.rightButtonItems(isenabled: true)
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        self.getAllCategories()
        
        print(LoginUtils.sharedInstance.getUserToken())
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        if indexPath.section == 0 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "HomeBannerTVCell", for: indexPath) as! HomeBannerTVCell
                   
               return cell
        
        } else if indexPath.section == 1 {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableCell", for: indexPath) as! HomeTableCell
            
            cell.frame = tableView.bounds
            cell.layoutIfNeeded()
            cell.delegate = self
            cell.products = self.products
            cell.collectionView.reloadData()
            cell.collectionheightConstraint.constant = cell.collectionView.collectionViewLayout.collectionViewContentSize.height
            
        return cell
        } else{
            return UITableViewCell()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return 250
        
        } else {
            return UITableView.automaticDimension
        }
    }
    
    override func rightProfileButtonPressed(_ button: UIButton) {
        if let user = LoginUtils.sharedInstance.getUserToDefaults() {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrderTVC") as! OrderTVC
        self.navigationController?.pushViewController(vc, animated: true)
            
        } else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "LoginTVC") as! LoginTVC
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func rightCartButtonPressed(_ button: UIButton) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartTVC") as! CartTVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeTVC : categoryDelegate{
    func didSelectCategory(filterTag: String) {
      
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductInfoCVC") as! ProductInfoCVC
        vc.filterTag =  filterTag
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getAllCategories() {
        ActivityIndicator.shared.showActivityIndicator(onCenter: true, VC: self)
        CategoriesGetService.executeRequest(params: [:], successBlock: { (results) in
            if let results = results {
                self.products = results.all
                DispatchQueue.main.async {[weak self] in
                    ActivityIndicator.shared.hideActivityindicator()
                    self?.tableView.reloadData()
                }
            }
            
        }) { (errorMessage) in
            ActivityIndicator.shared.hideActivityindicator()
            self.showAlertWithAction(title: SSConstant.AppName, message: errorMessage ?? "") { (true) in
                
            }
        }
    }
}
