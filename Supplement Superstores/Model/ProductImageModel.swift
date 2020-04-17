//
//  ProductImageModel.swift
//  Supplement Superstores
//
//  Created by mac on 16/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct ProductImageModel: Decodable  {
    
    let id: String?
    let sort_order: Int?
    let image: String?
        
}


struct AllProductImages: Decodable {
  let all: [ProductImageModel]
  
  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}
