//
//  ProductDetailInfoVC.swift
//  Supplement Superstores
//
//  Created by mac on 14/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Kingfisher
import UIKit

class ProductDetailInfoVC: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var tableView: UITableView!
    var product: ProductModel?
    var productImages: [ProductImageModel] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        self.rightButtonItems(isenabled: true)
        self.title = "Code Supplement"
        tableView.estimatedRowHeight = 120
        tableView.tableFooterView = UIView()
        self.getProductImages(id: product?.id ?? "")
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none
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
            cell.delegate = self
            cell.updateCell(products: productImages)
            //cell.pagerView.reloadData()
            return cell
            
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProductDetailDescriptionTVCell", for: indexPath) as! ProductDetailDescriptionTVCell
            cell.productSmallDescription.text = product?.title ?? ""
            cell.productDescriptionLabel.text = product?.description ?? ""
            
            guard let data = (product?.description ?? "").data(using: String.Encoding.unicode)else{return cell}

            try? cell.productDescriptionLabel.attributedText =
               NSAttributedString(data: data,
                               options: [.documentType:NSAttributedString.DocumentType.html],
                    documentAttributes: nil)
            
            cell.updateCellforDiscount(products: product)
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
    
    func getProductImages(id: String) {
        
        ActivityIndicator.shared.showActivityIndicator(onCenter: true, VC: self)
        ProductImageGetService.executeRequest(id: id, successBlock: { (results) in
            self.productImages  = results ?? []
            
            DispatchQueue.main.async {
                ActivityIndicator.shared.hideActivityindicator()
                self.tableView.reloadData()
            }
            
        }) { (errorMessage) in
            ActivityIndicator.shared.hideActivityindicator()
            print(errorMessage)
        }
    }
    
    @IBAction func addToCartTapped(_ sender: Any) {
        
        if let product =  product {
            self.addProduct(product: product)
        }
    }
    
    func addProduct(product:ProductModel) {
        
        var order = CartModel(discounted_price: product.discounted_price, price: product.price, title: product.title, description: product.description, productId: product.id, quantity: 1)
        
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
        
        if let product =  product {
            self.addProduct(product: product)
            let vc = storyboard?.instantiateViewController(withIdentifier: "CartTVC") as! CartTVC
            self.navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}

extension ProductDetailInfoVC: ProductDetailDelegate {
    func didProductImageTap(imageUrl: URL) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ImageZoomVC") as! ImageZoomVC
        vc.imageUrl = imageUrl
        self.present(vc, animated: true)
    }
}
