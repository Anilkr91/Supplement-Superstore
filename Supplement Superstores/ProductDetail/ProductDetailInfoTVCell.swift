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

protocol ProductDetailDelegate: class {
    func didProductImageTap(imageUrl: URL)
    
}

class ProductDetailInfoTVCell: UITableViewCell {
    var products: [ProductImageModel] = []
    weak var delegate: ProductDetailDelegate?
    
    @IBOutlet weak var pageControl: FSPageControl!
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
       // setupCarousel(products: products)
        self.products = products
        self.pageControl.hidesForSinglePage = true
        let color = UIColor(red: 22/255.0, green: 125/255.0, blue: 210/255.0, alpha: 1)
        pageControl.setFillColor( color, for: .normal)
       // self.pageControl.tintColor = , alpha: 1)
        self.pageControl.numberOfPages = products.count
        self.pageControl.contentHorizontalAlignment = .center
        self.pageControl.contentInsets = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
    }
}

class PagerViewCell: FSPagerViewCell {
    override func didMoveToSuperview() {
        super.didMoveToSuperview()

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
    //cell.imageView?.image = UIImage(named: "home_banner.png")
    cell.imageView?.contentMode = .scaleAspectFit
    //cell.imageView?.clipsToBounds = true
    return cell
}

// MARK:- FSPagerView Delegate

//    func pagerView(_ pagerView: FSPagerView, shouldHighlightItemAt index: Int) -> Bool {
//        return false
//    }
    
    func pagerView(_ pagerView: FSPagerView, didSelectItemAt index: Int) {
        pagerView.deselectItem(at: index, animated: true)
        if let delegate = delegate {
            let Url = URL(string: products[index].image ?? "")!
            delegate.didProductImageTap(imageUrl: Url)
            
        }
    }
    
    func pagerViewDidScroll(_ pagerView: FSPagerView) {
        self.pageControl.currentPage = pagerView.currentIndex
    }
}

 
