//
//  OrderCell.swift
//  Supplement Superstores
//
//  Created by mac on 19/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var datelabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    @IBOutlet weak var totalAmountLabel: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productDescriptionLabel: UILabel!
    @IBOutlet weak var pricelabel: UILabel!
    @IBOutlet weak var quantitylabel: UILabel!
    
    var orders: orderModel?
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
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
