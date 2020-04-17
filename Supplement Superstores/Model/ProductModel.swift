//
//  ProductModel.swift
//  Supplement Superstores
//
//  Created by mac on 15/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ProductModel: Decodable  {
    
    let id : String?
    let title: String?
    let description: String?
    let price: String?
    let discounted_price: String?
    let stock: Int?
    let category: ProductCategory?
    let branc: ProductBrand?
        
}

struct ProductCategory: Decodable  {
    
     let id : String?
      let name: String?
      let is_active: Bool?
      let image: String?
        
}

struct ProductBrand: Decodable  {
    
    let id : String?
    let name: String?
        
}

struct AllProducts: Decodable {
  let all: [ProductModel]
  
  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}
