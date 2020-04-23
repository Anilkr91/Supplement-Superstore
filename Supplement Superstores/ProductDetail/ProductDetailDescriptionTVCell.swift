//
//  ProductDetailDescriptionTVCell.swift
//  Supplement Superstores
//
//  Created by mac on 17/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class ProductDetailDescriptionTVCell: UITableViewCell {

    @IBOutlet weak var productSmallDescription: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
     @IBOutlet weak var actualpriceLabel: UILabel!
     @IBOutlet weak var discountLabel: UILabel!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellforDiscount(products: ProductModel?) {
        
        if let products = products {
        
    let difference = Double(products.price!)! - Double(products.discounted_price!)!
    let discount: Int = Int(difference / Double(products.price!)! * 100)
    self.discountLabel.text = "(\(discount)% OFF)"
            self.actualpriceLabel.attributedText = "Rs. \(products.price ?? "")".strikeThrough()
            self.priceLabel.text = "Rs. \(products.discounted_price ?? "")"
            
        }
        
    }
}
