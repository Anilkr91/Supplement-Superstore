//
//  HomeBannerTVCell.swift
//  Supplement Superstores
//
//  Created by mac on 13/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import UIKit
import Kingfisher
import FSPagerView

class HomeBannerTVCell: UITableViewCell {
    
    @IBOutlet weak var pagerView: FSPagerView! {
        didSet {
            self.pagerView.register(PagerViewCell.self, forCellWithReuseIdentifier: "cell")
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.pagerView.automaticSlidingInterval = 3.0
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}

extension HomeBannerTVCell: FSPagerViewDataSource,FSPagerViewDelegate {
    
    public func numberOfItems(in pagerView: FSPagerView) -> Int {
        return 3
    }
    
    public func pagerView(_ pagerView: FSPagerView, cellForItemAt index: Int) -> FSPagerViewCell {
        
        let cell = pagerView.dequeueReusableCell(withReuseIdentifier: "cell", at: index)
        if index  == 0
        {cell.imageView?.image = UIImage(named: "home_banner")}
        else if index  == 1
        {cell.imageView?.image = UIImage(named: "banner2")}
        else if index  == 2
        {cell.imageView?.image = UIImage(named: "banner3")}
        
        cell.imageView?.contentMode = .scaleAspectFit
        //cell.imageView?.clipsToBounds = true
        return cell
    }
}
