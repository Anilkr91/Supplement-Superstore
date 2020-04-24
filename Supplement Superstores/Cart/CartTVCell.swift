//
//  CartTVCell.swift
//  Supplement Superstores
//
//  Created by mac on 18/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

protocol CartDelegate: class {
    func didDelteCell(cell: CartTVCell)
}

class CartTVCell: UITableViewCell {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var quantitylabel: UILabel!
    
    weak var delegate: CartDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCell(cart: CartModel) {
        
        self.getProductImages(id: cart.productId ?? "")
        productDescriptionLabel.text = cart.title
        quantitylabel.text = "Qty: \(cart.quantity ?? 0)"
        pricelabel.text = "Rs. \(cart.price ?? "")"
        
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        
        if let delegate = delegate {
            delegate.didDelteCell(cell: self)
        }
        
    }
    
    func getProductImages(id: String) {
       
           ProductImageGetService.executeRequest(id: id, successBlock: { (results) in
                   
           if let results = results{
                       
               for result in results.enumerated() {
                               if result.element.sort_order == 1 {
                                   let url = URL(string: result.element.image ?? "")
                                   self.productImage.kf.setImage(with: url)
                                   break;
                               } else if result.element.sort_order == 6 {
                                   let productImage1 = results.filter{$0.sort_order == 1}
                                    if productImage1.count == 0 {
                                       let url = URL(string: result.element.image ?? "")
                                       self.productImage.kf.setImage(with: url)
                                       break;
                                    } else {
                                        let url = URL(string: productImage1[0].image ?? "")
                                       self.productImage.kf.setImage(with: url)
                                   }
                               }
                           }
                       }
                }) { (errorMessage) in
                    print(errorMessage)
                }
           }
}
