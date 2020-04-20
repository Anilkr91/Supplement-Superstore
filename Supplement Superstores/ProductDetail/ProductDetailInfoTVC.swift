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
        self.rightButtonItems(isenabled: true)
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
    
    
     override func rightProfileButtonPressed(_ button: UIButton) {
           if let user = LoginUtils.sharedInstance.getUserToDefaults() {
           let vc = storyboard?.instantiateViewController(withIdentifier: "LoginTVC") as! LoginTVC
           //vc.filterTag =  filterTag
           self.navigationController?.pushViewController(vc, animated: true)
               
           }
       }
       
       override func rightCartButtonPressed(_ button: UIButton) {
           
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
    
    @IBAction func addToCartTapped(_ sender: Any) {
        
        if let product =  product {
            var order = CartModel(price: product.discounted_price, title: product.title, productId: product.id, quantity: 1)
            
            var carts = self.getCartProductInfo()
            
            if updateCart(id: product.id ?? "").count > 0 {
                for i in 0..<carts.count {
                    if carts[i].productId == product.id {
                        order.quantity! = carts[i].quantity! + 1
                        let obj = carts.remove(at: i)
                        print(obj)
                        carts += [order]

                        self.addToCart(orders: carts)
                        break
                    }
                }
                
            } else {
                carts += [order]
                self.addToCart(orders: carts)
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
        
    func updateCart(id: String) -> [CartModel] {
        let carts = self.getCartProductInfo()
        return carts.filter{$0.productId == id}
            
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

    
    @IBAction func buyNowTapped(_ sender: Any) {
        
        let vc = storyboard?.instantiateViewController(withIdentifier: "CartTVC") as! CartTVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}
