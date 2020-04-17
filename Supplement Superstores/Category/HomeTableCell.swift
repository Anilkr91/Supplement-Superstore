//
//  HomeTableCell.swift
//  Supplement Superstores
//
//  Created by mac on 13/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Kingfisher

protocol categoryDelegate: class {
    func didSelectCategory(filterTag: String)
}

class HomeTableCell: UITableViewCell {
    
    var products: [CategoryModel] = []
    weak var delegate: categoryDelegate?
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionheightConstraint: NSLayoutConstraint!
     override func awakeFromNib() {
           super.awakeFromNib()
           collectionView.delegate = self
           collectionView.dataSource = self
           // Initialization code
       }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}


extension HomeTableCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionViewCell", for: indexPath) as! CollectionViewCell
        
        let url = URL(string: products[indexPath.item].image ?? "")
        cell.productImageView.kf.setImage(with: url)
        cell.productLabel.text = products[indexPath.item].name ?? ""
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return products.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let delegate = delegate {
            delegate.didSelectCategory(filterTag: products[indexPath.item].name ?? "")
        }
    }
  
}

extension HomeTableCell: UICollectionViewDelegateFlowLayout {
    
    fileprivate var sectionInsets: UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
    }
    
    fileprivate var itemsPerRow: CGFloat {
        return 2
    }
    
    fileprivate var interitemSpace: CGFloat {
        return 8
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
        return CGSize(width: widthPerItem, height: widthPerItem + 8)
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
