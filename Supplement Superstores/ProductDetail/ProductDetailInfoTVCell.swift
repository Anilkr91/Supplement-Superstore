//
//  ProductDetailInfoTVCell.swift
//  Supplement Superstores
//
//  Created by mac on 14/04/20.
//  Copyright © 2020 mac. All rights reserved.
//


import UIKit
import Kingfisher
import FSPagerView

class ProductDetailInfoTVCell: UITableViewCell {
    var products: [ProductImageModel] = []
    
   @IBOutlet weak var pageControl: FSPageControl!
//        didSet {
//
//            self.pageControl.numberOfPages = self.products.count
//            self.pageControl.contentHorizontalAlignment = .center
//            self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
//
//        }
//    }
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(PagerViewCell.self, forCellWithReuseIdentifier: "cell")
           
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
       
        pagerView.itemSize = CGSize(width: self.frame.size.width, height: self.frame.size.height - 80)
        pagerView.automaticSlidingInterval = 5.0
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func updateCell(products: [ProductImageModel]) {
        self.products = products
        self.pageControl.hidesForSinglePage = true
        self.pageControl.numberOfPages = products.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
    }
}

class PagerViewCell: FSPagerViewCell {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

        // remove the default shadow.
        self.contentView.layer.shadowColor = nil
        self.contentView.layer.shadowRadius = 0
        self.contentView.layer.shadowOpacity = 0
        self.contentView.layer.shadowOffset = .zero
    }
}

extension ProductDetailInfoTVCell: FSPagerViewDataSource,FSPagerViewDelegate {

public func numberOfItems(in pagerView: FSPagerView) -> Int {
    return self.products.count
}

public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
     let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
            
    let Url = URL(string: products[index].image ?? "")
    let resource = ImageResource(downloadURL: Url!, cacheKey: "\(Url!)")
    cell.imageView?.kf.setImage(with: resource)
    cell.imageView?.contentMode = .scaleAspectFit
    //cell.imageView?.clipsToBounds = true
    return cell
}

// MARK:- FSPagerView Delegate

func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {

}

func pagerViewWillEndDragging(_ pagerView: FSPagerView, targetIndex: Int) {
       self.pageControl.currentPage = targetIndex
   }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}
