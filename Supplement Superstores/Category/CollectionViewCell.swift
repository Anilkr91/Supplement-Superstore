//
//  CollectionCollectionCell.swift
//  Supplement Superstores
//
//  Created by mac on 13/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var ContainerView: UIView!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
}
