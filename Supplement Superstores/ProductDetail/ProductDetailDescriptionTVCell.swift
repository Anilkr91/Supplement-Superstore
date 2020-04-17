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
    @IBOutlet weak var productDescriptionLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
