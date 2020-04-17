//
//  CategoryModel.swift
//  Supplement Superstores
//
//  Created by mac on 15/04/20.
//  Copyright © 2020 mac. All rights reserved.
//

import Foundation

struct CategoryModel: Decodable  {
    
    let id : String?
    let name: String?
    let is_active: Bool?
    let image: String?
        
}


struct AllCategories: Decodable {
  let all: [CategoryModel]
  
  enum CodingKeys: String, CodingKey {
    case all = "results"
  }
}
