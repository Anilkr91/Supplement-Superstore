//
//  ProductInfoCVCell.swift
//  Supplement Superstores
//
//  Created by mac on 14/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProductInfoCVCell: UICollectionViewCell {
    
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    weak var pvc: ProductInfoCVC?
       override func awakeFromNib() {
           super.awakeFromNib()
    }
    
    func getProductImages(id: String) {
            
                     ProductImageGetService.executeRequest(id: id, successBlock: { (results) in
                        
                        if let results = results{
                            
                            for result in results.enumerated() {
                                    if result.element.sort_order == 1 {
                                        let url = URL(string: result.element.image ?? "")
                                        self.productImageView.kf.setImage(with: url)
                                        break;
                                    } else if result.element.sort_order == 6 {
                                        let productImage1 = results.filter{$0.sort_order == 1}
                                         if productImage1.count == 0 {
                                            let url = URL(string: result.element.image ?? "")
                                            self.productImageView.kf.setImage(with: url)
                                            break;
                                         } else {
                                             let url = URL(string: productImage1[0].image ?? "")
                                            self.productImageView.kf.setImage(with: url)
                                        }
                                    }
                                }
                            }
                     }) { (errorMessage) in
                         print(errorMessage)
                     }
                }
}

