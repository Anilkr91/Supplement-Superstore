//
//  ProductInfoCVC.swift
//  Supplement Superstores
//
//  Created by mac on 14/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProductInfoCVC: BaseCollectionViewController {

    var products: [ProductModel] = []
    var productImages: [ProductImageModel] = []
    var filterTag = ""
    
    //let dispatchGroup = DispatchGroup()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.rightButtonItems(isenabled: true)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.title = filterTag
        self.getAllProducts()
       
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductInfoCVCell", for: indexPath) as! ProductInfoCVCell
        cell.getProductImages(id: products[indexPath.item].id ?? "")
        //cell.pvc = self
        cell.productLabel.text = products[indexPath.item].title
        cell.productPriceLabel.text = products[indexPath.item].discounted_price
        return cell
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailInfoVC") as! ProductDetailInfoVC
        vc.product = products[indexPath.item]
        self.navigationController?.pushViewController(vc, animated: true)
       // present(vc, animated: true, completion: nil)
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
    
}
  
extension ProductInfoCVC: UICollectionViewDelegateFlowLayout {
    
    fileprivate var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    fileprivate var itemsPerRow: CGFloat {
        return 2
    }
    
    fileprivate var interitemSpace: CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sectionPadding = sectionInsets.left * (itemsPerRow + 1)
        let interitemPadding = max(0.0, itemsPerRow - 1) * interitemSpace
        let availableWidth = collectionView.bounds.width - sectionPadding - interitemPadding
        let widthPerItem = availableWidth / itemsPerRow
        print("========", CGSize(width: widthPerItem, height: widthPerItem))
        //self.itemHeight = widthPerItem
        return CGSize(width: widthPerItem, height: widthPerItem + 110)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}


extension ProductInfoCVC {
    
    func getAllProducts() {
         //  self.dispatchGroup.enter()
           ProductsGetService.executeRequest(params: [:], successBlock: { (results) in
               if let results = results {
                self.products = results.all.filter{$0.category?.name == self.filterTag}
                
//                for product in self.products {
//                    print("prodictlh")
//                    self.getProductImages(id: product.id ?? "")
//                }
self.collectionView.reloadData()
               }
            
               
           }) { (errorMessage) in
               print(errorMessage)
           }
       }
    
    
   
        
            
}
