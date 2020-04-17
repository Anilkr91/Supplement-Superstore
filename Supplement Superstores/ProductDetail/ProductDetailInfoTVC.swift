//
//  ProductDetailInfoTVC.swift
//  Supplement Superstores
//
//  Created by mac on 14/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import FSPagerView
import Kingfisher
import UIKit

class ProductDetailInfoVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var tableView: UITableView!
    var product: ProductModel?
    var productImages: [ProductImageModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Supplement Superstore"
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        self.getProductImages(id: product?.id ?? "")
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if productImages.count > 0 {
            return 3
        } else {
            return 0
        }
    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailInfoTVCell", for: indexPath) as! ProductDetailInfoTVCell
            cell.products = productImages
            cell.pagerView.reloadData()
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailDescriptionTVCell", for: indexPath) as! ProductDetailDescriptionTVCell
            cell.productSmallDescription.text = product?.title ?? ""
            cell.productDescriptionLabel.text = product?.description ?? ""
            print(cell.productDescriptionLabel.text )
            
            return cell
            
        } else if indexPath.row == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailImageTVCell", for: indexPath) as! ProductDetailImageTVCell
            
            let Url = URL(string: productImages.last?.image ?? "")
            let resource = ImageResource(downloadURL: Url!, cacheKey: "\(Url!)")
            cell.productImageView?.kf.setImage(with: resource)
            cell.productImageView?.contentMode = .scaleAspectFit
            cell.productImageView?.clipsToBounds = true
            return cell
            
        }
        
        
        else {
            return UITableViewCell()
        }
        
    }
    
      func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

            if indexPath.row  == 0 {
                return 275

        } else {
                return UITableView.automaticDimension
        }
    }
    
    
    override func rightSearchButtonPressed(_ button: UIButton) {
         print("teppaedewf")
    }
       
      override func rightOptionButtonPressed(_ button: UIButton) {
           print("rigjtoption")
       }
    
    
    func getProductImages(id: String) {
    
             ProductImageGetService.executeRequest(id: id, successBlock: { (results) in
                print(results)
                self.productImages  = results ?? []
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
             }) { (errorMessage) in
                 print(errorMessage)
             }
         }
}
